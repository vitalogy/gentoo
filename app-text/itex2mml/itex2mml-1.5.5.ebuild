# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

DESCRIPTION="A LaTeX into XHTML/MathML converter"
HOMEPAGE="http://golem.ph.utexas.edu/~distler/blog/itex2MML.html"
SRC_URI="http://golem.ph.utexas.edu/~distler/blog/files/itexToMML-${PV}.tar.gz"
LICENSE="|| ( GPL-2+ MPL-1.1 LGPL-2+ )"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

S="${WORKDIR}/itexToMML/itex-src"

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" CFLAGS="${CFLAGS}"
}

src_install() {
	dobin itex2MML
	dodoc ../README
}
