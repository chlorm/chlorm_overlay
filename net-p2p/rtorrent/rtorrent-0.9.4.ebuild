# Copyright 2014 Chlorm.net

EAPI=5

inherit eutils systemd

DESCRIPTION="BitTorrent Client using libtorrent"
HOMEPAGE="http://libtorrent.rakshasa.no/"
SRC_URI="http://mirrors.chlorm.net/src/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~amd64-linux ~arm-linux"
IUSE="color daemon debug ipv6 selinux test xmlrpc"

COMMON_DEPEND="~net-libs/libtorrent-0.13.${PV##*.}
	>=dev-libs/libsigc++-2.2.2:2
	>=net-misc/curl-7.19.1
	sys-libs/ncurses
	selinux? ( sec-policy/selinux-rtorrent )
	xmlrpc? ( dev-libs/xmlrpc-c )"
RDEPEND="${COMMON_DEPEND}
	daemon? ( app-misc/screen )"
DEPEND="${COMMON_DEPEND}
	test? ( dev-util/cppunit )
	virtual/pkgconfig"

DOCS=( doc/rtorrent.rc )

src_prepare() {
	# bug #358271
	epatch "${FILESDIR}"/${PN}-0.9.1-ncurses.patch

	if use color ; then
		epatch "${FILESDIR}"/${P}_color.patch
	fi

	# upstream forgot to include
	cp "${FILESDIR}"/rtorrent.1 "${S}"/doc/ || die
}

src_configure() {
    #patch -Np1 -i "${startdir}/rtorrent.patch"
	# configure needs bash or script bombs out on some null shift, bug #291229
	CONFIG_SHELL=${BASH} econf \
		--disable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_with xmlrpc xmlrpc-c)
}

src_install() {
	default
	doman doc/rtorrent.1

	if use daemon; then
		newinitd "${FILESDIR}/rtorrentd.init" rtorrentd
		newconfd "${FILESDIR}/rtorrentd.conf" rtorrentd
		systemd_newunit "${FILESDIR}/rtorrentd_at.service" "rtorrentd@.service"
	fi
}