// Flutterのマテリアルデザインパッケージとgo_routerパッケージをインポートします。
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// PageAはStatelessWidgetを継承したクラスで、アプリケーションの一部を表現します。
class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarを作成し、タイトルに'Page A'を設定します。
      appBar: AppBar(title: Text('Page A')),
      // ボディ部分にはCenterウィジェットを使用して、その子要素を画面中央に配置します。
      body: Center(
        // ElevatedButton（ボタン）を作成し、そのonPressedコールバックには画面遷移の処理を記述します。
        child: ElevatedButton(
          onPressed: () {
            // go_routerのgoメソッドを使用して、'/takePicture'ルートに遷移します。
            debugPrint("onPressed");
            context.push('/takePicture');
          },
          // ボタンのラベルには'Take Picture Screen'というテキストを設定します。
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}
