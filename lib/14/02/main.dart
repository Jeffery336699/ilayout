import 'package:flutter/material.dart';

void main() {
  runApp(Directionality(
    textDirection: TextDirection.ltr,
    child: Align(
      alignment: Alignment.topRight,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // constraints2:BoxConstraints(0.0<=w<=450.0, 0.0<=h<=800.0)
          print('constraints2:$constraints');
          // IntrinsicHeight 让 Row 变得和它里面最高的子组件一样高，
          // 然后 Row 内部没有指定高度的子组件就会被拉伸到这个高度。
          // 这种拉伸只会发生在没有指定高度的子组件上。
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 120,
                  color: Colors.red,
                ),
                Container(
                  width: 40,
                  height: 80,
                  color: Colors.blue,
                ),
                Container(
                  width: 40,
                  color: Colors.green,
                ),
              ],
            ),
          );
        },
      ),
    ),
  ));
}
