#!/bin/bash
#              GLWTS(Good Luck With That Shit) Public License
#            Copyright (c) Every-fucking-one, except the Author
#
# Everyone is permitted to copy, distribute, modify, merge, sell, publish,
# sublicense or whatever the fuck they want with this software but at their
# OWN RISK.
#
#                             Preamble
#
# The author has absolutely no fucking clue what the code in this project
# does. It might just fucking work or not, there is no third option.
#
#
#                GOOD LUCK WITH THAT SHIT PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION, AND MODIFICATION
#
#  0. You just DO WHATEVER THE FUCK YOU WANT TO as long as you NEVER LEAVE
# A FUCKING TRACE TO TRACK THE AUTHOR of the original product to blame for
# or hold responsible.
#
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
# Good luck and Godspeed.


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
