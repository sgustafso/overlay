# Copyright 2011 Stephen Gustafson
# Distributed under the terms of the GNU General Public License v2

EAPI=3
inherit eutils

DESCRIPTION="Companion to Android SDK allowing native code in c/c++"
HOMEPAGE="http://developer.android.com/sdk/ndk/index.html"
VNAME="r5b"
SRC_URI="http://dl.google.com/android/ndk/${PN}-${VNAME}-linux-x86.tar.bz2"

LICENSE="androidndk"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc examples"

# all libs installed in android-ndk are intended for execution
# on other platforms. We do NOT modify these libs in ANY WAY
# when installing!
RESTRICT="strip"
QA_TEXTRELS='*.so'
QA_WX_LOAD='*'
QA_EXECSTACK='*'

DEPEND=">=sys-devel/make-3.81"
RDEPEND="${DEPEND}"

ANDROID_NDK_DIR="/opt/${PN}"

src_configure () {
   einfo "Nothing to do"
}

src_compile () {
   einfo "Nothing to do"
}

src_install () {
    cd "${PN}-${VNAME}"

    insinto "${ANDROID_NDK_DIR}"
    
    # install binaries.
    insopts -m0755
    doins ndk-build ndk-gdb || die

    insopts -m0644

    # copy over everything else.
    doins GNUmakefile
    dodir "${ANDROID_NDK_DIR}"/{build,platforms,sources,toolchains,tests} || die
    for srcdir in build platforms sources toolchains tests; do
        cp -pPR "${srcdir}"/* "${ED}${ANDROID_NDK_DIR}/${srcdir}" || die "Failed copying ${srcdir} files"
    done

    if use examples; then
       dodir "${ANDROID_NDK_DIR}/samples" || die
       cp -pPR samples/* "${ED}${ANDROID_NDK_DIR}/samples" || die "Failed copying sample files"
    fi

    fowners root:android "${ANDROID_NDK_DIR}/" || die
    fperms 0775 "${ANDROID_NDK_DIR}"

    echo "PATH=\"${EPREFIX}${ANDROID_NDK_DIR}\"" > "${T}/80${PN}" || die
    doenvd "${T}/80${PN}" || die
    
	if use doc; then
       dodoc README.TXT RELEASE.TXT documentation.html docs || die
    fi
}

pkg_postinst () {
   elog "${P} is a binary package."
   elog "To build this toolchain from source, see: http://android.git.kernel.org/pub"
   if use examples; then        
      elog "Samples have been copied into ${ANDROID_NDK_DIR}/samples"
   fi

   elog "${P} has been installed under ${EPREFIX}${ANDROID_NDK_DIR}"
}
