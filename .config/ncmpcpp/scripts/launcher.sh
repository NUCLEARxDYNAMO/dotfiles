#!/usr/bin/env sh

# The ncmpcpp launcher with triple options.
# https://github.com/owl4ce/dotfiles

SYSTEM_LANG="$LANG"
export LANG='POSIX'
exec >/dev/null 2>&1
. "${HOME}/.joyfuld"

MUSIC_PLAYER="$(joyd_launch_apps -g music_player)"

if [ "$MUSIC_PLAYER" = 'mpd' ]; then
    case "${1}" in
        '') LANG="$SYSTEM_LANG" joyd_launch_apps terminal -e ncmpcpp -q
        ;;
        a*) LANG="$SYSTEM_LANG" joyd_launch_apps terminal -g "${NCMPCPP_AA_LAUNCHER_GEOMETRY:-84x13}" \
                                                          -e ncmpcpp -c "${NCMPCPP_DIR}/album-art.config" \
                                                                     -q
        ;;
        s*) LANG="$SYSTEM_LANG" joyd_launch_apps terminal -g "${NCMPCPP_SAA_LAUNCHER_GEOMETRY:-47x18}" \
                                                          -e ncmpcpp -c "${NCMPCPP_DIR}/single.album-art.config" \
                                                                     -q
        ;;
    esac
else
    dunstify 'Music Player' "Currently <u>${MUSIC_PLAYER}</u>!" -i "$MUSIC_ICON" -r 79 -u low
fi

exit ${?}