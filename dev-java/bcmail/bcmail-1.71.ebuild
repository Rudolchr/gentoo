# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source test"
MAVEN_ID="org.bouncycastle:bcmail-jdk18on:1.71"
JAVA_TESTING_FRAMEWORKS="junit-4"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="The Bouncy Castle Java S/MIME APIs for handling S/MIME protocols"
HOMEPAGE="https://www.bouncycastle.org/java.html"
SRC_URI="https://github.com/bcgit/bc-java/archive/r${PV/./rv}.tar.gz -> bc-java-r${PV/./rv}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 ~ppc64 x86"

CDEPEND="
	~dev-java/bcpkix-${PV}:0
	~dev-java/bcprov-${PV}:0
	~dev-java/bcutil-${PV}:0
	dev-java/jakarta-activation:1
	dev-java/javax-mail:0
	"
DEPEND="${CDEPEND}
	>=virtual/jdk-11:*"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.8:*"

DOCS=( ../{README,SECURITY}.md )
HTML_DOCS=( ../{CONTRIBUTORS,index}.html )

S="${WORKDIR}/bc-java-r${PV/./rv}/mail"

JAVA_GENTOO_CLASSPATH="bcpkix,bcprov,bcutil,jakarta-activation-1,javax-mail"
JAVA_SRC_DIR=(
	"src/main/java"
	"src/main/jdk1.9"	# https://bugs.gentoo.org/797634
)
JAVA_RESOURCE_DIRS="src/main/resources"

JAVA_TEST_GENTOO_CLASSPATH="junit-4"
JAVA_TEST_SRC_DIR="src/test/java"
JAVA_TEST_RESOURCE_DIRS="src/test/resources"
JAVA_TEST_RUN_ONLY="org.bouncycastle.mail.smime.test.AllTests"

src_prepare() {
	default
	java-pkg_clean ..
}

src_install() {
	default
	einstalldocs
	docinto html
	dodoc -r ../docs
	java-pkg-simple_src_install
}
