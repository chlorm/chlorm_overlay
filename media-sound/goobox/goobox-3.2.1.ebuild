##       ________   ___       ___
##      /  _____/  /  /      /  /
##     /  /       /  /      /  /
##    /  /       /  /____  /  / _______  _______  ____  ____
##   /  /       /  ___  / /  / /  __  / /  ____/ /    \/    \
##  /  /_____  /  /  / / /  / /  /_/ / /  /     /  /\    /\  \
## /________/ /__/  /_/ /__/ /______/ /__/     /__/  \__/  \__\ TM

EAPI="5"

inherit python autotools eutils

DESCRIPTION="Goobox is a CD player for the GNOME desktop environment"
HOMEPAGE="https://people.gnome.org/~paobac/goobox"
SRC_URI="http://mirrors.chlorm.net/src/${PN)/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libnotify
	media-libs/gstreamer
	>=media-libs/musicbrainz-5.0.0
	media-plugins/gst-plugins-good
	media-plugins/gst-plugins-meta
	>=x11-libs/gtk+-3.8.0"

src_unpack() {
    if has ${a}.tar.xz ${A} ; then
        unpacker ${a}.tar.xz
    fi
}

src_prepare() {
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
}
