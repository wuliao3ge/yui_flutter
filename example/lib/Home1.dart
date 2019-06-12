import 'package:flutter/material.dart';
import 'package:yui_flutter/button/index.dart';
import 'package:yui_flutter/toast/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            YuiButton(
              '按钮',
              onClick: (){
                YuiToast.info(context)('测试');
              },
              loading: isLoading,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLoading = !isLoading;
          });
//          Navigator.of(context)
//              .push(MaterialPageRoute(builder: (context) => SecondScreen()));
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
