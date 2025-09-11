import 'package:flutter/material.dart';

void main() {
  var text1 = Text("Hello", style: TextStyle(color: Colors.blue));
  var text2 = Text("Hello", style: TextStyle(color: Colors.blue));
  ///0.看这里不相等就能说明后续的==操作符中，关于didUpdateWidget的判断是有意义的
  print(identical(text1, text2)); // false，两个实例
  print(text1 == text2); // false，虽然是两个实例，内部没有重写==操作符了
  print('-----------------------11---------------------');
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:ParentWidget()));
}


class ParentWidget extends StatefulWidget {
  const ParentWidget({Key? key}) : super(key: key);

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  int counter = 0;
  String title = "计数器";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///1.会走didUpdateWidget方法
            // OptimizedWidget(title: "111", count: 1),

            ///2.不会走didUpdateWidget方法
            const OptimizedWidget(title: "222", count: 2),

            OptimizedWidget(title: title, count: counter),


            ElevatedButton(
              onPressed: () {
                setState(() {
                  // counter=counter; // 只有counter变化，Widget会重建
                });
              },
              child: Text('增加计数'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  // 仍然由回调didUpdateWidget函数
                });
              },
              child: Text('空更新'),
            ),
          ],
        ),
      ),
    );
  }
}

class OptimizedWidget extends StatefulWidget {
  final String title;
  final int count;

  const OptimizedWidget({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  ///3.重写==操作符和hashCode方法，这样在上面参数不变时，Flutter就不会调用didUpdateWidget方法(此时的build方法也不会调用)
  ///  原因在ComponentElement的updateChild方法中，注意这里便捷的直接==操作符
  ///  ```
  ///     if (hasSameSuperclass && child.widget == newWidget) {
  ///         // We don't insert a timeline event here, because otherwise it's
  ///         // confusing that widgets that "don't update" (because they didn't
  ///         // change) get "charged" on the timeline.
  ///         if (child.slot != newSlot) {
  ///           updateSlotForChild(child, newSlot);
  ///         }
  ///         newChild = child;
  ///       }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is OptimizedWidget
        && other.title == title
        && other.count == count;
  }

  @override
  int get hashCode => Object.hash(title, count);

  @override
  State<StatefulWidget> createState()=> _OptimizedWidgetState();
}

class _OptimizedWidgetState extends State<OptimizedWidget> {
  @override
  Widget build(BuildContext context) {
    print('OptimizedWidget State build被调用: ${widget.title} - ${widget.count}');
    return Text('${widget.title}: ${widget.count}');
  }

  @override
  void didUpdateWidget(covariant OptimizedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('OptimizedWidget didUpdateWidget: ${oldWidget.title} - ${oldWidget.count} -> ${widget.title} - ${widget.count}');
  }

}