# Copyright 2010 Stephen Gustafson
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit distutils eutils

DESCRIPTION="Command line tool for generating secure passwords"
HOMEPAGE="http://www.guyrutenberg.com/2007/10/20/spass-a-secure-password-generator-utility/"
SRC_URI="http://www.guyrutenberg.com/wp-content/uploads/2007/10/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc sparc x86"
IUSE="doc"

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	# unpacks to spass, but we want ${P}
	mv spass ${P}
}

src_compile() {
	emake || die "compile failed"
}

src_install () {
	dobin spass

	if use doc; then
		cd doc
		dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	fi
}
