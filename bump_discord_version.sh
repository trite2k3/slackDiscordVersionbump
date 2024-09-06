#!/bin/bash
VERSION=$(grep VERSION= /var/lib/sbopkg/SBo/15.0/network/discord/discord.SlackBuild)
VERSION=$(echo $VERSION | sed 's/VERSION=${VERSION:-//' | sed 's/}//')
NEWVERSION=$(echo $VERSION | awk -F. '/[0-9]+\./{$NF++;print}' OFS=.)
sed -i "s/VERSION:-[0-9].[0-9].[0-9][0-9]/VERSION:-$NEWVERSION/" /var/lib/sbopkg/SBo/15.0/network/discord/discord.SlackBuild
sed -i "s/VERSION=\"$VERSION\"/VERSION=\"$NEWVERSION\"/" /var/lib/sbopkg/SBo/15.0/network/discord/discord.info
sed -i "s/MD5SUM_x86_64=\".*\"/MD5SUM_x86_64=\"\"/" /var/lib/sbopkg/SBo/15.0/network/discord/discord.info
sed -i "s/DOWNLOAD_x86_64=\".*\"/DOWNLOAD_x86_64=\"https:\/\/dl.discordapp.net\/apps\/linux\/$NEWVERSION\/discord-$NEWVERSION.deb\"/" /var/lib/sbopkg/SBo/15.0/network/discord/discord.info
DOWNLOADLINK=$(cat /var/lib/sbopkg/SBo/15.0/network/discord/discord.info | grep DOWNLOAD_x86_64 | sed 's/DOWNLOAD_x86_64=\"//' | sed 's/\"//')
wget -P /var/cache/sbopkg "${DOWNLOADLINK}"
ln -s /var/cache/sbopkg/discord-$NEWVERSION.deb /var/lib/sbopkg/SBo/15.0/network/discord/discord-$NEWVERSION.deb
bash /var/lib/sbopkg/SBo/15.0/network/discord/discord.SlackBuild
upgradepkg --install-new /tmp/discord-$NEWVERSION-x86_64-1_SBo.tgz
