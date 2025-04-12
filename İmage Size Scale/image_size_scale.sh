#!/usr/bin/bash

# Yazar: Burak Alkis
# Date Created: 03.12.2025
# Last Modified: 03.12.2025
# Description:
# sudo bash image-size-scale.sh

# Bu script sunucularda bulunan jpeg , png vb uzantılı görsel dosyaların kalite kaybı olmadan yüzde 50 şekilde scale edilerek boyut düşürmeyi sağlamaktadır.
# Farklı sunucularda kullanılacaksa bazı değişkenlerin değiştirilmesi gerekmektedir.
# Bu scriptin kullanılması gereken sunucularda imagemagick paketi mevcut olması gerekmektedir.

LOG_FILE="/var/log/image-scale.log"  # Log dosyasının yolu

echo "Bu script sudo komutu ile çalıştırılmalıdır"
if [[ ${EUID} != 0 ]]; then
    echo "Lütfen sudo komutunu kullanın"
    exit 1
fi

current_year=$(date +%Y)
visual_main_directory="/uploads"
main_directory_to_process="${visual_main_directory}/${current_year}"

threshold=89
disk_path="/uploads"

current_usage=$(df -h "$disk_path" | awk 'NR==2 {print $5}' | sed 's/%//')

if [[ $current_usage -ge $threshold ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Process başlatılıyor" | tee -a "$LOG_FILE"

    /usr/bin/find "$main_directory_to_process" -size +1M \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.bmp' -o -iname '*.tif' -o -iname '*.gif' \) -exec /usr/bin/convert {} -scale 50% {} \; 2>/dev/null

    echo "$(date '+%Y-%m-%d %H:%M:%S') - Process bitti" | tee -a "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Henüz işlem yapılmasına gerek yok" | tee -a "$LOG_FILE"
fi
