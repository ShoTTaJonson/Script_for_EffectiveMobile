PROCESS_NAME="test"
URL="https://test.com/monitoring/test/api"
LOG_FILE="/var/log/monitoring.log"
STATUS_FILE="/var/run/monitor_test.status"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

current_status="not running"
if pgrep -x "$PROCESS_NAME" > /dev/null; then
    current_status="running"
fi

if [ -f "$STATUS_FILE" ]; then
    previous_status=$(cat "$STATUS_FILE")
else
    previous_status="not running"
fi

if [ "$current_status" = "running" ] && [ "$previous_status" != "running" ]; then
    log_message "Process $PROCESS_NAME was restarted."
fi

echo "$current_status" > "$STATUS_FILE"

if [ "$current_status" = "running" ]; then
    if curl -s -f --max-time 10 "$URL" > /dev/null; then
        exit 0
    else
        log_message "Monitoring server is unavailable."
        exit 1
    fi
fi
