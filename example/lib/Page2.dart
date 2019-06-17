import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:yui_flutter/button/index.dart';
import 'package:yui_flutter/theme/index.dart';
import 'package:yui_flutter/toast/index.dart';

import 'base/BasefulWidget.dart';

class Page2 extends BasefulWidget {
  @override
  BasefulWidgetState<BasefulWidget> getState() {
    // TODO: implement getState
    return new Page2State();
  }


}

class Page2State extends BasefulWidgetState<Page2>{
  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(height: 100,),
        FlatButton(
          color: Colors.red,
          child:Text('测试'),

        ),

        YuiButton(
          '按钮',
          disabled: true,
          onClick: (){
            Provide.value<YuiTheme>(context).$setPrimaryColr(Colors.red);
            YuiToast.info(context)('测试');
          },
//              loading: isLoading,
        ),
      ],
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setAppBarVisible(false);
    setTopBarVisible(false);
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }
}

