# Chlorm

EAPI=5

inherit eutils versionator

DESCRIPTION="IntelliJ IDEA Community Edition Java IDE"
HOMEPAGE="http://jetbrains.com/idea/"
EGIT_REPO_URI="git://git.github.com/JetBrains/intellij-community.git"

LICENSE="Apache-2.0"
SLOT="0"

RESTRICT="strip"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"

KEYWORDS="x86 amd64"
IUSE=""
S="${WORKDIR}/${PN}-IU-${MY_PV}"

RDEPEND=">=virtual/jdk-1.6"

src_install() {
	local dir="/opt/${P}"
	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${PN}.sh"
	fperms 755 "${dir}/bin/fsnotifier"
	fperms 755 "${dir}/bin/fsnotifier64"
	local exe=${PN}-${SLOT}
	local icon=${exe}.png
	newicon "bin/${PN}.png" ${icon}
	dodir /usr/bin
	cat > "${D}/usr/bin/${exe}" <<-EOF
#!/bin/sh
/opt/${P}/bin/${PN}.sh \$@
EOF
	fperms 755 /usr/bin/${exe}
	make_desktop_entry ${exe} "IntelliJ IDEA ${PV}" /opt/${P}/bin/${PN}.png "Development;IDE"
}

