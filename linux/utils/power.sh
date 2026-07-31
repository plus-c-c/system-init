#!/bin/bash
# 电源管理配置：短按电源键 → suspend；禁用 USB XHCI 唤醒（保证 s2idle 可靠入睡）

echo "配置电源管理..."

# 1. logind drop-in：电源键 → suspend
# 主配置文件由 systemd 包拥有，用 drop-in 避免升级时被覆盖/产生 .pacnew
echo "部署 logind drop-in（电源键 → suspend）..."
sudo mkdir -p /etc/systemd/logind.conf.d
sudo cp -f ./systemd/logind.conf.d/zz-power-key.conf /etc/systemd/logind.conf.d/
sudo sed -i 's/^HandlePowerKey=suspend/#HandlePowerKey=poweroff/' /etc/systemd/logind.conf
sudo systemctl restart systemd-logind

# 2. 禁用 USB XHCI 唤醒（XHC1/XHC4）
# 保留 XHC0 以允许 USB 外设（鼠标等）唤醒
echo "部署 usb-wakeup-disable.service..."
sudo cp -f ./systemd/usb-wakeup-disable.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable usb-wakeup-disable.service
sudo systemctl start usb-wakeup-disable.service

echo "电源管理配置完成"
