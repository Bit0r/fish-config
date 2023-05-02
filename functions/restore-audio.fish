function restore-audio -d 'Restore Ubuntu PulseAudio'
    pkill pulseaudio
    rm -r ~/.config/pulse/*
end
