TERMUX_PKG_HOMEPAGE=https://www.musicpd.org
TERMUX_PKG_DESCRIPTION="Music player daemon"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.23.8"
TERMUX_PKG_REVISION=4
TERMUX_PKG_SRCURL=https://github.com/MusicPlayerDaemon/MPD/archive/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=a44584523c6e9b30d833ec214c0214dd7f8ba4680cc3b2e5670dc9fb3c6cd842
TERMUX_PKG_DEPENDS="dbus, ffmpeg, game-music-emu, libao, libbz2, libc++, libcurl, libexpat, libflac, libicu, libid3tag, libmad, libmp3lame, libmpdclient, libnfs, libogg, libopus, libsndfile, libsoxr, libsqlite, libvorbis, openal-soft, pulseaudio, zlib"
TERMUX_PKG_BUILD_DEPENDS="boost, boost-headers, libiconv"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dalsa=disabled
-Depoll=false
-Dsndio=disabled
-Dzlib=enabled
-Dicu=enabled
-Diconv=enabled
-Dpcre=enabled
-Dexpat=enabled
-Ddbus=enabled
-Dipv6=enabled
"
TERMUX_PKG_CONFFILES="etc/mpd.conf"
TERMUX_PKG_SERVICE_SCRIPT=("mpd" "if [ -f \"$TERMUX_ANDROID_HOME/.mpd/mpd.conf\" ]; then CONFIG=\"$TERMUX_ANDROID_HOME/.mpd/mpd.conf\"; else CONFIG=\"$TERMUX_PREFIX/etc/mpd.conf\"; fi\nexec mpd --stdout --no-daemon \$CONFIG 2>&1")
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="newest-tag"

termux_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $TERMUX_PREFIX.
	if $TERMUX_ON_DEVICE_BUILD; then
		termux_error_exit "Package '$TERMUX_PKG_NAME' is not safe for on-device builds."
	fi

	CXXFLAGS+=" -DTERMUX -UANDROID"
	LDFLAGS+=" -lOpenSLES"
	rm -f $TERMUX_PREFIX/etc/mpd.conf

	export BOOST_ROOT=$TERMUX_PREFIX
}

termux_step_post_make_install() {
	install -Dm600 $TERMUX_PKG_SRCDIR/doc/mpdconf.example $TERMUX_PREFIX/etc/mpd.conf
}

termux_step_create_debscripts() {
	echo "#!$TERMUX_PREFIX/bin/sh" >postinst
	echo 'mkdir -p $HOME/.mpd/playlists' >>postinst
}
