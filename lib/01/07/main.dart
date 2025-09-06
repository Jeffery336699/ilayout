import 'package:flutter/material.dart';

void main() {
  runApp(
    CustomSingleChildLayout(
      delegate: DiyLayoutDelegate(),
      child:  SizedBox(width:10,height:10,child: ColoredBox(color: Colors.blue)),
    ),
  );
}

class DiyLayoutDelegate extends SingleChildLayoutDelegate {
  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;

  @override
  Size getSize(BoxConstraints constraints) {
    print("getSize====constraints:$constraints");
    return super.getSize(constraints);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    print("getPositionForChild====size:$size====childSize:$childSize");

    //这里返回的坐标是相对于父组件左上角的偏移
    return Offset(100, 100);
    // return super.getPositionForChild(size, childSize);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    print("getConstraintsForChild====constraints:$constraints");
    // return BoxConstraints.tight(const Size(100, 100));
    // return BoxConstraints.expand();
    return BoxConstraints.loose(constraints.biggest);
  }
}
