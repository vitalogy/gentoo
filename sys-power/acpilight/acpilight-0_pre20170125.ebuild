# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 python3_5 )

inherit python-r1 udev vcs-snapshot

VCS_COMMIT="9a96203cb09564d7753b14d37d7d4f8ac893f569"
DESCRIPTION="Replacement for xbacklight that uses the ACPI interface to set brightness"
HOMEPAGE="https://github.com/wavexx/acpilight/"
SRC_URI="https://github.com/wavexx/acpilight/archive/${VCS_COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/udev
	${PYTHON_DEPS}
	!x11-apps/xbacklight"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DOCS=( README.rst )

src_install() {
	python_foreach_impl python_doscript xbacklight
	udev_dorules "${S}"/90-backlight.rules
	einstalldocs
}

pkg_postinst() {
	udev_reload
	einfo
	elog "To use the xbacklight binary as a regular user, you must be a part of the video group"
	einfo
	elog "If this utility does not find any backlights to manipulate,"
	elog "verify you have kernel support on the device and display driver enabled."
	einfo
}
