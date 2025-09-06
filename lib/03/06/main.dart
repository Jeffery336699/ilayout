import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          child: LoopLayout(
            // left: LoopLayout(),
            // center: LoopLayout(
            //   center: LoopLayout(
            //     center: LoopLayout(
            //       center: LoopLayout(
            //         center: LoopLayout(
            //           center: LoopLayout(
            //             center: LoopLayout(
            //               center: LoopLayout(),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ),
        ));
  }
}

class LoopLayout extends StatelessWidget {
  final Widget? center;
  final Widget? left;

  const LoopLayout({Key? key, this.center,this.left}) : super(key: key);

  Widget get decoratedBox {
    return DecoratedBox(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // constraints1=>BoxConstraints(w=450.0, h=800.0)
        print('constraints1=>$constraints');
        return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 1,
              child: left != null
                  ? left!
                  : ColoredBox(color: Colors.red, child: decoratedBox)),
          Expanded(flex: 4, child: _buildCenter()),
          Expanded(
              flex: 1,
              child: ColoredBox(color: Colors.blue, child: decoratedBox)),
        ],
      ); },
    );
  }

  Widget _buildCenter() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // constraints2=>BoxConstraints(w=300.0, h=800.0),传递过来的紧约束，这不跟刚开始一样吗（紧约束为屏幕）
        print('constraints2=>$constraints');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 1,
                child: ColoredBox(color: Colors.orange, child: decoratedBox)),
            Expanded(
                flex: 4,
                child: center != null
                    ? center!
                    : ColoredBox(color: Colors.cyanAccent, child: decoratedBox)),
            Expanded(
                flex: 1,
                child: ColoredBox(color: Colors.green, child: decoratedBox)),
          ],
        );
      },
    );
  }
}
