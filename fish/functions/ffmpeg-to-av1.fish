function ffmpeg-to-av1 \
    -d 'Convert video to AV1 format' \
    -a input_file

    set filename_parts (string split "." $input_file)
    set output_file $filename_parts[1]_av1.mkv

    ffmpeg \
        -stats \
        $argv[2..-1] \
        -hwaccel vaapi \
        -hwaccel_device /dev/dri/renderD128 \
        -hwaccel_output_format vaapi \
        -i $input_file \
        -c:v av1_vaapi \
        -c:a copy \
        $output_file
end
