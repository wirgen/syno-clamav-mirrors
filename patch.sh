#!/bin/sh

declare -a mirror_list=(
    "packages.microsoft.com/clamav"
    "database.clamav.net"
)

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

declare -a available=()
declare -a result=()

echo "Mirrors testing:"

for i in "${!mirror_list[@]}"; do
    echo -n "$((i+1))/${#mirror_list[@]} ${mirror_list[$i]}... "
    response=$(curl --silent --range 0-511 --write-out "%{http_code}" --output daily.cvd.part "https://${mirror_list[$i]}/daily.cvd")

    if [ $response -lt 300 ] ; then
        name=$(cut -d ":" -f1 daily.cvd.part 2> /dev/null)
        dt=$(cut -d ":" -f2 daily.cvd.part 2> /dev/null)

        if [ "$name" = "ClamAV-VDB" ]; then
            echo "Success"
            result+=("${mirror_list[$i]} > UPD: $dt")
            available+=("${mirror_list[$i]}")
        else
            echo "Failed (Wrong file)"
        fi
    else
        echo "Failed (Error $response)"
    fi

    rm daily.cvd.part 2> /dev/null
done

echo -e "\nAvailable mirrors:"

PS3="Choose a mirror: "
COLUMNS=1
select option in "${result[@]}" "Quit"
do
    if [[ $REPLY = "$(( ${#result[@]}+1 ))" ]]; then
        echo "Goodbye"
        exit 0
    fi

    mirror="${available[${REPLY}-1]}"
    break
done

sed -i "s|DatabaseMirror .*|DatabaseMirror $mirror|" /var/packages/AntiVirus/target/engine/clamav/etc/freshclam.conf
rm /var/packages/AntiVirus/target/engine/clamav/var/lib/freshclam.dat 2> /dev/null

echo -e "\nAntiVirus configuration has been successfully updated. Restarting AntiVirus..."

synopkg restart AntiVirus
