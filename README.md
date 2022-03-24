# InteractiveUISample 
[ING]ライブラリを使わないでアニメーション表現を盛り込んだ機能サンプル（iOS Sample Study: Swift）

UIのスクロールやタブUIの切り替えを伴うようなコンテンツにて動きの中でポイントとなりそうな部分にアニメーション不自然にならない心地よいタイミングでに盛り込むプラクティスをするために作成したサンプルになります。

## 実装機能一覧

今回のサンプルに関しては、主に下記の6つの機能についてを実装しています。

+ UITableViewのセルが出現した際にふわっとフェードインがかかる動き
 → 特にAWAの動きを参考にした部分
+ スクロールの変化量に伴って他のView要素の位置が切り替わる動き
 → ヘッダーの動き方はReactNativeのサンプルもプラスで参考にした部分
+ UIButtonやUILabelに一工夫を加えた動き
 → 独自で実装をした部分
+ カスタムトランジションとアファイン変換を活用した3D回転のような画面遷移
 → 参考：[Custom UIViewController Transitions: Getting Started (raywnderlich.com)](https://www.raywenderlich.com/170144/custom-uiviewcontroller-transitions-getting-started)
+ アコーディオンのようにコンテンツを開閉して表示するUITableView
 → セクション単位で折りたたんでコンテンツを表示・非表示を切り替える動き
+ UIScrollViewとUIImageViewを組み合わせて拡大・縮小ができるフォトギャラリー
 → その他のアプリでもよくあるフォトギャラリーのようなUI

※ その他残りのアニメーションを伴うコンテンツ画面に関しては随時追加予定です。

## 本サンプルの画面キャプチャ

### 画面キャプチャその1

![今回のサンプルの画面一覧その1](https://qiita-image-store.s3.amazonaws.com/0/17400/ce8aa298-ad3a-7a8d-0999-b9b5c7c99327.jpeg)

### 画面キャプチャその2

![今回のサンプルの画面一覧その2](https://qiita-image-store.s3.amazonaws.com/0/17400/944d1fa7-2ef3-1fb2-a4c7-eca8387bdbb3.jpeg)

### 画面キャプチャその3

![今回のサンプルの画面一覧その3](https://camo.qiitausercontent.com/1c23f60a0dd284b5415206c02595da3e85afca89/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f63313034663336382d306666312d373631312d363666312d6435363866326665613266662e6a706567)

### 画面キャプチャその4

![今回のサンプルの画面一覧その4](https://camo.qiitausercontent.com/2aab7fb2fa280dd02fef162361c9d3b1029bafd2/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f34666464346238302d626439302d303338302d363163332d6339333530626134346138352e6a706567)

## InterfaceBuilder構造における図解

### Storyboardの構成①：メイン部分

![Storyboardの構成：その1](https://qiita-image-store.s3.amazonaws.com/0/17400/7fc74554-715e-6848-ee1e-05920d147395.jpeg)

### Storyboardの構成②：ストーリー部分

![Storyboardの構成：その2](https://camo.qiitausercontent.com/34ce33eb37cd876f55d5e7f3559f1043cf74bc57/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f37333331633464302d323535632d363762342d323062642d3666613139363465613339342e6a706567)

## MVP Pattern

![MVP Pattern](https://camo.qiitausercontent.com/59f931dba80c900f9fd99cf890ff16558bac950f/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f33633439646462372d313763612d636333342d306230312d3666383265316463653134642e6a706567)

## UI実装設計の重要ポイントになる部分

### 1. パララックス(視差効果)表現とフェードするアニメーションを組み合わせたアニメーション実装

![パララックス(視差効果)表現とフェードするアニメーションを組み合わせたアニメーション実装](https://camo.qiitausercontent.com/634c65258dd35010ae4fe25699c97c74c86dbde7/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f65616138383737622d613862342d653436312d396465332d6136633636323531623134362e6a706567)

__動きの仕様メモ：__

1. AutoLayoutのConstraintの変更を利用した画像のパララックス(視差効果)アニメーション
2. 表示するタイミングでのセル自体のアルファ値を変更するCoreAnimation

### 2. スクロールの変化量に応じてヘッダー画像とナビゲーションを変化させるアニメーション実装

![スクロールの変化量に応じてヘッダー画像とナビゲーションを変化させる](https://camo.qiitausercontent.com/fdfc3f6dd3103e5f0b541467c3c6ec8c8e6dd512/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f37343665366233322d333231622d653638382d633261322d6537326133643038306666372e6a706567)

__動きの仕様メモ：__

1. コンテンツが一番上にある状態で下にスクロールをすると、ヘッダー画像が伸びるような動きをする。
2. コンテンツが一番上にある状態で上にスクロールをすると、ヘッダー画像がずれながらダミーのヘッダーが徐々に現れる。（背景のアルファ値が1に近づきながら、タイトルと戻るボタンが下から徐々に現れる）
3. ヘッダー画像が完全に隠れたら、タイトルと戻るボタンは現れたままの状態になり、更に上へスクロールを続けても位置はそのまま固定されている。

### 3. カスタムトランジションとアファイン変換を活用した3D回転のような画面遷移に関する解説

![3D回転のような画面遷移をするためのカスタムトランジションの設定](https://camo.qiitausercontent.com/9a0968ec67c82fa191aa81f9c889f7e8993e9ed9/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f35313438633563322d643537622d363935362d393739372d6335306537353361636134342e6a706567)

__iOS13以降のOSに対応するための変更点：__

`StoryViewController.swift`に対応するInterfaceBuilder上に設定したModal遷移のSegueは下記の様に設定しています。

- Kind → 「Present Modally」に設定
- Presntation → 「Full Screen」に設定
- Transition → 「Cover Vertical」に設定

### 4. iPhoneXのSafeAreaの考慮と調整について

![iPhoneXのSafeAreaの考慮と調整について](https://camo.qiitausercontent.com/67cb94f05472ac138564fe8eb881fde5e96993b0/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f36313736613764662d623834352d383835392d383337322d3566303431356130636235392e6a706567)

__【追加コード】__

iPhoneXをはじめとする、ノッチがある端末の判定については値での判定をしないで下記のような形で判定する方が良さそうに思います。

```swift
// -----
// (1) ノッチ判定用のExtension
// -----
extension UIDevice {
    func hasNotch() -> Bool {
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }), keyWindow.safeAreaInsets.bottom > 0 {
            return true
        }
        return false
    }
}

// -----
// (2) SafeAreaの有無によって調整が必要な部分での利用例
// -----
// グラデーションヘッダー用のY軸方向の位置（iPhoneX用に補正あり）
private let gradientHeaderViewPositionY: CGFloat = {
    let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
    let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    return -statusBarHeight
}()

// ナビゲーションバーの高さ（iPhoneX用に補正あり）
private let navigationBarHeight: CGFloat = {
    if UIDevice.current.hasNotch() {
        return 88.5
    } else {
        return 64.0
    }
}()
```

### 5. UIScrollViewの活用

#### UIScrollViewとContainerViewを組み合わせてタブメニューUIを作成する

![UIScrollViewとContainerViewを組み合わせてタブメニューUIを作成する](https://camo.qiitausercontent.com/2285f75c05d738fe7b2f7ade89e831a4c76cd49b/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f36386536636639392d313265652d633831332d613866662d3133393633363735383130372e6a706567)

#### ScrollViewを利用して複雑なレイアウトを作成する

![ScrollViewを利用して複雑なレイアウトを作成する](https://camo.qiitausercontent.com/ac54f123fa2c21b43a711009244713dcbe033576/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f36356231326236622d653739362d343236642d343731332d3830633431306563316337312e6a706567)

### 6. UITableViewの表現

#### アコーディオンのようにコンテンツを開閉して表示するUITableView

![アコーディオンのようにコンテンツを開閉して表示するUITableView](https://camo.qiitausercontent.com/3f9c73d4d8c8105bd7a0d08cbc4b02e80a7ee76b/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f32333539336366362d346162612d366238302d336365352d3365633762333466653033322e6a706567)

__動きの仕様メモ：__

1. UITableViewのStyleを「Plain」から「Grouped」へ変更している。
2. セクションごとの更新は`storyRelatedTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic`)で行う
3. セルに表示するデータと表示・非表示の管理は`sectionStateLists: [(extended: Bool, genre: Genre)]`が行う。

### 7. その他UI表現に関する設定

細かな点になりますが、iOS13以降で改めて必要となった変更点についてのメモになります。

__従来通りのModal表示をするための追加対応 ※iOS13以上：__

※ 特にカスタムトランジションを伴う部分でこの実装を忘れてしまうと、画面遷移に不具合が発生する場合があります。

```swift
// カスタムトランジションのプロトコルを適用させる
let navigationController = UINavigationController(rootViewController: storyPageViewController)
navigationController.transitioningDelegate = self

// Modalの画面遷移を実行する
// MEMO: iOS13以降のPresent/Dismiss時の調整
// Present/Dismissで実行するカスタムトランジションの場合ではこの設定を忘れると画面遷移がおかしくなるので注意
if #available(iOS 13.0, *) {
    navigationController.modalPresentationStyle = .fullScreen
}
self.present(navigationController, animated: true, completion: nil)
```

__UINavigationBarにおけるBackButton長押しの無効化 ※iOS14以上：__

※ UIBarButtonItemを継承したクラスを用意し、長押しメニューのsetter部分を空にしてしまう形に変更します。

```swift
// UIViewControllerの拡張
extension UIViewController {

    // 戻るボタンの「戻る」テキストを削除した状態にするメソッド
    func removeBackButtonText() {
        let backButtonItem = BackBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = backButtonItem
    }
}

class BackBarButtonItem: UIBarButtonItem {
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        set {
            // MEMO: 長押しメニューを消去する
            // Do Nothing.
        }
        get {
            return super.menu
        }
    }
}
```

__Scrollの挙動に合わせたUINavigation部分に重ねる変化を加える場合の補足 ※iOS15以上：__

iOS15以上

```swift
// -----
// (1) UINavigationBarを透過する部分の抜粋
// -----
// NavigationControllerのカスタマイズを行う
if #available(iOS 15.0, *) {
 
    // MEMO: iOS14以前で実施していた調整をiOS15で実施する場合には、
    // self.navigationController?.navigationBar → navigationBarAppearanceで設定していく方針を取ることになります。
    // ※ navigationBarAppearanceでは便利なプロパティも増えています。
    let navigationBarAppearance = UINavigationBarAppearance()
    navigationBarAppearance.configureWithOpaqueBackground()
    navigationBarAppearance.titleTextAttributes = [
        NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
        NSAttributedString.Key.foregroundColor : UIColor.clear
    ]
    navigationBarAppearance.backgroundColor = UIColor.clear
    navigationBarAppearance.shadowColor = UIColor.clear
    navigationBarAppearance.shadowImage = UIImage()

    UINavigationBar.appearance().isTranslucent = true
    UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

} else {

    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.tintColor = UIColor.white
    self.navigationItem.hidesBackButton = true
}

// -----
// (2) 普通にUINavigationBarを表示する部分の抜粋
// -----
// MEMO: 遷移元となるArticleViewControllerでUINavigationBarで変更を加えてしまっているので、この部分で元の設定を再度適用する
if #available(iOS 15.0, *) {

    let navigationBarAppearance = UINavigationBarAppearance()
    navigationBarAppearance.configureWithOpaqueBackground()
    navigationBarAppearance.titleTextAttributes = [
        NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Bold", size: 14.0)!,
        NSAttributedString.Key.foregroundColor : UIColor.white
    ]
    navigationBarAppearance.backgroundColor = UIColor(code: "#76b6e2")
    UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

} else {

    self.navigationController?.navigationBar.barTintColor = ColorDefinition.navigationColor.getColor()
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.tintColor = UIColor.white
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
}
```

## 使用ライブラリ

UIまわりの実装と直接関係のない部分に関しては、下記のライブラリを使用しました。

| ライブラリ名 | 当該ライブラリの用途 |
| :--- | :--- |
| [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) | JSONデータの解析をしやすくする |
| [Alamofire](https://github.com/Alamofire/Alamofire) | HTTP/HTTPSのネットワーク通信用 |
| [SDWebImage](https://github.com/rs/SDWebImage) | 画像URLからの非同期での画像表示とキャッシュサポート |
| [FontAwesome.swift](https://github.com/thii/FontAwesome.swift) | 「Font Awesome」アイコンの利用 |
| [PromiseKit](https://github.com/mxcl/PromiseKit) | APIリクエスト送信＆レスポンス取得の非同期処理ハンドリング |

__補足事項：__

1. AlamofireについてはVer5.x系からは実装方法が大きく変化があった部分になります。
  → [Alamofire 5 Tutorial for iOS: Getting Started](https://www.raywenderlich.com/6587213-alamofire-5-tutorial-for-ios-getting-started)
2. API通信処理部分における`Success(成功)`＆`Failure(失敗)`時のハンドリング処理部分にはPromiseKitを利用してPresenter側でも処理がわかりやすくなる様にしています。

## 解説記事

このサンプル全体の詳細解説とポイントをまとめたものは下記に掲載しております。

+ (Qiita前編) https://qiita.com/fumiyasac@github/items/d1b56ffc6d7d46c0a616 
+ (Qiita後編) https://qiita.com/fumiyasac@github/items/b694f9859cbb61c95c1a
