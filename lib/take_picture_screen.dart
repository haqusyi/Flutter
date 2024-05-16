// DartのI/OとFlutterのカメラとマテリアルデザインパッケージをインポートします。
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// TakePictureScreenは写真撮影画面で、StatefulWidgetを継承しています。
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({required this.camera, Key? key}) : super(key: key);

  // 状態オブジェクトを作成します。
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

// TakePictureScreenStateはTakePictureScreenの状態を管理します。
class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String? _imagePath; // 撮影した写真のパスを保持する変数を定義します。

  // 初期化メソッドでカメラコントローラを設定します。
  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  // 破棄メソッドでカメラコントローラを破棄します。
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ビルドメソッドでUIを作成します。カメラが初期化されている場合はカメラプレビューを表示し、そうでない場合はローディングインジケータを表示します。
  // 撮影した写真がある場合はその写真を表示します。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('カメラ撮影')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          if (_imagePath != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(File(_imagePath!)),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            setState(() {
              _imagePath = image.path;
            });
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
