import 'package:cameraa/common/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:io';

class PreviewImageScreen extends StatelessWidget {
  final String imagePath;

  const PreviewImageScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.file(File(imagePath)),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Save this image to gallery?',
                    style: TextStyle(fontSize: 26, color: Colors.white60),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        GallerySaver.saveImage(imagePath);
                        showSnackBar(context, 'The image has been saved', 1);
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.check,
                        size: 55,
                        color: Colors.green,
                      ),
                    ),
                    FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        showSnackBar(
                            context, 'The image has been discarded', 0);
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        size: 55,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
