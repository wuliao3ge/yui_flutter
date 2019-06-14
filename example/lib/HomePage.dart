import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:yui_flutter/button/index.dart';
import 'package:yui_flutter/toast/index.dart';

import 'Page2.dart';
import 'Page3.dart';
import 'Page4.dart';
import 'base/BasefulWidget.dart';

class Home extends BasefulWidget {
  @override
  BasefulWidgetState<BasefulWidget> getState() {
    // TODO: implement getState
    return new HomePage();
  }
}

class HomePage extends BasefulWidgetState<Home>{
  bool isLoading = false;
  @override
  void onCreate() {
    // TODO: implement onCreate
    print('onCreate');
    initData();
    setAppBarTitle("首页");
//    setTopBarVisible(false);
//    setAppBarVisible(false);
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }



  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: _pageList[_tabIndex],
        bottomNavigationBar: new BottomNavigationBar(
          backgroundColor: Colors.blue,
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(

                icon: getTabIcon(0), title: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1), title: getTabTitle(1)),
            new BottomNavigationBarItem(
                icon: getTabIcon(2), title: getTabTitle(2)),
          ],
          type: BottomNavigationBarType.fixed,
          //默认选中首页
          currentIndex: _tabIndex,
          iconSize: 24.0,
          //点击事件
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ));
  }



  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '通讯录', '我的'];
  /*
   * 存放三个页面，跟fragmentList一样
   */
  var _pageList;

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }
  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xFF1a90db)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff515151)));
    }
  }
  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0);
  }


  void initData() {
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [getTabImage('assets/images/navigation_home_normal.png'), getTabImage('assets/images/navigation_home_press.png')],
      [getTabImage('assets/images/navigation_message_normal.png'), getTabImage('assets/images/navigation_message_press.png')],
      [getTabImage('assets/images/navigation_user_normal.png'), getTabImage('assets/images/navigation_user_press.png')]
    ];
    /*
     * 三个子界面
     */
    _pageList = [
      new Page2(),
      new Page3(),
      new Page4(),
    ];
  }

}

