# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools

DESCRIPTION="Open-source implementation of the Secure Real-time Transport Protocol (SRTP)"
HOMEPAGE="https://github.com/cisco/libsrtp"
SRC_URI="https://github.com/cisco/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd ~ppc-macos ~x64-macos ~x86-macos"
IUSE="aesicm console debug doc libressl openssl static-libs syslog test"

RDEPEND="
	openssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:0= )
	)
"
DEPEND="${RDEPEND}"

DOCS=( CHANGES README TODO )

PATCHES=( "${FILESDIR}/${PN}-pcap-automagic-r0.patch" )

src_prepare() {
	default

	# test/rtpw.c is using /usr/share/dict/words assuming it exists
	# using test/rtpw.c guaratees the file exists in any case
	sed -i -e "s:/usr/share/dict/words:rtpw.c:" test/rtpw.c || die

	eautoreconf
}

src_configure() {
	# stdout: default error output for messages in debug
	# kernel-linux: breaks the build
	# gdoi: disabled by upstream and breaks the build
	# pcap: seems to be test-only
	econf \
		--enable-stdout \
		--disable-kernel-linux \
		--disable-gdoi \
		--disable-pcap \
		$(use_enable aesicm generic-aesicm) \
		$(use_enable console) \
		$(use_enable debug) \
		$(use_enable openssl) \
		$(use_enable syslog)
}

src_compile() {
	use static-libs && emake ${PN}.a
	emake shared_library
	use test && emake test
}

src_test() {
	LD_LIBRARY_PATH="${S}" emake -j1 runtest

	# Makefile.in has '$(testapp): libsrtp.a'
	if use !static-libs; then
		rm libsrtp.a || die
	fi
}

src_install() {
	# libsrtp.pdf can also be generated with doxygen
	# but it would be a waste of time as an up-to-date version is built
	use doc && DOCS+=( doc/*.txt doc/${PN}.pdf )

	default
}
