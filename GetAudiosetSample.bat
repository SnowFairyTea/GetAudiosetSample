::パラメータに目的のcsvファイル名から.csvを消したものを与える
@echo off
:: sample_rate
set sr =22050




::./youtube-dl

REM === メイン処理

:: CSVファイルを持ってくるディレクトリのパスが第一引数である
:: デフォルトがtarget/
IF "%1" == ""(
    set tar ="target/"
) else (
    set tar ="%1/"
)
:: ラベル一覧のCSVを読む
:: FOR /F "tokens=1,2 delims=," %%a IN (target/labels.csv) do (
FOR /F "tokens=1,2 delims=," %%a IN (tar/labels.csv) do (
    cd result
    mkdir %%a
    cd ..
    echo "%%a start"
    :: ラベル毎のCSVのデータからダウンロードを行う
    FOR /F "tokens=1,2,3" %%x IN (target/%%a.csv) do (
        cd result/%%a
        call :download_cat %%x %%y %%z
        cd ../..
        echo "sleep 2 seconds"
        powershell sleep 2
    )
    echo "%%a finish"
)
exit /b

REM === 関数
:download_cat
   :: echo %1,%2,%3
    
    youtube-dl https://www.youtube.com/watch?v=%1 -x --audio-format wav --id %-x --audio-format wav --id
    ffmpeg -loglevel quiet -i "%1.wav" -ss %2 -to %3 "out_%1.wav"
    move /y "out_%1.wav" "%1.wav"

exit /b
