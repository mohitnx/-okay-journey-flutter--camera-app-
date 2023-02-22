import 'package:camera/camera.dart';
import 'package:cameraa/screens/image_preview.dart';

import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    this.cameras,
    super.key,
  });
  final List<CameraDescription>? cameras;

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  bool isRearOpen = true;
  bool isFlashOpen = false;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    initCamera(widget.cameras![0]);
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // showing camera
            return SizedBox(height: height, child: CameraPreview(_controller));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Opacity(
              opacity: 0.5,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    isRearOpen = !isRearOpen;
                    initCamera(widget.cameras![isRearOpen ? 0 : 1]);
                  });
                },
                child: Icon(
                  isRearOpen
                      ? Icons.switch_camera
                      : Icons.switch_camera_outlined,
                ),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: RawMaterialButton(
                focusElevation: 0,
                fillColor: Colors.transparent,
                elevation: 0,
                onPressed: () async {
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    final image = await _controller.takePicture();

                    if (!mounted) return;

                    // If the picture was taken, display it on a new screen.
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PreviewImageScreen(
                          imagePath: image.path,
                        ),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Icon(
                  Icons.circle_outlined,
                  size: 130,
                ),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    isFlashOpen = !isFlashOpen;
                    _controller.setFlashMode(
                        isFlashOpen ? FlashMode.auto : FlashMode.off);
                  });
                },
                child: Icon(isFlashOpen ? Icons.flash_auto : Icons.flash_off),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
