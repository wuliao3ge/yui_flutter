import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

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
    return Container(
      child: Text('123456'),
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

