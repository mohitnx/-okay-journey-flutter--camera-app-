import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, int i) {
  //same int i used to determine snackbar title and color
  List<String> snackbarTitle = ['Canceled!', 'Success!'];

  List<Color> snackbarColor = const [
    Color.fromARGB(255, 200, 55, 77),
    Color.fromARGB(255, 23, 117, 81)
  ];

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 22, top: 16, bottom: 18, right: 18),
            decoration: BoxDecoration(
              color: snackbarColor[i],
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            height: 80,
            child: Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snackbarTitle[i],
                        style:
                            const TextStyle(fontSize: 21, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        text,
                        maxLines: 2,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
