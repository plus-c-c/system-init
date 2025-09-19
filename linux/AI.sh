yay -S --noconfirm --needed ollama-rocm
yay -S --noconfirm --needed python-ollama

ollama pull deepseek-r1

sudo chmod 666 /usr/lib/systemd/system/ollama.service

sudo echo '
[Unit]
Description=Ollama Service
Wants=network-online.target
After=network.target network-online.target

[Service]
ExecStart=/usr/bin/ollama serve
WorkingDirectory=/var/lib/ollama
Environment="HOME=/var/lib/ollama"
Environment="OLLAMA_MODELS=/var/lib/ollama"
Environment="HSA_OVERRIDE_GFX_VERSION=1.5.1"
User=ollama
Group=ollama
Restart=on-failure
RestartSec=3
RestartPreventExitStatus=1
Type=simple
PrivateTmp=yes
ProtectSystem=full
ProtectHome=yes

[Install]
WantedBy=multi-user.target
' > /usr/lib/systemd/system/ollama.service
sudo chmod 644 /usr/lib/systemd/system/ollama.service
sudo systemctl daemon-reload
sudo systemctl enable ollama
sudo systemctl start ollama
