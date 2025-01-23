@echo off
setlocal enabledelayedexpansion

:: Check if ffmpeg is available
where ffmpeg >nul 2>&1
if %errorlevel% neq 0 (
    echo ffmpeg is not installed or not in your PATH. Please install ffmpeg first.
    pause
    exit /b 1
)

:: Loop through all .flac files in the current directory and its subdirectories
for /r %%f in (*.flac) do (
    :: Get the full path of the file
    set "input_file=%%f"

    :: Create the output file path by replacing .flac with .mp3
    set "output_file=%%~dpnf.mp3"

    :: Convert the file using ffmpeg
    echo Converting "!input_file!" to "!output_file!"...
    ffmpeg -i "!input_file!" -q:a 0 -map_metadata 0 -id3v2_version 3 "!output_file!"

    :: Check if the conversion was successful
    if %errorlevel% equ 0 (
        echo Conversion successful.
    ) else (
        echo Conversion failed for "!input_file!".
    )
)

echo All files have been processed.
pause
