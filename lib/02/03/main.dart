
import 'package:flutter/material.dart';

void main() {
  runApp(LayoutBuilder(
    builder: (context,constraints) {
      return  MyApp(constraints);
    }
  ),);
}

class MyApp extends StatelessWidget {
  final BoxConstraints rootBoxConstraints;
  const MyApp(this.rootBoxConstraints,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: LayoutBuilder(
        builder: (context, constraints) {
          ///根传递下来的虽然值相等，当不是同一对象（如果是同一个对象，那不你就能随便更改了🤣）
          // false
          print(identical(constraints,rootBoxConstraints));
          // true
          print(constraints==rootBoxConstraints);
          return Container(color: Colors.blue);
        }
      ),
    );
  }
}

