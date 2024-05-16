// Flutterのマテリアルデザインパッケージ、go_routerパッケージ、カメラパッケージをインポートします。
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:camera/camera.dart';

import 'pageA.dart';
import 'take_picture_screen.dart';

// アプリケーションのエントリーポイントです。ここでカメラを初期化し、アプリケーションを起動します。
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

// MyAppはメインアプリケーションで、StatelessWidgetを継承しています。
class MyApp extends StatelessWidget {
  final CameraDescription camera;

  MyApp({required this.camera});

  // ビルドメソッドでUIを作成します。GoRouterを使用してルーティングを設定します。
  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => PageA(),
        ),
        GoRoute(
          path: '/takePicture',
          builder: (context, state) => TakePictureScreen(camera: camera),
        ),
      ],
    );

    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      title: 'カメラのテスト',
      theme: ThemeData(),
    );
  }
}
