# InteractiveUISample 
[ING]ライブラリを使わないでアニメーション表現を盛り込んだ機能サンプル（iOS Sample Study: Swift）

UIのスクロールやタブUIの切り替えを伴うようなコンテンツにて動きの中でポイントとなりそうな部分にアニメーション不自然にならない心地よいタイミングでに盛り込むプラクティスをするために作成したサンプルになります。

### 実装機能一覧

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

### 本サンプルの画面キャプチャ

#### 画面キャプチャその1

![今回のサンプルの画面一覧その1](https://qiita-image-store.s3.amazonaws.com/0/17400/ce8aa298-ad3a-7a8d-0999-b9b5c7c99327.jpeg)

#### 画面キャプチャその2

![今回のサンプルの画面一覧その2](https://qiita-image-store.s3.amazonaws.com/0/17400/944d1fa7-2ef3-1fb2-a4c7-eca8387bdbb3.jpeg)

#### 画面キャプチャその3

![今回のサンプルの画面一覧その3](https://camo.qiitausercontent.com/1c23f60a0dd284b5415206c02595da3e85afca89/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f63313034663336382d306666312d373631312d363666312d6435363866326665613266662e6a706567)

#### 画面キャプチャその4

![今回のサンプルの画面一覧その4](https://camo.qiitausercontent.com/2aab7fb2fa280dd02fef162361c9d3b1029bafd2/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f34666464346238302d626439302d303338302d363163332d6339333530626134346138352e6a706567)

#### Storyboardの構成①：メイン部分

![Storyboardの構成：その1](https://qiita-image-store.s3.amazonaws.com/0/17400/7fc74554-715e-6848-ee1e-05920d147395.jpeg)

#### Storyboardの構成②：ストーリー部分

![Storyboardの構成：その2](https://camo.qiitausercontent.com/34ce33eb37cd876f55d5e7f3559f1043cf74bc57/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f37333331633464302d323535632d363762342d323062642d3666613139363465613339342e6a706567)

#### MVP Pattern

![MVP Pattern](https://camo.qiitausercontent.com/59f931dba80c900f9fd99cf890ff16558bac950f/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f33633439646462372d313763612d636333342d306230312d3666383265316463653134642e6a706567)

### 設計の重要ポイントになる部分

#### パララックス(視差効果)表現とフェードするアニメーションを組み合わせたアニメーション実装

![パララックス(視差効果)表現とフェードするアニメーションを組み合わせたアニメーション実装](https://camo.qiitausercontent.com/634c65258dd35010ae4fe25699c97c74c86dbde7/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f65616138383737622d613862342d653436312d396465332d6136633636323531623134362e6a706567)

__動きの仕様メモ：__

1. AutoLayoutのConstraintの変更を利用した画像のパララックス(視差効果)アニメーション
2. 表示するタイミングでのセル自体のアルファ値を変更するCoreAnimation

#### スクロールの変化量に応じてヘッダー画像とナビゲーションを変化させるアニメーション実装

![スクロールの変化量に応じてヘッダー画像とナビゲーションを変化させる](https://camo.qiitausercontent.com/fdfc3f6dd3103e5f0b541467c3c6ec8c8e6dd512/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f37343665366233322d333231622d653638382d633261322d6537326133643038306666372e6a706567)

__動きの仕様メモ：__

1. コンテンツが一番上にある状態で下にスクロールをすると、ヘッダー画像が伸びるような動きをする。
2. コンテンツが一番上にある状態で上にスクロールをすると、ヘッダー画像がずれながらダミーのヘッダーが徐々に現れる。（背景のアルファ値が1に近づきながら、タイトルと戻るボタンが下から徐々に現れる）
3. ヘッダー画像が完全に隠れたら、タイトルと戻るボタンは現れたままの状態になり、更に上へスクロールを続けても位置はそのまま固定されている。

#### カスタムトランジションとアファイン変換を活用した3D回転のような画面遷移に関する解説

![3D回転のような画面遷移をするためのカスタムトランジションの設定](https://camo.qiitausercontent.com/9a0968ec67c82fa191aa81f9c889f7e8993e9ed9/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f35313438633563322d643537622d363935362d393739372d6335306537353361636134342e6a706567)

#### iPhoneXのSafeAreaの考慮と調整について

![iPhoneXのSafeAreaの考慮と調整について](https://camo.qiitausercontent.com/67cb94f05472ac138564fe8eb881fde5e96993b0/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f36313736613764662d623834352d383835392d383337322d3566303431356130636235392e6a706567)

### (補足1)UIScrollViewの活用

#### UIScrollViewとContainerViewを組み合わせてタブメニューUIを作成する

![UIScrollViewとContainerViewを組み合わせてタブメニューUIを作成する](https://camo.qiitausercontent.com/2285f75c05d738fe7b2f7ade89e831a4c76cd49b/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f36386536636639392d313265652d633831332d613866662d3133393633363735383130372e6a706567)

#### ScrollViewを利用して複雑なレイアウトを作成する

![ScrollViewを利用して複雑なレイアウトを作成する](https://camo.qiitausercontent.com/ac54f123fa2c21b43a711009244713dcbe033576/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f36356231326236622d653739362d343236642d343731332d3830633431306563316337312e6a706567)

### (補足2)UITableViewの表現

#### アコーディオンのようにコンテンツを開閉して表示するUITableView

![アコーディオンのようにコンテンツを開閉して表示するUITableView](https://camo.qiitausercontent.com/3f9c73d4d8c8105bd7a0d08cbc4b02e80a7ee76b/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f32333539336366362d346162612d366238302d336365352d3365633762333466653033322e6a706567)

__動きの仕様メモ：__

1. UITableViewのStyleを「Plain」から「Grouped」へ変更している。
2. セクションごとの更新は`storyRelatedTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic`)で行う
3. セルに表示するデータと表示・非表示の管理は`sectionStateLists: [(extended: Bool, genre: Genre)]`が行う。

### 使用ライブラリ

UIまわりの実装と直接関係のない部分に関しては、下記のライブラリを使用しました。

+ [SwiftyJSON（JSONデータの解析をしやすくする）](https://github.com/SwiftyJSON/SwiftyJSON)
+ [Alamofire（HTTPないしはHTTPSのネットワーク通信用）](https://github.com/Alamofire/Alamofire)
+ [SDWebImage（画像URLからの非同期での画像表示とキャッシュサポート）](https://github.com/rs/SDWebImage)
+ [FontAwesome.swift（「Font Awesome」アイコンの利用）](https://github.com/thii/FontAwesome.swift)

このサンプル全体の詳細解説とポイントをまとめたものは下記に掲載しております。

+ (Qiita前編) https://qiita.com/fumiyasac@github/items/d1b56ffc6d7d46c0a616 
+ (Qiita後編) https://qiita.com/fumiyasac@github/items/b694f9859cbb61c95c1a
