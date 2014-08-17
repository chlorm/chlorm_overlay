# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zeitgeist-datahub/zeitgeist-datahub-0.7.0.ebuild,v 1.2 2011/03/05 01:54:44 signals Exp $

EAPI=4
inherit versionator bzr

EBZR_REPO_URI="lp:gnome-media-player"

DESCRIPTION="A simple media player for GNOME that supports libvlc, xine-lib and libgstreamer"
HOMEPAGE="http://launchpad.net/gnome-media-player"
#SRC_URI="http://launchpad.net/zeitgeist-datahub/${MY_PV}/${PV}/+download/${P}.tar.gz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	>=media-video/vlc-1.0.0
	>=media-libs/xine-lib-1.1.16
	media-libs/gstreamer
	dev-cpp/gconfmm
	>=dev-cpp/gtkmm-2.12
	dev-libs/libsigc++:2
	dev-perl/Gtk2-Unique
	dev-libs/dbus-glib"
DEPEND="${CDEPEND}
	dev-util/pkgconfig"


src_unpack() {
	bzr_src_unpack
}

src_configre() {
	# This should go to src_compile, but... (;
	cd "${S}"
	./autogen.sh || die "autogen"
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
