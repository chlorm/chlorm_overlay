##       ________   ___       ___
##      /  _____/  /  /      /  /
##     /  /       /  /      /  /
##    /  /       /  /____  /  / _______  _______  ____  ____
##   /  /       /  ___  / /  / /  __  / /  ____/ /    \/    \
##  /  /_____  /  /  / / /  / /  /_/ / /  /     /  /\    /\  \
## /________/ /__/  /_/ /__/ /______/ /__/     /__/  \__/  \__\ TM

EAPI=5

inherit git-2 user

DESCRIPTION="tool for service discovery, monitoring and configuration."
HOMEPAGE="http://www.consul.io"


EGIT_REPO_URI="https://github.com/hashicorp/consul.git"
EGIT_BRANCH="master"
SRC_URI=""

LICENSE="MPL-2.0"
SLOT="0"
if [[ ${PV} = 9999 ]]; then
    KEYWORDS=""
else
    EGIT_COMMIT="v${PV}"
    KEYWORDS="~amd64 ~arm ~x86"
fi
IUSE="web"

DEPEND="
    >=dev-lang/go-1.2
    dev-lang/nodejs
    web? ( dev-ruby/bundler dev-ruby/sass )"
RDEPEND="${DEPEND}"

pkg_setup() {
    enewgroup consul
    enewuser consul -1 -1 /var/lib/${PN} consul
}

src_compile() {
    # create a suitable GOPATH
    export GOPATH="${WORKDIR}/gopath"
    mkdir -p "$GOPATH" || die

    local MY_S="${GOPATH}/src/github.com/hashicorp/consul"

    # move consul itself in our GOPATH
    mkdir -p "${GOPATH}/src/github.com/hashicorp" || die
    mv "${S}" "${MY_S}" || die

    # piggyback our $S
    ln -sf "${MY_S}" "${S}" || die

    # let's do something fun
    emake

    # build the web UI
    if use web; then
        cp -r "${GOPATH}/src/github.com/hashicorp/consul/ui"
        cd ui
        bundle
        emake dist
    fi
}

src_install() {
    dobin bin/consul

    dodir /etc/consul.d

    for x in /var/{lib,log}/${PN}; do
        keepdir "${x}"
        fowners consul:consul "${x}"
    done

    if use web; then
        insinto /var/lib/${PN}/ui
        doins -r ui/dist/*
    fi

    newinitd "${FILESDIR}/consul-agent.initd" "${PN}-agent"
    newconfd "${FILESDIR}/consul-agent.confd" "${PN}-agent"
    systemd_newunit "${FILESDIR}/consul_at.service" "consul@.service"
}
