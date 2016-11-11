# 【iOS10 Objective-C】ログインしたユーザー情報を一覧に表示してみよう！
*2016/10/26作成*

![画像1](/readme-img/001.png)

## 概要
* [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の『会員管理機能』を利用してObjective-Cアプリにログイン機能を実装し、ユーザー情報の一覧を表示するサンプルプロジェクトです
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

## 作業の手順
### 1. [ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)の会員登録とログイン

* 上記リンクから会員登録（無料）をします。登録ができたらログインをすると下図のように「アプリの新規作成」画面が出るのでアプリを作成します

![画像3](/readme-img/003.png)

* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[ニフティクラウドmobile backend](http://mb.cloud.nifty.com/)を紐付けるために使用します

![画像4](/readme-img/004.png)

* 動作確認後に会員情報が保存される場所も確認しておきましょう

![画像5](/readme-img/005.png)

### 2. [GitHub](https://github.com/NIFTYCloud-mbaas/ObjcSegmentUserApp_iOS10)からサンプルプロジェクトのダウンロード

* 下記リンクをクリックしてプロジェクトをダウンロードをMacにダウンロードします

 * __[ObjcSegmentUserApp](https://github.com/NIFTYCloud-mbaas/ObjcSegmentUserApp_iOS10/archive/master.zip)__

### 3. Xcodeでアプリを起動

* ダウンロードしたフォルダを開き、「__ObjcSegmentUserApp.xcworkspace__」をダブルクリックしてXcode開きます(白い方です)

![画像09](/readme-img/009.png)
![画像06](/readme-img/006.png)

* 「ObjcSegmentUserApp.xcodeproj」（青い方）ではないので注意してください！

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

* 設定は完了です
* lightningケーブルで登録した動作確認用iPhoneをMacにつなぎます
* Xcode画面で左上で、接続したiPhoneを選び、実行ボタン（さんかくの再生マーク）をクリックします

※このサンプルアプリはシミュレーターでの動作確認も行えます

### 6.動作確認
* アプリが起動したら、Login画面が表示されます
* 初回は__`SignUp`__ ボタンをクリックして、会員登録を行います

![画像14](/readme-img/014.png)

* `User Name`と`Password`を２つ入力して![画像12](/readme-img/012.png)ボタンをタップします
* 会員登録が成功するとログインされ、下記ユーザー情報の一覧が表示されます
* SignUpに成功するとmBaaS上に会員情報が作成されます！
* ログインに失敗した場合は画面にエラーコードが表示されます
* エラーが発生した場合は、[こちら](http://mb.cloud.nifty.com/doc/current/rest/common/error.html)よりエラー内容を確認いただけます

![画像15](/readme-img/015.png)

### 7.別のユーザー情報を取得する
* __`Logout`__ ボタンをタップするとログアウトし、元の画面に戻ります
* 別の`User Name`と`Password`を入力して[画像11](/readme-img/011.png)ボタンをタップします
 (別のユーザー情報がない場合は新しくSingUpしてください)
* ログインが成功する、先ほどとは別のユーザー情報の一覧が表示されます

![画像15](/readme-img/015.png)

## 解説
* 下記３点について解説します
 * 会員登録
 * ログイン
 * 会員情報の取得

### 会員登録
`SignUpViewController.m`

```objc
// 会員登録
// NCMBUserのインスタンスを作成
NCMBUser *user = [NCMBUser user];
// ユーザー名を設定
user.userName = self.userNameTextField.text;
// パスワードを設定
user.password = self.passwordTextField.text;

// 会員の登録を行う
[user signUpInBackgroundWithBlock:^(NSError *error) {
    if (error) {
        // 新規登録失敗時の処理

    } else {
        // 新規登録成功時の処理

    }
}];
```

### ログイン

```objc
// ログイン
[NCMBUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(NCMBUser *user, NSError *error) {
    if (error) {
        // ログイン失敗時の処理

    }else{
        // ログイン成功時の処理

    }
}];
```

### 会員情報の取得
`SegmentUserViewController.m`

```objc
// NCMBUserのインスタンスを作成
NCMBUser *user = [NCMBUser currentUser];

// ユーザー情報をデータストアから取得
[user fetchInBackgroundWithBlock:^(NSError *error) {
    if(!error){
        // ユーザー情報の取得が成功した場合の処理

    } else {
        // ユーザー情報の取得が失敗した場合の処理

}
}];
```

## 参考
* 同じ内容の【Swift】版もご用意しています
 * [SwiftSegmentUserApp_iOS10](https://github.com/natsumo/SwiftSegmentUserApp_iOS10)
