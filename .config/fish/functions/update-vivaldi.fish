# update vivaldi widevinecdm & ffmpeg
function update-vivaldi
    if test -d /usr/share/vivaldi-stable
        set vivaldi_dir /usr/share/vivaldi-stable
    else if test -d /opt/vivaldi
        set vivaldi_dir /opt/vivaldi
    else
        printf "Vivaldi is not installed\n"
        return 1
    end
    printf "Updating chromium-codecs-ffmpeg-extra\n"
    sudo $vivaldi_dir/update-ffmpeg
end
