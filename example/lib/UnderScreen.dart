import 'package:flutter/material.dart';
import 'package:yui_flutter/button/index.dart';
import 'package:yui_flutter/store/index.dart';
import 'package:yui_flutter/theme/index.dart';
import 'package:yui_flutter/toast/index.dart';
import 'package:yui_flutter_example/second_screen.dart';

class UnderScreen extends StatefulWidget {
  @override
  _UnderScreenState createState() => _UnderScreenState();
}

class _UnderScreenState extends State<UnderScreen> {


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
