# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Compiles finite state machines from regular languages into executable code"
HOMEPAGE="https://www.colm.net/open-source/ragel/"
SRC_URI="https://www.colm.net/files/ragel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="vim-syntax"

DEPEND="dev-util/colm"
RDEPEND="${DEPEND}"

src_test() {
	cd "${S}"/test || die
	./runtests.in || die
}

src_install() {
	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins ragel.vim
	fi
	default
}
