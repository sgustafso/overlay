# Copyright 2011-2011 Stephen Gustafson
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit eutils

DESCRIPTION="Paint tool with support for OpenEXR and editing 16-bit images"
HOMEPAGE="http://www.cinepaint.org"
VNAME="0.22-1"
SRC_URI="mirror://sourceforge/cinepaint/${PN}-${VNAME}.tar.gz"
S="${WORKDIR}/${P}-${VNAME}"

LICENSE="GPL LGPL MITOSI"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc openexr jpeg lcms png"

DEPEND="media-libs/ftgl
    >=x11-libs/libXpm-3.5.9
    >=x11-libs/libXext-1.2.0
    =x11-libs/fltk-1.3*
    =dev-libs/glib-1.2*
    =x11-libs/gtk+-1.2*
    openexr? ( >=media-libs/openexr-1.7.0 )
    jpeg? ( >=media-libs/jpeg-8c )
    lcms? ( >=media-libs/lcms-1.19 )
    png? ( >=media-libs/libpng-1.4.5 )"
RDEPEND="${DEPEND}"

src_prepare () {
   unpack "${A}"

   cd "${WORKDIR}/${PN}-${VNAME}"
   epatch "${FILESDIR}/cinepaint-0.22-1.bugs.patch"
}

src_configure () {
   cd "${WORKDIR}/${PN}-${VNAME}"
   # detection of gutenprint in configure seems busted
   # disabling for now
   econf --disable-print
}

src_compile () {
   cd "${WORKDIR}/${PN}-${VNAME}"
   default
}

src_install () {
   cd "${WORKDIR}/${PN}-${VNAME}"
   einstall | die "Install failed"
   if use doc; then
      dodoc README NEWS ChangeLog INSTALL AUTHORS COPYING
   fi
}
