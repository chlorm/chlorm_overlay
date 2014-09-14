##       ________   ___       ___
##      /  _____/  /  /      /  /
##     /  /       /  /      /  /
##    /  /       /  /____  /  / _______  _______  ____  ____
##   /  /       /  ___  / /  / /  __  / /  ____/ /    \/    \
##  /  /_____  /  /  / / /  / /  /_/ / /  /     /  /\    /\  \
## /________/ /__/  /_/ /__/ /______/ /__/     /__/  \__/  \__\ TM

EAPI=5

inherit autotools eutils git-2

DESCRIPTION="Management suite for dotfiles"
HOMEPAGE="https://github.com/thoughtbot/rcm"

EGIT_REPO_URI="https://github.com/thoughtbot/rcm.git"
EGIT_BRANCH="master"
EGIT_COMMIT="v${PV}"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
	EGIT_HAS_SUBMODULES=true
else
	KEYWORDS="~amd64 ~arm ~x86"
fi

DEPEND="dev-ruby/mustache"

src_prepare() {
  eautoreconf
  maint/autocontrib man/rcm.7.mustache
}

src_configure() {
  econf
}

src_install() {
  emake DESTDIR="${D}" install
}