# Copyright 2010-2011 Stephen Gustafson

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit git distutils

EGIT_REPO_URI="http://github.com/couchapp/couchapp.git"

DESCRIPTION="Utility for managing couchdb designs through a directory hierarchy"
HOMEPAGE="http://couchapp.org"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha x86 amd64"
IUSE=""

RDEPEND="dev-db/couchdb"
DEPEND="${RDEPEND}"

src_unpack()
{
	git_src_unpack
}

src_install()
{
	distutils_src_install
}
