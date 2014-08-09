# Copyright 2014 Chlorm.net

EAPI=5

inherit autotools eutils git-2 systemd

DESCRIPTION="BitTorrent Client using libtorrent"
HOMEPAGE="http://libtorrent.rakshasa.no/"

EGIT_REPO_URI="https://github.com/rakshasa/rtorrent.git"
EGIT_BRANCH="master"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="color daemon debug ipv6 selinux test xmlrpc"

COMMON_DEPEND="=net-libs/libtorrent-9999
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
	if use color ; then
		epatch "${FILESDIR}"/${PN}-0.9.4_color.patch
	fi

	./autogen.sh
}

src_configure() {
	CONFIG_SHELL=${BASH} econf \
		--disable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_with xmlrpc xmlrpc-c)
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use daemon; then
		newinitd "${FILESDIR}/rtorrentd.init" rtorrentd
		newconfd "${FILESDIR}/rtorrentd.conf" rtorrentd
		systemd_newunit "${FILESDIR}/rtorrentd_at.service" "rtorrentd@.service"
	fi
}