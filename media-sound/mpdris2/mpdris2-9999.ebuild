EAPI="5"

inherit python autotools eutils git-2

MY_PN="${PN/d/D}"

DESCRIPTION="MPRIS v2.1 support for MPD"
HOMEPAGE="http://github.com/eonpatapon/mpDris2"
SRC_URI="" # http://mirrors.chlorm.net/src/${MY_PN}/${MY_PN}-${PV}.tar.bz2"
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