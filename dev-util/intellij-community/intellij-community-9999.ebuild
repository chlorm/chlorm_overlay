# Chlorm

EAPI=5

inherit eutils versionator git-2

DESCRIPTION="IntelliJ IDEA Community Edition Java IDE"
HOMEPAGE="http://jetbrains.com/idea/"
EGIT_REPO_URI="git://github.com/JetBrains/intellij-community.git"

LICENSE="Apache-2.0"
SLOT="$(get_major_version)"

RESTRICT="strip"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"

KEYWORDS="x86 amd64"
IUSE=""
S="${WORKDIR}/${P}"

RDEPEND=">=dev-java/groovy-1.7.5
		>=virtual/jdk-1.6"

#src_prepare() {
#	epatch ${FILESDIR}/${PN}-${SLOT}.sh.patch || die
#}

src_install() {
	local dir="/opt/${P}"
	local exe="${PN}-${SLOT}"
	newconfd "${FILESDIR}/config-${PN}-${SLOT}" ${PN}-${SLOT}
	# config files
	insinto "/etc/idea"
	mv bin/idea.properties bin/${PN}-${SLOT}.properties
	doins bin/${PN}-${SLOT}.properties
	rm bin/${PN}-${SLOT}.properties
	case $ARCH in
		amd64|ppc64)
			cat bin/idea64.vmoptions > bin/idea.vmoptions
			rm bin/idea64.vmoptions
			;;
	esac
	mv bin/idea.vmoptions bin/${PN}-${SLOT}.vmoptions
	doins bin/${PN}-${SLOT}.vmoptions
	rm bin/${PN}-${SLOT}.vmoptions
	ln -s /etc/idea/${PN}-${SLOT}.properties bin/idea.properties
	ln -s /etc/idea/${PN}-${SLOT}.vmoptions bin/idea.vmoptions
	# idea itself
	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${PN}.sh"
	fperms 755 "${dir}/bin/fsnotifier"
	fperms 755 "${dir}/bin/fsnotifier64"
	newicon "bin/${PN}.png" "${exe}.png"
	make_wrapper "${exe}" "/opt/${P}/bin/${PN}.sh"
	make_desktop_entry ${exe} "IntelliJ IDEA ${PV}" "${exe}" "Development;IDE"
	# Protect idea conf on upgrade
	env_file="${T}/25${PN}-${SLOT}"
	echo "CONFIG_PROTECT=\"\${CONFIG_PROTECT} /etc/idea/conf\"" > "${env_file}"  || die
	doenvd "${env_file}"
}

