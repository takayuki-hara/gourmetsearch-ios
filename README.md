# gourmetsearch-ios

## Overview
グルメ検索アプリ。  
クリーンアーキテクチャ、Rx、SnapKitなどを試すのが主目的。

## Environment
- 言語：Swift4.1
- IDE：Xcode9.3+
- CocoaPods：1.5.3

## SwiftyBeaver
SwiftyBeaverを使用してロギングしている。  
デバッグコンソール、ファイル、クラウドに出力。

ファイルを確認する場合のコマンド。
```
$ tail -f /tmp/swiftybeaver/gourmetsearch.log
```

クラウドのデータにアクセスするための設定（アプリをインストールする）。
- appID : v6gbNz
- appSecret : pZsdmelj5nis5tEzs9dljMwwsZjlzimu
- encryptionKey : dk9f1pd643f9I6e6csucrmqqcwfusxqw

## Firebase

### Xcodeコンソールでバッグを有効化
1. Xcode で [Product]、[Scheme]、[Edit scheme] の順に選択
1. 左側のメニューから [Run] を選択
1. [Arguments] タブを選択
1. [Arguments Passed On Launch] セクションで -FIRAnalyticsDebugEnabled を追加

### Xcodeコンソールでバッグを無効化
1. 有効化手順の1-3
1. -FIRDebugDisabled を追加

### ログレベルの設定
初期化前に下記のように設定する。
```
FirebaseConfiguration.shared.setLoggerLevel(.info)
FirebaseApp.configure()
```
