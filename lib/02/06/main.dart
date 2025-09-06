import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        home: Flex(
          direction: Axis.horizontal,
          children: [
            LayoutBuilder(
                builder: (_, c) {
                  //BoxConstraints(0.0<=w<=Infinity, 0.0<=h<=800.0)
                  print(c);
                  return Container(
                    color: Colors.blue,
                    width: 100,
                    height: 100,
                  );
                }
            ),
          ],
        ),
      );
  }
}


