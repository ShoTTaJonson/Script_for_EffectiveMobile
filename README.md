# Мониторинг процесса test

Скрипт для мониторинга процесса test в среде Linux.

## Установка

## 1. Скопируйте скрипт в /usr/local/bin/:

`bash`
`sudo cp monitor_test.sh /usr/local/bin/`
`sudo chmod +x /usr/local/bin/monitor_test.sh`

## 2. Скопируйте systemd юниты:

`bash`
`sudo cp monitor_test.service monitor_test.timer /etc/systemd/system/`

## 3. Включите и запустите таймер:

`bash`
`sudo systemctl enable monitor_test.timer`
`sudo systemctl start monitor_test.timer`

# Проверка

## Статус таймера:

`bash`
`systemctl status monitor_test.timer`

## Логи скрипта:

`bash`
`tail -f /var/log/monitoring.log`

## Вывод последнего запуска:

`bash`
`journalctl -u monitor_test.service`
