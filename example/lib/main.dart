import 'package:flutter/material.dart';
import 'package:yui_flutter/theme/index.dart';
import 'package:yui_flutter_example/Home.dart';
import 'package:yui_flutter/yui.dart';

void main() => runApp(
    YuiView.init(
      child: MyApp(),
      yuitheme: new YuiTheme(primaryColor: Colors.red)
    )
);


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
