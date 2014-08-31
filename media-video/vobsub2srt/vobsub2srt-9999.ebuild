##       ________   ___       ___
##      /  _____/  /  /      /  /
##     /  /       /  /      /  /
##    /  /       /  /____  /  / _______  _______  ____  ____
##   /  /       /  ___  / /  / /  __  / /  ____/ /    \/    \
##  /  /_____  /  /  / / /  / /  /_/ / /  /     /  /\    /\  \
## /________/ /__/  /_/ /__/ /______/ /__/     /__/  \__/  \__\ TM

EAPI="5"

inherit git-2

DESCRIPTION="Converts VobSub image subtitles (.sub/.idx) to .srt textual subtitles using tesseract OCR engine"
HOMEPAGE="https://github.com/ruediger/VobSub2SRT"

EGIT_REPO_URI="https://github.com/ruediger/VobSub2SRT.git"
EGIT_BRANCH="master"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=app-text/tesseract-2.04-r1
    >=virtual/ffmpeg-0.6.90"
DEPEND="${RDEPEND}"

src_configure() {
    econf
}

src_compile() {
    emake || die
}

src_install() {
    emake DESTDIR="${D}" install || die
}