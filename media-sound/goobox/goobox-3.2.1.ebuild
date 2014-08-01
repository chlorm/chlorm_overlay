EAPI="5"

inherit python autotools eutils

DESCRIPTION="Goobox is a CD player for the GNOME desktop environment"
HOMEPAGE="https://people.gnome.org/~paobac/goobox"
SRC_URI="http://mirrors.chlorm.net/src/${PN)/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cdparanoia libnotify"

DEPEND=">=media-libs/gstreamer:1.0
	>=media-libs/musicbrainz-5.0.0
	media-plugins/gst-plugins-meta
	ceparanoia? ( media-plugins/gst-plugins-cdparanoia )
	media-plugins/gst-plugins-good
	>=x11-libs/gtk+-3.8:3
	libnotify? ( x11-libs/libnotify )"

src_unpack {
    if has ${a}.tar.xz ${A} ; then
        unpacker ${a}.tar.xz
    fi
}

src_compile() {
    if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ] ; then
        emake || die "emake failed"
    fi
}

src_install() {
	if [ -f Makefile ] || [ -f GNUmakefile] || [ -f makefile ] ; then
		emake DESTDIR="${D}" install
	fi
}
