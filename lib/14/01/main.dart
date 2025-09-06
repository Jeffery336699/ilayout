import 'package:flutter/material.dart';

void main() {
  runApp(Directionality(
    textDirection: TextDirection.ltr,
    ///这里失效的原因是没有把父类的紧约束改为松约束
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // constraints：BoxConstraints(w=450.0, h=800.0)
        print('constraints：$constraints');
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                // height: 120,
                color: Colors.red,
              ),
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 20,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    color: Colors.green,
                  ),
                  Container(
                    width: 100,
                    color: Colors.green,
                  )
                ],
              )
            ],
          ),
        );
      },
    ),
  ));
}
