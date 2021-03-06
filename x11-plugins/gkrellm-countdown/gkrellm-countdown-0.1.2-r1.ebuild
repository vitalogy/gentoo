# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit gkrellm-plugin

DESCRIPTION="A simple countdown clock for GKrellM2"
SRC_URI="http://oss.pugsplace.net/${P}.tar.gz"
HOMEPAGE="http://freecode.com/projects/gkrellm-countdown"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"
IUSE=""

COMMON_DEPEND="app-admin/gkrellm[X]"
RDEPEND+=" ${COMMON_DEPEND}"
DEPEND+="  ${COMMON_DEPEND}"

S="${WORKDIR}/${PN}"

PATCHES=( "${FILESDIR}/${PN}-makefile.patch" )

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}"
}
