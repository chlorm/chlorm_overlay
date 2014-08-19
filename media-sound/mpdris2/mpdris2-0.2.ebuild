##       ________   ___       ___
##      /  _____/  /  /      /  /
##     /  /       /  /      /  /
##    /  /       /  /____  /  / _______  _______  ____  ____
##   /  /       /  ___  / /  / /  __  / /  ____/ /    \/    \
##  /  /_____  /  /  / / /  / /  /_/ / /  /     /  /\    /\  \
## /________/ /__/  /_/ /__/ /______/ /__/     /__/  \__/  \__\ TM

EAPI="5"

inherit python autotools eutils

DESCRIPTION="MPRIS v2.1 support for MPD"
HOMEPAGE="http://github.com/eonpatapon/mpDris2"
SRC_URI="http://mirrors.chlorm.net/src/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
	EGIT_HAS_SUBMODULES=true
else
	KEYWORDS="~amd64 ~arm ~x86"
fi
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