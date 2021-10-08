
youtube-dl https://www.youtube.com/watch?v=%1 -x --audio-format wav --id %-x --audio-format wav --id
ffmpeg -loglevel quiet -i "%1.wav" -ss %2 -to %3 "out_%1.wav"
move /y "out_%1.wav" "%1.wav"

exit /b