#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Syntax : normalize-wav.sh original_wave.wav normalized_wave.wav"
    exit 2
fi

ffmpeg -i $1 -af volumedetect -f null -y nul &> original.txt
rm -f $2
grep "max_volume" original.txt > original1.tmp
cat original1.tmp | grep -oP "\d+.\d+ dB" > original2.tmp
yourscriptvar=$(cat "./original2.tmp")
ffmpeg -i $1 -af "volume=$yourscriptvar" $2
ffmpeg -i $2 -af volumedetect -f null -y nul &> result.txt

#rm original.tmp && rm original1.tmp && rm original2.tmp
cat result.txt


