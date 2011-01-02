# Copyright 2010 Stephen Gustafson
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit distutils eutils

DESCRIPTION="Osh (Object SHell) is a tool that integrates the processing of structured data, database access, and remote access to a cluster of nodes."
HOMEPAGE="http://geophile.com/${PN}/"
SRC_URI="http://geophile.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc sparc x86"
IUSE="doc"

DEPEND=">=dev-lang/python-2.3"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# patch to fix build.
	# build expected osh tarball to exist in parent dir
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	distutils_src_compile
}

src_install () {
	distutils_src_install

	if use doc; then
        	cd doc
        	dodoc LICENSE README todo web
    	fi
}
