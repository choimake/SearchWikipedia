# SearchWikipedia

これはiOSアプリのサンプルです。検索ボックスに文字を入力すると、該当するWikipediaのページを情報を表示してくれます。

![wikisearchsample](https://user-images.githubusercontent.com/52233450/60766666-e1eff600-a0e7-11e9-872d-e575e8af4d06.gif)

## Dependency
- macOS Mojave 10.14.5
- Xcode 10.2.1
- xcodegen 2.5.0
- CocoaPods 1.7.1

## Setup
リポジトリをcloneします。
```
git clone https://github.com/choimake/SearchWikipedia.git
```
`*.xcodeproj`を生成します。
```
cd path/to/SearchWikipedia
xcodegen
```
ライブラリをインストールします
```
pod install
```

## Author
- choimake

## Reference
- [RxSwift研究読本3 ViewModel設計パターン入門](https://booth.pm/ja/items/1223536)
- [【Swift】Codableについて備忘録](https://qiita.com/s_emoto/items/deda5abcb0adc2217e86)
- [わかりやすいREADME.mdを書く](https://deeeet.com/writing/2014/07/31/readme/)
- [なるべくコンフリクトしないXcodeプロジェクトの作成手順](https://qiita.com/choimake/items/c7dcc7687b565843db74)