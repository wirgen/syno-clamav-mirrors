# syno-clamav-mirrors

![GitHub last commit](https://img.shields.io/github/last-commit/wirgen/syno-clamav-mirrors)

This patch setup a mirror of antivirus updates on any of the presented lists.

### Requirements:
- DiskStation Manager 7
- Installed package "Antivirus Essential"
- SSH/Terminal Access
- sudo/root

## Available mirrors
- https://database.clamav.net
- https://packages.microsoft.com/clamav
- https://pivotal-clamav-mirror.s3.amazonaws.com
- https://clamavdb.c3sl.ufpr.br
- https://www.syscu.net/download/clamav
- https://clmvupd.deltamoby.ru
- https://clamav.mirror.eterfund.ru
- https://clamav.mirror.eterfund.org

## Manual

### Downloading and making script executable

```bash
wget https://raw.githubusercontent.com/wirgen/syno-clamav-mirrors/main/patch.sh
chmod +x patch.sh
sudo ./patch.sh
```
