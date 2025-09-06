import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Scaffold的body,变为宽松约束了
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            print(constraints); // BoxConstraints(0.0<=w<=450.0, 0.0<=h<=800.0)
            return Container(
              color: Colors.blue,
              width: 100,
              height: 100,
            );
          },
        ),
      ),
    );
  }
}
