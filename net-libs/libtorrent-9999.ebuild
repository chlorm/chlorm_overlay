EAPI=5

inherit autotools eutils libtool toolchain-funcs git-2

DESCRIPTION="LibTorrent is a BitTorrent library written in C++ for *nix."
HOMEPAGE="http://libtorrent.rakshasa.no/"

EGIT_REPO_URI="https://github.com/rakshasa/libtorrent.git"
EGIT_BRANCH="master"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug ipv6 ssl"

RDEPEND=">=dev-libs/libsigc++-2.2.2:2
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/cppunit
	dev-util/pkgconfig"

src_prepare() {
	./autogen.sh
	elibtoolize
}

src_configure() {
	# the configure check for posix_fallocate is wrong.
	# reported upstream as Ticket 2416.
	local myconf
	echo "int main(){return posix_fallocate();}" > "${T}"/posix_fallocate.c
	if $(tc-getCC) ${CFLAGS} ${LDFLAGS} "${T}"/posix_fallocate.c -o /dev/null 2>/dev/null ; then
		myconf="--with-posix-fallocate"
	else
		myconf="--without-posix-fallocate"
	fi

	# configure needs bash or script bombs out on some null shift, bug #291229
	CONFIG_SHELL=${BASH} econf \
		--disable-dependency-tracking \
		--enable-aligned \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_enable ssl openssl) \
		${myconf}
}

#src_install() {
#	emake DESTDIR="${D}" install || die
#	dodoc AUTHORS NEWS README
#}