# syno-clamav-mirrors

![GitHub last commit](https://img.shields.io/github/last-commit/wirgen/syno-clamav-mirrors)

This patch setup a mirror of antivirus updates on any of the presented lists.

### Requirements:
- DiskStation Manager 7
- Installed package "Antivirus Essential"
- SSH/Terminal Access
- sudo/root

## Available mirrors
- https://packages.microsoft.com/clamav
- https://database.clamav.net

## Manual

### Downloading and making script executable

```bash
wget https://raw.githubusercontent.com/wirgen/syno-clamav-mirrors/main/patch.sh
chmod +x patch.sh
sudo ./patch.sh
```
