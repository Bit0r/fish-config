function merge-va -d "Merge video and audio files" -a stem
    ffmpeg -i $stem.mp4 -i $stem.m4a -c copy $stem-complete.mp4
end
