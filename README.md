# Event Pair Flutter学習プロジェクト

Event Pairを題材に、FlutterとFirebaseを学習するためのプロジェクトです。

現在はファイル構造だけを用意しており、アプリを起動すると「サンプル」と表示されます。

## 開発を始める

### VS Codeで起動する

1. VS Codeの「実行とデバッグ」を開きます。
2. `Flutter: iOS Simulator (Hot Reload)`を選びます。
3. `F5`を押してdebugモードで起動します。
4. Dartファイルを保存すると、自動でHot Reloadされます。

Hot Reloadを使うには、右上の通常実行ではなく、上記のdebug設定から起動してください。

Hot Reloadで反映されない変更もあります。`main()`、Firebase初期化、`initState()`、アプリ起動時に一度だけ作られる値を変えた場合は、Hot Restartを使ってください。

### ターミナルから起動する

プロジェクト直下で次を実行します。

```shell
./tool/run_ios.sh
```

Simulatorの起動からFlutterのdebug接続まで自動で行います。起動後のターミナルで`r`を押すとHot Reload、`R`を押すとHot Restart、`q`を押すと終了します。

Xcodeの選択状態に関係なく動作するよう、プロジェクト側で`DEVELOPER_DIR`を設定しています。

## 最初に見るファイル

初めてプロジェクトを開いたときは、次の順番で確認します。

```text
lib/main.dart
    ↓
lib/app.dart
    ↓
lib/features/
```

### `lib/main.dart`

アプリの開始地点です。

Flutterアプリを起動すると、最初に`main()`が実行されます。
現在は`EventPairApp`を起動する処理だけが書かれています。

```dart
void main() {
  runApp(const EventPairApp());
}
```

基本的に、画面の内容や機能を`main.dart`へ直接書きません。

### `lib/app.dart`

アプリ全体の設定を行うファイルです。

主に次の内容を扱います。

- アプリ名
- 全体の色やデザイン
- 最初に表示する画面
- 画面遷移の設定

現在は、画面中央に「サンプル」と表示するだけの状態です。

## `lib`フォルダ

自分たちが書くFlutterコードの中心です。

```text
lib/
├── main.dart
├── app.dart
├── core/
│   └── sample.dart
├── shared/
│   └── sample.dart
└── features/
    ├── discovery/
    │   └── sample.dart
    ├── recruitment/
    │   └── sample.dart
    ├── application/
    │   └── sample.dart
    ├── matching/
    │   └── sample.dart
    └── meetup/
        └── sample.dart
```

### `lib/core/`

アプリ全体を動かすための共通設定を置きます。

例:

- アプリ全体の色
- 画面遷移
- Firebaseの初期設定
- アプリ全体で使用する定数

特定の機能だけで使うコードは置きません。

### `lib/shared/`

複数の機能で共通して使う部品を置きます。

例:

- 共通ボタン
- ユーザー情報
- ローディング表示
- エラーメッセージ

最初から何でも`shared`へ置くのではなく、実際に複数の機能で必要になってから移します。

## `lib/features`フォルダ

アプリの機能を、モック画像の番号ごとに分けています。

| 番号 | フォルダ | 担当する機能 |
| --- | --- | --- |
| 1 | `discovery/` | イベントを見つける |
| 2 | `recruitment/` | 同行者を募集する |
| 3 | `application/` | 募集へ申請する |
| 4 | `matching/` | ペア成立とチャット |
| 5 | `meetup/` | 集合情報を確認する |

### `lib/features/discovery/`

番号1「見つける」のコードを置きます。

例:

- イベント一覧画面
- イベント詳細画面
- イベントカード
- イベント情報

### `lib/features/recruitment/`

番号2「募集する」のコードを置きます。

例:

- 募集作成画面
- 募集人数の入力
- 集合時間の入力
- 募集内容の投稿

### `lib/features/application/`

番号3「申請する」のコードを置きます。

例:

- 申請画面
- 申請メッセージ
- 申請状態の表示

### `lib/features/matching/`

番号4「ペア成立・チャット」のコードを置きます。

例:

- 申請の承認
- ペア成立画面
- チャット画面
- メッセージ送信

### `lib/features/meetup/`

番号5「集合」のコードを置きます。

例:

- 集合時刻
- 集合場所
- 当日の予定
- 持ち物メモ

## 機能フォルダの中身

機能が大きくなったら、次のように分けます。

```text
discovery/
├── data/       データの取得や保存
├── models/     データの形
├── screens/    画面全体
└── widgets/    画面内で使う小さな部品
```

### `data/`

Firebaseや仮データとのやり取りを担当します。

画面から直接Firebaseへアクセスする処理を減らすために使用します。

### `models/`

アプリで扱うデータの形を定義します。

例えばイベントなら、イベント名、開催日時、場所などをまとめます。

### `screens/`

スマートフォンに表示される画面全体を置きます。

例:

- イベント一覧画面
- 募集作成画面
- チャット画面

### `widgets/`

画面の一部分として再利用するUI部品を置きます。

例:

- イベントカード
- プロフィール画像
- メッセージ表示

## プロジェクト直下のファイル

### `pubspec.yaml`

Flutterプロジェクトの設定ファイルです。

主に次の内容を登録します。

- Firebaseなどの外部パッケージ
- 使用する画像
- 使用するフォント
- アプリのバージョン

新しいパッケージや画像を追加するときに編集します。

### `pubspec.lock`

実際に使用しているパッケージのバージョンが記録されています。

Flutterが自動的に更新するため、基本的に手作業では編集しません。

### `analysis_options.yaml`

Dartコードの書き方をチェックするためのルールです。

間違いや、推奨されない書き方をエディタへ表示するために使用します。

### `test/`

アプリが期待どおり動いているか確認するテストコードを置きます。

現在は、画面に「サンプル」と表示されることを確認しています。

### `ios/`

iPhoneアプリとして動かすための設定が入っています。

アプリ名、権限、署名など、iPhone固有の設定が必要なときに触ります。

Flutterの画面作成だけなら、普段は編集しません。

### `web/`

Webブラウザで動かすための設定が入っています。

今回はiPhone向けアプリが中心なので、基本的に編集しません。

### `build/`

アプリを実行・ビルドしたときに自動生成されるファイルです。

自分でコードを書く場所ではありません。
削除しても、次回のビルド時に再作成されます。

### `.dart_tool/`

DartとFlutterが内部で使用する自動生成フォルダです。

基本的に編集しません。

### `.vscode/`

VS Codeでの実行方法やHot Reloadの設定が入っています。

### `tool/`

開発を補助するスクリプトを置きます。

`run_ios.sh`はiPhone Simulatorを起動し、Flutterをdebugモードで接続します。

### `.metadata`と`.idea/`

Flutterや開発ツールが使用する管理情報です。

通常は編集しません。

### `.DS_Store`

macOSが自動生成するファイルです。

アプリのコードではないため、編集しません。

## よく編集する場所

学習中に主に触るのは次の場所です。

```text
lib/
test/
pubspec.yaml
```

次の場所は、必要になるまで触らなくて大丈夫です。

```text
ios/
web/
analysis_options.yaml
```

次の場所は自動生成なので、基本的に触りません。

```text
build/
.dart_tool/
pubspec.lock
```

## 動作確認

プロジェクトのフォルダで次を実行します。

```bash
flutter analyze
flutter test
```

アプリをSimulatorで起動する場合は、次を実行します。

```bash
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer \
flutter run -d 1408BF6F-BC9F-4CB1-8B07-78FC62703B8D
```

起動中のターミナルで`r`を押すとHot Reload、`q`を押すと終了します。

`main()`、Firebase初期化、`initState()`、アプリ起動時に一度だけ作られる値を変えた場合は、`R`でHot Restartします。
