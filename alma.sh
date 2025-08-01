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
echo "[+] GPG anahtarları içe aktarılıyor..."
echo "--------------------------------------------------"

# GPG anahtarlarını ekle (AlmaLinux zaten varsa sorun olmaz)
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux

# EPEL GPG key indir ve içe aktar
curl -sS https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-8 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-8

echo "[✓] GPG anahtarları başarıyla içe aktarıldı."

echo "--------------------------------------------------"
echo "[+] DNF önbelleği temizleniyor ve yeniden oluşturuluyor..."
echo "--------------------------------------------------"

dnf clean all
rm -rf /var/cache/dnf
dnf makecache

echo "[✓] DNF önbelleği temizlendi ve yeniden oluşturuldu."

echo "--------------------------------------------------"
echo "[+] EPEL release paketi indiriliyor ve kuruluyor..."
echo "--------------------------------------------------"

# EPEL release indir ve GPG doğrulama olmadan kur
curl -LO https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf install -y epel-release-latest-8.noarch.rpm --nogpgcheck

echo "[✓] EPEL başarıyla kuruldu."

echo "--------------------------------------------------"
echo "[✓] TÜM İŞLEMLER BAŞARIYLA TAMAMLANDI!"
echo "--------------------------------------------------"
