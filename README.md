# 【iOS10 Objective-C】プッシュ通知からデータを取得してみよう！（ペイロード）
*2016/10/26作成*

![画像1](/readme-img/001.png)

## 概要
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の『プッシュ通知』機能とプッシュ通知を受信する際、プッシュ通知の『ペイロードデータを取得する』機能を実装したサンプルプロジェクトです
* 簡単な操作ですぐに [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の機能を体験いただけます★☆
* このサンプルはiOS10に対応しています
 * iOS8以上でご利用いただけます

## ニフティクラウドmobile backendって何？？
スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、しかも基本**無料**(注1)で使えるクラウドサービス！

注1：詳しくは[こちら](http://mb.cloud.nifty.com/price.htm)をご覧ください

![画像2](/readme-img/002.png)

## 動作環境
* Mac OS X 10.11.6(El Capitan)
* iPhone5 iOS 9.3.5
* iPhone6s iOS 10.0.1
 * このサンプルアプリは、プッシュ通知を受信する必要があるため実機ビルドが必要です

※上記内容で動作確認をしています

## プッシュ通知の仕組み
* ニフティクラウドmobile backendのプッシュ通知は、iOSが提供している通知サービスを利用しています
 * iOSの通知サービス　__APNs（Apple Push Notification Service）__

 ![画像10](/readme-img/010.png)

* 上図のように、アプリ（Xcode）・サーバー（ニフティクラウドmobile backend）・通知サービス（APNs）の間でやり取りを行うため、認証が必要になります
 * 認証に必要な鍵や証明書の作成は作業手順の「0.プッシュ通知機能使うための準備」で行います

## 作業の手順
### 0.プッシュ通知機能使うための準備
__[【iOS】プッシュ通知の受信に必要な証明書の作り方(開発用)](https://github.com/natsumo/iOS_Certificate)__
* 上記のドキュメントをご覧の上、必要な証明書類の作成をお願いします
 * 証明書の作成には[Apple Developer Program](https://developer.apple.com/account/)の登録（有料）が必要です

![画像i002](/readme-img/i002.png)

### 1. [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の会員登録とログイン→アプリ作成と設定
* 上記リンクから会員登録（無料）をします。登録ができたらログインをすると下図のように「アプリの新規作成」画面が出るのでアプリを作成します

![画像3](/readme-img/003.png)

* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)を紐付けるために使用します

![画像4](/readme-img/004.png)

* 続けてプッシュ通知の設定を行います
* ここで⑦APNs用証明書(.p12)の設定も行います

![画像5](/readme-img/005.png)

### 2. [GitHub](https://github.com/NIFTYCloud-mbaas/ObjcPayloadApp_iOS10)からサンプルプロジェクトのダウンロード

* 下記リンクをクリックしてプロジェクトをダウンロードをMacにダウンロードします

 * __[ObjcPayloadApp](https://github.com/NIFTYCloud-mbaas/ObjcPayloadApp_iOS10/archive/master.zip)__

### 3. Xcodeでアプリを起動

* ダウンロードしたフォルダを開き、「__ObjcPayloadApp.xcworkspace__」をダブルクリックしてXcode開きます(白い方です)

![画像09](/readme-img/009.png)
![画像06](/readme-img/006.png)

* 「ObjcPayloadApp.xcodeproj」（青い方）ではないので注意してください！

![画像08](/readme-img/008.png)

### 4. APIキーの設定

* `AppDelegate.m`を編集します
* 先程[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボード上で確認したAPIキーを貼り付けます

![画像07](/readme-img/007.png)

* それぞれ`YOUR_NCMB_APPLICATION_KEY`と`YOUR_NCMB_CLIENT_KEY`の部分を書き換えます
 * このとき、ダブルクォーテーション（`"`）を消さないように注意してください！
* 書き換え終わったら`command + s`キーで保存をします

### 5. 実機ビルド
* 始めて実機ビルドをする場合は、Xcodeにアカウント（AppleID）の登録をします
 * メニューバーの「Xcode」＞「Preferences...」を選択します
 * Accounts画面が開いたら、左下の「＋」をクリックします。
 * Apple IDとPasswordを入力して、「Add」をクリックします

 ![画像i29](/readme-img/i029.png)

 * 追加されると、下図のようになります。追加した情報があっていればOKです
 * 確認できたら閉じます。

 ![画像i30](/readme-img/i030.png)

* 「TARGETS」 ＞「General」を開きます

![画像14](/readme-img/014.png)

* 「Identity」＞「Bundle Identifier」を入力します
 * 「Bundle Identifier」にはAppID作成時に指定した「Bundle ID」を入力してください
* 「Signing(Debug)」＞「Provisioning Profile」を設定します
 * 今回使用するプロビジョニングプロファイルをプルダウンから選択します
 * プロビジョニングプロファイルはダウンロードしたものを一度__ダブルクリック__して認識させておく必要があります（プルダウンに表示されない場合はダブルクリックを実施後設定してください）
 * 選択すると以下のようになります
 ![画像15](/readme-img/015.png)

* 「TARGETS」＞「Capabilities」を開き、「Push Notifications」を__ON__に設定します
 * 設定すると以下のようになります
 ![画像16](/readme-img/016.png)

* 設定は完了です
* lightningケーブルで登録した動作確認用iPhoneをMacにつなぎます
* Xcode画面で左上で、接続したiPhoneを選び、実行ボタン（さんかくの再生マーク）をクリックします

### 6.動作確認
* インストールしたアプリを起動します
 * プッシュ通知の許可を求めるアラートが出たら、必ず許可してください！
* 起動されたらこの時点でデバイストークンが取得されます
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボードで「データストア」＞「installation」クラスを確認してみましょう！

![画像12](/readme-img/012.png)

### 7.プッシュ通知を送って、データを取得しましょう（アプリ起動時）
* まずはアプリを__起動した状態__でプッシュ通知を送ってみましょう！
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)のダッシュボードで「プッシュ通知」＞「＋新しいプッシュ通知」をクリックします
* プッシュ通知のフォームが開かれます
* タイトル、メッセージ、JSON、URL（他も後ほど試してみてください）を入力してプッシュ通知を作成します

![画像11](/readme-img/011.png)

* 端末を確認しましょう！
* 少し待つとプッシュ通知が届きます
 * アプリ起動時はプッシュ通知が__表示されません__！（iOSの仕様）ただし、プッシュ通知が受信できていないわけではなく、正しく配信されていれば、ペイロードを受信し、画面に表示します
* ペイロードデータの見方については「解説」をご覧ください

### 8.プッシュ通知を送って、データを取得しましょう（非アプリ起動時）
* 次にアプリを__完全に閉じた状態__でプッシュ通知を送ってみましょう！
* プッシュ通知は7.と同様にダッシュボードから作成してください
* 今度はプッシュ通知が受信されますので、プッシュ通知をタップしてアプリを起動します
* 起動時にペイロードを取得し、画面に表示します

![画像1](/readme-img/001.png)

* ペイロードデータの見方については「解説」をご覧ください

## 解説
* 下記２点について解説します
 * ペイロードデータについて
 * サンプルプロジェクトに実装済みの内容

### ペイロードデータについて
* ニフティクラウドmobile backendのダッシュボードで入力した内容は以下のようなJSONデータとして、端末に届きます

```JSON
{
    "aps" : {
        "alert" : {
            "body" : "message",
            "title" : "title"
        },
        "sound" : "default"
    },
    "com.nifty.PushId" : "********",
    "data" : "json",
    "com.nifty.RichUrl" : "http://mb.cloud.nifty.com/"
}
```

* 「aps」の１つ下の階層に「alert」があり、この１つ下の階層にダッシュボードで入力した「メッセージ」と「タイトル」が、それぞれ「body」と「title」に設定されます
* ダッシュボードで「音声ファイル名」を設定した場合、「aps」の１つ下の階層に「sound」に設定されます
* ダッシュボードで「JSON」に入力したデータはそのまま追加されて設定されます
* ダッシュボードで「URL」に設定した場合、「com.nifty.RichUrl」として設定されます

### サンプルプロジェクトに実装済みの内容
#### SDKのインポートと初期設定
* ニフティクラウドmobile backend の[ドキュメント（クイックスタート）](http://mb.cloud.nifty.com/doc/current/introduction/quickstart_ios.html)を、ご活用ください

#### コード紹介
##### デバイストークン取得とニフティクラウドmobile backendへの保存
 * `AppDelegate.m`の`didFinishLaunchingWithOptions`メソッドにAPNsに対してデバイストークンの要求するコードを記述し、デバイストークンが取得された後に呼び出される`didRegisterForRemoteNotificationsWithDeviceToken`メソッドを追記をします
 * デバイストークンの要求はiOSのバージョンによってコードが異なります

```Objc
//
//  AppDelegate.m
//  ObjcPayloadApp
//

#import "AppDelegate.h"
#import <NCMB/NCMB.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [NCMB setApplicationKey:@"YOUR_NCMB_APPLICATIONKEY"
                  clientKey:@"YOUR_NCMB_CLIENTKEY"];

    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){10, 0, 0}]){

        //iOS10以上での、DeviceToken要求方法
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert |
                                                 UNAuthorizationOptionBadge |
                                                 UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (error) {
                                      return;
                                  }
                                  if (granted) {
                                      //通知を許可にした場合DeviceTokenを要求
                                      [[UIApplication sharedApplication] registerForRemoteNotifications];
                                  }
                              }];
    } else if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){8, 0, 0}]){

    //iOS10未満での、DeviceToken要求方法

    //通知のタイプを設定したsettingを用意
    UIUserNotificationType type = UIUserNotificationTypeAlert |
    UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound;
    UIUserNotificationSettings *setting;
    setting = [UIUserNotificationSettings settingsForTypes:type
                                                categories:nil];

    //通知のタイプを設定
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];

    //DeviceTokenを要求
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    }

    return YES;
}

// デバイストークンが取得されたら呼び出されるメソッド
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    // 端末情報を扱うNCMBInstallationのインスタンスを作成
    NCMBInstallation *installation = [NCMBInstallation currentInstallation];

    // Device Tokenを設定
    [installation setDeviceTokenFromData:deviceToken];

    // 端末情報をデータストアに登録
    [installation saveInBackgroundWithBlock:^(NSError *error) {
        if(error){
            // 端末情報の登録に失敗した時の処理

        } else {
            // 端末情報の登録に成功した時の処理

        }
    }];
}

```

##### ペイロード取得

* プッシュ通知からペイロードを取得するコードは下記の２パターンあります
 * 【ペイロード：アプリ非起動時に受信】アプリが起動されたときにプッシュ通知の情報を取得する
 * 【ペイロード：アプリ起動時に受信】アプリが起動中にプッシュ通知の情報を取得する

* それぞれ`AppDelegate.m`の次の箇所に追記します

_アプリ非起動時に受信する場合_
* 次にアプリが起動されたときにペイロードを取得するため、`didFinishLaunchingWithOptions`メソッド内に記述します

```Objc
// 【ペイロード：アプリ非起動時】アプリが起動されたときにプッシュ通知の情報を取得する
NSDictionary *remoteNotification = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if (remoteNotification) {
        // プッシュ通知情報の取得
        /* 省略 */
}

```

_アプリ起動時に受信する場合_
* 起動中に受信するため、`didReceiveRemoteNotification`メソッドを追記し、記述します

```Objc
// 【ペイロード：アプリ起動時】アプリが起動中にプッシュ通知の情報を取得する
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // プッシュ通知情報の取得
    /* 省略 */
}
```

## 参考
* ニフティクラウドmobile backend の[ドキュメント（プッシュ通知）](http://mb.cloud.nifty.com/doc/current/push/basic_usage_ios.html)を、ご活用ください
 * [Swift3(iOS10)] [--準備中--](http://mb.cloud.nifty.com/)
 * [Swift2(iOS9,8)] [Swiftでプッシュ通知を送ろう！](http://qiita.com/natsumo/items/8ffafee05cb7eb69d815)
* 同じ内容の【Swift】版もご用意しています
 * [SwiftPayloadApp_iOS10](https://github.com/natsumo/SwiftPayloadApp_iOS10)
