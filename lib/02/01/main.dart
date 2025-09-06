import 'package:flutter/material.dart';

void main() {
  runApp(
    const LayoutBuilder(builder: _buildByLayout),
  );
}

Widget _buildByLayout(BuildContext context, BoxConstraints constraints) {
  print(constraints); // BoxConstraints(w=450.0, h=800.0)
  return const ColoredBox(
    color: Colors.white,
    child: Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: 100,
        height: 100,
        child: ColoredBox(color: Colors.blue),
      ),
    ),
  );
}
