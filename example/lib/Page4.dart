import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import 'base/BasefulWidget.dart';

class Page4 extends BasefulWidget {
  @override
  BasefulWidgetState<BasefulWidget> getState() {
    // TODO: implement getState
    return new Page4State();
  }


}

class Page4State extends BasefulWidgetState<Page4>{
  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text('page4'),
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

