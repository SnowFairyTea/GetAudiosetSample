# youtubedl
[このリポジトリ](https://github.com/SnowFairyTea/AudiosetLabelSelector)
のプログラムの実行結果のcsvファイル群を元にwavファイルをダウンロードします

## 目的
Audiosetを用いた学習を行うため、wavファイルを簡単にダウンロードする手段が必要である。
そのため、バッチファイルを作成した。



## 事前準備
### ダウンロード
* [ffmpeg](https://ffmpeg.org/download.html)をインストール  
* [リポジトリ](https://github.com/ytdl-org/youtube-dl/blob/master/README.md)
よりyoutubedl.exeをダウンロードし、READMEと同じフォルダに配置

### CSVファイルの準備
[このリポジトリ](https://github.com/SnowFairyTea/AudiosetLabelSelector)
によって得られたCSVファイル群をtargetファイル下に保存する。



## 使いかた
事前準備を済ませた後、```GetAudiosetSample.bat```を実行する

引数としてディレクトリへの相対パスを指定することで、  
targetファイルの代わりに別のファイルを用いることができる。


## 参考文献
[リポジトリ](https://github.com/ytdl-org/youtube-dl/blob/master/README.md)
[オプションの解説](https://masayoshi-9a7ee.hatenablog.com/entry/20150905/1441414821)