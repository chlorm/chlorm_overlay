##       ________   ___       ___
##      /  _____/  /  /      /  /
##     /  /       /  /      /  /
##    /  /       /  /____  /  / _______  _______  ____  ____
##   /  /       /  ___  / /  / /  __  / /  ____/ /    \/    \
##  /  /_____  /  /  / / /  / /  /_/ / /  /     /  /\    /\  \
## /________/ /__/  /_/ /__/ /______/ /__/     /__/  \__/  \__\ TM

EAPI=5

inherit git-2

DESCRIPTION="Command line pastebin for google app-engine, in use at http://sprunge.us/"
HOMEPAGE="http://sprunge.us/"

if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/rupa/sprunge.git"
	EGIT_BRANCH="master"
else
	SRC_URI="http://mirrors.chlorm.net/src/${PN}/${P}.tar.bz2"
fi

LICENSE=""
SLOT="0"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
	EGIT_HAS_SUBMODULES=true
else
	KEYWORDS="~amd64 ~arm ~x86"
fi
IUSE=""

DEPEND=">=app-shells/bash-4.1_p9
		>=dev-python/pygments-1.6"
RDEPEND="${DEPEND}"

src_install() {
	cd ${DISTDIR}
	dobin ${PN} || die
}

pkg_postinst() {
	elog "Пример/Example -> sprunge /etc/rc.conf"
}