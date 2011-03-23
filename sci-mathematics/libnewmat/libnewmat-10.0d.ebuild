# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xxdiff/Attic/xxdiff-3.2.ebuild,v 1.9 2008/03/18 19:57:26 armin76 dead $

EAPI=3
inherit eutils

DESCRIPTION="C++ matrix math library by Robert Davies."
HOMEPAGE="http://www.robertnz.net/index.html"
SRC_URI="http://www.robertnz.net/ftp/newmat10.tar.gz"

LICENSE="newmat"
SLOT="0"
KEYWORDS="~x86"
IUSE="shared doc"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare () {
    # patch to add shared build support
    if use shared; then
        epatch "${FILESDIR}"/${P}-shared.patch
    fi
}

src_compile () {
    make -f nm_gnu.mak everything || die "Compile failed"
}

src_install () {
    dolib libnewmat.a
    if use shared; then
        dolib libnewmat.so
    fi
 
    dodir /usr/include/newmat
    insinto /usr/include/newmat
    doins *.h
    
    if use doc; then
       dodoc README AUTHORS COPYING
    fi
}
