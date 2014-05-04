# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: gnunet-0.10.1.ebuild, v0.1 $

EAPI="2"

inherit eutils autotools

MY_PV="${PV/_/}"

DESCRIPTION="GNUnet is an anonymous, distributed, reputation based network."
HOMEPAGE="http://gnunet.org/"
SRC_URI="http://ftp.gnu.org/gnu/gnunet/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mysql nls sqlite postgres"
# IUSE="mysql nls sqlite postgres TeX pulse opus ogg certool zbar gtk+"
S="${WORKDIR}/${PN}-${MY_PV}"

#tests don't work
RESTRICT="test"

RDEPEND="
	>=net-libs/libmicrohttpd-0.9.30
	>=media-libs/libextractor-0.6.1
	>=sys-devel/libtool-2.2
	>=dev-libs/libunistring-0.9.1.1
	>=net-dns/libidn-1.13
	>=dev-libs/libgcrypt-1.6.0
	>=net-libs/gnutls-3.2.7"

DEPEND="${RDEPEND}
	>=dev-libs/openssl-1.0.1g
	>=dev-libs/gmp-4.0.0
	sys-libs/zlib
	sys-apps/sed
	mysql? ( >=virtual/mysql-5.1 )
    sqlite? ( >=dev-db/sqlite-3.8.0 )
    postgres? ( >=dev-db/postgresql-server-9.3.3 )
	nls? ( sys-devel/gettext )
	>=sci-mathematics/glpk-4.45"

pkg_setup() {
	if ! use mysql && ! use sqlite && ! use postgres; then
		einfo
		einfo "You need to specify at least one of 'mysql' or 'sqlite'"
		einfo "USE flag in order to have properly installed gnunet"
		einfo
		die "Invalid USE flag set"
	fi
}

pkg_preinst() {
	enewgroup gnunetd
	enewuser gnunetd -1 -1 /dev/null gnunetd
}

src_prepare() {
	sed -i 's:@GN_USER_HOME_DIR@:/etc:g' src/include/gnunet_directories.h.in
	AT_M4DIR="${S}/m4" eautoreconf
}

src_compile() {
	local myconf
	myconf=" --with-sudo --with-nssdir=/usr/lib"
	use mysql || myconf="${myconf} --without-mysql"
	use postgres || myconf="${myconf} --without-postgres"
	econf \
		$(use_enable nls) \
		${myconf} || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" -j1 install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	docinto contrib
	dodoc contrib/*
	newinitd "${FILESDIR}"/${PN}.initd-0.10.1 gnunet
	dodir /var/lib/gnunet
	chown gnunetd:gnunetd "${D}"/var/lib/gnunet
}

pkg_postinst() {
	# make sure permissions are ok
	chown -R gnunetd:gnunetd "${ROOT}"/var/lib/gnunet

	ewarn "This ebuild is HIGHLY experimental"
}
