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

EAPI=5
inherit autotools git-2

DESCRIPTION="nftables aims to replace the existing {ip,ip6,arp,eb}tables framework"
HOMEPAGE="http://www.netfilter.org/projects/nftables/"
EGIT_REPO_URI="git://git.netfilter.org/${PN}.git"
EGIT_MASTER="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="man pdf"

RDEPEND="dev-libs/gmp
	net-libs/libmnl
	net-libs/libnftnl
	sys-libs/readline"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	man? ( app-text/docbook2X )
	pdf? ( app-text/docbook-sgml-utils[tetex] )"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --disable-debug
}

src_install() {
	default

	prune_libtool_files --all
}
