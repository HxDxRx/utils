@echo off
for /R %%i in (*.ogg) do (
    echo Processing "%%i"
    
    :: Extract the disc art
    ffmpeg -i "%%i" -an -vcodec copy cover.jpg
    
    :: Create the final MP4 with disc art and converted audio
    :: -CRF is set high because it's a still image
    ffmpeg -loop 1 -i cover.jpg -i "%%i" -c:v libx264 -pix_fmt yuv420p -crf 35 -c:a aac -q:a 0 -strict experimental -shortest "%%~dpni.mp4"
    
    :: Clean up temporary files
    del cover.jpg
)
pause
