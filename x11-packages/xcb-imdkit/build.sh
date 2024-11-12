TERMUX_PKG_HOMEPAGE=https://github.com/fcitx/xcb-imdkit
TERMUX_PKG_DESCRIPTION="An implementation of xim protocol in xcb"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.0.9"
TERMUX_PKG_SRCURL=https://github.com/fcitx/xcb-imdkit/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=c2f0bbad8a335a64cdc7c19ac7b6ea1f0887dd6300ca9a4fa2e2fec6b9d3f695
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="newest-tag"
TERMUX_PKG_DEPENDS="libxcb, xcb-util"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, uthash, xcb-util-keysyms"
