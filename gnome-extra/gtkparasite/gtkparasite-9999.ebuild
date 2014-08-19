##       ________   ___       ___
##      /  _____/  /  /      /  /
##     /  /       /  /      /  /
##    /  /       /  /____  /  / _______  _______  ____  ____
##   /  /       /  ___  / /  / /  __  / /  ____/ /    \/    \
##  /  /_____  /  /  / / /  / /  /_/ / /  /     /  /\    /\  \
## /________/ /__/  /_/ /__/ /______/ /__/     /__/  \__/  \__\ TM

EAPI=5

inherit autotools git-2

DESCRIPTION="Tool for GTK debugging and live interaction"
HOMEPAGE="http://gtkparasite.googlecode.com/"

EGIT_REPO_URI="git://github.com/chipx86/gtkparasite.git"
EGIT_BRANCH="master"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
	EGIT_HAS_SUBMODULES=true
else
	KEYWORDS="~amd64 ~arm ~x86"
fi
IUSE=""

DEPEND="x11-libs/gtk+"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
	cd ${S}
	eautoreconf
}

src_prepare() {
    ./autogen.sh --with-gtk=3.0
}


