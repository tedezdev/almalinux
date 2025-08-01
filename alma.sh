#!/bin/bash

set -e

echo "--------------------------------------------------"
echo "[+] AlmaLinux repo yapılandırması başlatılıyor..."
echo "--------------------------------------------------"

# Yeni repo dosyasını oluştur
cat > /etc/yum.repos.d/almalinux.repo <<EOF
[baseos]
name=AlmaLinux \$releasever - BaseOS
baseurl=https://mirror.alastyr.com/almalinux/\$releasever/BaseOS/\$basearch/os/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux

[appstream]
name=AlmaLinux \$releasever - AppStream
baseurl=https://mirror.alastyr.com/almalinux/\$releasever/AppStream/\$basearch/os/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux

[extras]
name=AlmaLinux \$releasever - Extras
baseurl=https://mirror.alastyr.com/almalinux/\$releasever/extras/\$basearch/os/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux
EOF

echo "[✓] Alastyr mirror repo başarıyla yapılandırıldı."

echo "--------------------------------------------------"
echo "[+] AlmaLinux GPG anahtarı ekleniyor..."
echo "--------------------------------------------------"

rpm --import https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux

echo "[✓] GPG anahtarı başarıyla eklendi."

echo "--------------------------------------------------"
echo "[+] EPEL kuruluyor..."
echo "--------------------------------------------------"

dnf install -y epel-release

echo "[✓] EPEL başarıyla kuruldu."

echo "--------------------------------------------------"
echo "[✓] TÜM İŞLEMLER BAŞARIYLA TAMAMLANDI!"
echo "--------------------------------------------------"
