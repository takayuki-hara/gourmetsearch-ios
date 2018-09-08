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

## プッシュ通知

### 概要
Firebaseを使用し、FCMからのプッシュ通知する仕組みを採用  
設定方法はFirebaseのドキュメントを参照のこと

### リッチ通知
Firebaseのコンソールでは対応していないが、FCMをAPI経由で実行することによって実現可能  
Postmanを使用してAPIを発行する
|項目|内容|補足|
|---|---|---|
|URL|https://fcm.googleapis.com/fcm/send||
|メソッド|POST||
|ヘッダー|Authorization　key=AAAAIHLVapg〜（サーバーキー）<br>Content-Type　application/json||
|ボディ|※欄外に記載||

```json:
{
	"to": "<FCM Token>",
	"mutable_content": true,
	"data":
	{
		"data-url": "<URL>",
		"data-type": "ファイル名"
	},
	"notification":
	{
		"click_action": "btnCategory",
		"title": "プッシュ通知タイトル",
		"body": "プッシュ通知内容",
		"sound": "default"
	}
}
```

## Memo

### LaunchScreenについて

- 初期のLaunchScreenに独自のViewControllerは設定できない
- 任意のStoryboardに変更できる（設定しないこともできる）
- LaunchScreenになっているViewControllerは処理されない？？
- 結局、ロゴくらいにしておくべきで、画面切り替え処理なども行うべきでない
