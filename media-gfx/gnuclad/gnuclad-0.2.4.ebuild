# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Cladogram tree generator mainly used by the GNU/Linux distro timeline project"
HOMEPAGE="https://launchpad.net/gnuclad/"
SRC_URI="http://launchpad.net/gnuclad/trunk/0.2/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

DEPEND=""
RDEPEND=""

src_install() {
	default

	doman doc/man/gnuclad.1

	use examples && dodoc -r example
}
