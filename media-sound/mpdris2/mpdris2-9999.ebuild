##       ________   ___       ___
##      /  _____/  /  /      /  /
##     /  /       /  /      /  /
##    /  /       /  /____  /  / _______  _______  ____  ____
##   /  /       /  ___  / /  / /  __  / /  ____/ /    \/    \
##  /  /_____  /  /  / / /  / /  /_/ / /  /     /  /\    /\  \
## /________/ /__/  /_/ /__/ /______/ /__/     /__/  \__/  \__\ TM
##
## Author: Cody Opel
## E-mail: codyopel@gmail.com
## Copyright (c) 2014 All Rights Reserved, http://www.chlorm.net
## License: The MIT License - http://opensource.org/licenses/MIT

EAPI="5"

inherit python autotools eutils git-2

MY_PN="${PN/d/D}"

DESCRIPTION="MPRIS v2.1 support for MPD"
HOMEPAGE="http://github.com/eonpatapon/mpDris2"
SRC_URI=""
EGIT_REPO_URI="git://github.com/eonpatapon/mpDris2.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-lang/python-2.5
	>=dev-python/dbus-python-1.2.0
	>=dev-python/notify-python-0.1.1-r3
	>=dev-python/pygobject-2.28.6-r55
	>=dev-python/python-mpd-0.5.3"

src_prepare() {
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
}
