function ffmpeg-speed -d 'Use ffmpeg to change video speed.' -a speed
    ffmpeg -filter:v "setpts=PTS/$speed" -filter:a "atempo=$speed" $argv[2..]
end
