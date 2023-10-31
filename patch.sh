#!/bin/sh

declare -a mirror_list=(
    "packages.microsoft.com/clamav"
    "database.clamav.net"
)

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

echo "Available mirrors:"
PS3="Choose a mirror:"
select option in "${mirror_list[@]}" "Quit"
do
    if [[ $REPLY = "$(( ${#mirror_list[@]}+1 ))" ]]; then
        echo "Goodbye"
        exit 0
    fi

    mirror="$option"
    break
done

sed -i "s|DatabaseMirror .*|DatabaseMirror $mirror|" /var/packages/AntiVirus/target/engine/clamav/etc/freshclam.conf
rm /var/packages/AntiVirus/target/engine/clamav/var/lib/freshclam.dat

echo "AntiVirus configuration has been successfully updated. The package has been restarted."

synopkg restart AntiVirus
