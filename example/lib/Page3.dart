import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import 'base/BasefulWidget.dart';

class Page3 extends BasefulWidget {
  @override
  BasefulWidgetState<BasefulWidget> getState() {
    // TODO: implement getState
    return new Page3State();
  }


}

class Page3State extends BasefulWidgetState<Page3>{
  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text('page3'),
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

