# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/Attic/xxdiff-3.2.ebuild,v 1.9 2008/03/18 19:57:26 armin76 dead $

EAPI=2
inherit distutils eutils mercurial

EHG_REPO_URI="http://hg.furius.ca/public/xxdiff"

DESCRIPTION="A graphical file and directories comparator and merge tool."
HOMEPAGE="http://furius.ca/xxdiff/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc sparc x86"
IUSE="python doc"

DEPEND=">=x11-libs/qt-core-4.5
	>=x11-libs/qt-gui-4.5
	dev-python/docutils
	sys-devel/flex || ( sys-devel/bison dev-util/yacc )"
RDEPEND="${DEPEND}
	sys-apps/diffutils"

QMAKE=/usr/bin/qmake

src_configure() {
	cd src
	emake -f Makefile.bootstrap QMAKE="${QMAKE}" || die "Makefile creation failed"
}

src_compile() {
	if use python; then
		distutils_src_compile
	fi

	cd src
	emake QMAKE="${QMAKE}" || die "Compile failed"
	if use doc; then
		cd ../doc
		../bin/xxdiff --html-help > xxdiff-doc.html
		#emake || die "Doc failed"
	fi
}

src_install () {
	if use python; then
		distutils_src_install
	fi

	cd bin
	dobin xxdiff xx-cond-replace xx-cvs-diff xx-cvs-revcmp xx-diff-proxy xx-encrypted xx-filter xx-find-grep-sed xx-hg-merge xx-match xx-pyline xx-rename xx-sql-schemas xx-svn-diff xx-svn-resolve xx-svn-review
	cd ..
	doman src/xxdiff.1
	dodoc README CHANGES TODO
	cd doc
	dodoc xxdiff-doc.html
}
