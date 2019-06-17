import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:yui_flutter/config/index.dart';
import 'package:yui_flutter/theme/index.dart';
import 'package:yui_flutter_example/Home1.dart';
import 'package:yui_flutter/yui.dart';

import 'HomePage.dart';

void main() => runApp(
    YuiView.init(
      child: MyApp(),
      yuitheme: new YuiTheme()
    )
);


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provide<YuiTheme>(
      builder: (context, child, model) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
              primaryColor: model.primaryColor,
          ),
          home: Home(),
        );
      },
    );

  }
}
