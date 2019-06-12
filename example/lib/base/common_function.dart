import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yui_flutter/appbar/index.dart';
import 'package:yui_flutter/yui.dart';

/// base 类 常用的一些工具类 ， 放在这里就可以了
abstract class BaseFuntion {
  State _stateBaseFunction;
  BuildContext _contextBaseFunction;

  bool _isTopBarShow = true; //状态栏是否显示
  bool _isAppBarShow = true; //导航栏是否显示

  bool _isErrorWidgetShow = false; //错误信息是否显示

  Color _topBarColor = Color(0xFF1a90db);
  Color _appBarColor = Color(0xFF1a90db);
  Color _appBarTextColor = Colors.white;

  //标题字体大小
  double _appBarCenterTextSize = 20; //根据需求变更
  String _appBarTitle;


  String _errorContentMesage = "网络错误啦~~~";

  String _errImgPath = "assets/images/load_error_view.png";

  bool _isLoadingWidgetShow = false;
  //加载中请稍后......
  String _LoadingWidgetContent = "";

  Color _LoadingWidgetColor = Color(0xFF000000);
  double _LoadingWidgetTextSize = 15.0;
  FontWeight _LoadingWidgetTextFontWeight = FontWeight.w600;

  bool _isEmptyWidgetVisible = false;

  String _emptyWidgetContent = "暂无数据~";

  String _emptyImgPath = "assets/images/ic_empty.png"; //自己根据需求变更
  bool _isBackIconShow = true;

  FontWeight _fontWidget = FontWeight.w600; //错误页面和空页面的字体粗度

  double bottomVsrtical = 0; //作为内部页面距离底部的高度

  void initBaseCommon(State state, BuildContext context) {
    _stateBaseFunction = state;
    _contextBaseFunction = context;
    _appBarTitle = getClassName();
  }

  BuildContext getBuidContext(){
    return _contextBaseFunction;
  }

  //主体页面渲染
  Widget getBaseView(BuildContext context) {
    return new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          print(viewportConstraints.maxHeight);
          return SingleChildScrollView(
            child:Column(
              children: <Widget>[
//                _getBaseTopBar(),
                _getBaseAppBar(),
                Container(
                  width: getScreenWidth(),
                  height: viewportConstraints.maxHeight-getCutdownHeight(),
                  color: Colors.red, //背景颜色，可自己变更
                  child: Stack(
                    children: <Widget>[
                      buildWidget(context),
                      _getBaseErrorWidget(),
                      _getBaseEmptyWidget(),
                      _getBassLoadingWidget(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        );
  }

  Widget _getBaseTopBar() {
    return Offstage(
      offstage: !_isTopBarShow,
      child: getTopBar(),
    );
  }

  Widget _getBaseAppBar() {
    return Offstage(
      offstage: !_isAppBarShow,
//      child: getAppBar(),
      child:GradientAppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
//        gradientStart: Color(0xFF2171F5),
//        gradientEnd: Color(0xFF49A2FC),
        backgroundColor: _appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.print),
            onPressed: (){},
          )
        ],
        title: Text(_appBarTitle),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(YuiIcons.jiantou2),
            onPressed: clickAppBarBack,
        ),
      ),
    );
  }

  ///设置状态栏，可以自行重写拓展成其他的任何形式
  Widget getTopBar() {
    return Container(
      height: getTopBarHeight(),
      width: double.infinity,
      color: _topBarColor,
    );
  }

  ///暴露的错误页面方法，可以自己重写定制
  Widget getErrorWidget() {
    return Container(
      //错误页面中心可以自己调整
      padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: InkWell(
          onTap: onClickErrorWidget,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(_errImgPath),
                width: 150,
                height: 150,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(_errorContentMesage,
                    style: TextStyle(
                      fontWeight: _fontWidget,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///点击错误页面后展示内容
  void onClickErrorWidget() {
    onResume(); //此处 默认onResume 就是 调用网络请求，
  }

  Widget getLoadingWidget() {
//    return SpinKitCircle(
//      color: Color(0xff1a90db),
////      itemBuilder: (_, int index) {
////        return DecoratedBox(
////          decoration: BoxDecoration(
//////            color: index.isEven ? Colors.red : Colors.green,
////              color: Color(0xff1a90db)
////          ),
////        );
////      },
//    );
    return Container(
      //错误页面中心可以自己调整
      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
      color: Colors.black12,
      width: double.infinity,
      height: double.infinity,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        // 圆形进度条
        CircularProgressIndicator(
              strokeWidth: 4.0,
              backgroundColor: Colors.blue,
              // value: 0.2,
              valueColor: new AlwaysStoppedAnimation<Color>(_appBarColor),
            ),
        Offstage(
          offstage: _LoadingWidgetContent == "" ? true  : false,
          child: Padding(
            padding: EdgeInsets.only(top: 10,left:0,right: 0,bottom: 0),
            child: Text(_LoadingWidgetContent,
              style: TextStyle(
                fontSize: _LoadingWidgetTextSize,
                fontWeight:_LoadingWidgetTextFontWeight,
                color: _LoadingWidgetColor,
              ),
            ),
          ),
        )

        ],
      )
    );
  }

  Color getAppBarColor(){
    return _appBarColor;
  }


  void clickAppBarBack() {
    if (Navigator.canPop(_contextBaseFunction)) {
      Navigator.pop(_contextBaseFunction);
    } else {
      //说明已经没法回退了 ， 可以关闭了
      finishDartPageOrApp();
    }
  }
//
//
//  defaultRouteName → String 启动应用程序时嵌入器请求的路由或路径。
//  devicePixelRatio → double 每个逻辑像素的设备像素数。 例如，Nexus 6的设备像素比为3.5。
//  textScaleFactor → double 系统设置的文本比例。默认1.0
//  toString（） → String 返回此对象的字符串表示形式。
//  physicalSize → Size 返回一个包含屏幕宽高的对象，单位是dp
//
//

  ///返回中间可绘制区域，也就是 我们子类 buildWidget 可利用的空间高度
  double getMainWidgetHeight() {
    double screenHeight = getScreenHeight() - bottomVsrtical;
    if (_isTopBarShow) {
      screenHeight = screenHeight - getTopBarHeight();
    }
    if (_isAppBarShow) {
      screenHeight = screenHeight - getAppBarHeight();
    }
    return screenHeight;
  }

  ///返回屏幕高度
  double getScreenHeight() {
    return MediaQuery.of(_contextBaseFunction).size.height;
  }

  ///返回状态栏高度
  double getTopBarHeight() {
    return MediaQuery.of(_contextBaseFunction).padding.top;
  }

  ///返回appbar高度，也就是导航栏高度
  double getAppBarHeight() {
    return kToolbarHeight;
  }



  //返回需要删减的高度（viewpage中使用时需要调整）
  num getCutdownHeight() {
    return (_isTopBarShow?getTopBarHeight():0) + (_isAppBarShow?getAppBarHeight():0);
  }

  ///返回屏幕宽度
  double getScreenWidth() {
    return MediaQuery.of(_contextBaseFunction).size.width;
  }

  //错误页显示
  Widget _getBaseErrorWidget() {
    return Offstage(
      offstage: !_isErrorWidgetShow,
      child: getErrorWidget(),
    );
  }

  //加载对话框显示
  Widget _getBassLoadingWidget() {
    return Offstage(
      offstage: !_isLoadingWidgetShow,
      child: getLoadingWidget(),
    );
  }

  //空白页显示
  Widget _getBaseEmptyWidget() {
    return Offstage(
      offstage: !_isEmptyWidgetVisible,
      child: getEmptyWidget(),
    );
  }

  //空白页显示
  Widget getEmptyWidget() {
    return Container(
      //错误页面中心可以自己调整
      padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                color: Colors.black12,
                image: AssetImage(_emptyImgPath),
                width: 150,
                height: 150,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(_emptyWidgetContent,
                    style: TextStyle(
                      fontWeight: _fontWidget,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///关闭最后一个 flutter 页面 ， 如果是原生跳过来的则回到原生，否则关闭app
  void finishDartPageOrApp() {
    SystemNavigator.pop();
  }
  ///设置状态栏隐藏或者显示
  void setTopBarVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isTopBarShow = isVisible;
    });
  }

  void refreshUI(){
    _stateBaseFunction.setState((){

    });
  }



  ///默认这个状态栏下，设置颜色
  void setTopBarBackColor(Color color) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _topBarColor = color == null ? _topBarColor : color;
    });
  }

  ///设置导航栏的字体以及图标颜色
  void setAppBarContentColor(Color contentColor) {
    if (contentColor != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _appBarTextColor = contentColor;
      });
    }
  }

  ///设置导航栏隐藏或者显示
  void setAppBarVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isAppBarShow = isVisible;
    });
  }

  ///默认这个导航栏下，设置颜色
  void setAppBarBackColor(Color color) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _appBarColor = color == null ? _appBarColor : color;
    });
  }
  void setAppBarTitle(String title) {
    if (title != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _appBarTitle = title;
      });
    }
  }

  ///设置错误提示信息
  void setErrorContent(String content) {
    if (content != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _errorContentMesage = content;
      });
    }
  }

  ///设置错误页面显示或者隐藏
  void setErrorWidgetVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      if (isVisible) {
        //如果可见 说明 空页面要关闭啦
        _isEmptyWidgetVisible = false;
      }
      // 不管如何loading页面要关闭啦，
      _isLoadingWidgetShow = false;
      _isErrorWidgetShow = isVisible;
    });
  }

  ///设置空页面显示或者隐藏
  void setEmptyWidgetVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      if (isVisible) {
        //如果可见 说明 错误页面要关闭啦
        _isErrorWidgetShow = false;
      }

      // 不管如何loading页面要关闭啦，
      _isLoadingWidgetShow = false;
      _isEmptyWidgetVisible = isVisible;
    });
  }

  void setLoadingWidgetVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isLoadingWidgetShow = isVisible;
    });
  }

  ///设置空页面内容
  void setEmptyWidgetContent(String content) {
    if (content != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _emptyWidgetContent = content;
      });
    }
  }

  ///设置错误页面图片
  void setErrorImage(String imagePath) {
    if (imagePath != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _errImgPath = imagePath;
      });
    }
  }

  ///设置空页面图片
  void setEmptyImage(String imagePath) {
    if (imagePath != null) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _emptyImgPath = imagePath;
      });
    }
  }

  void setBackIconHinde({bool isHiinde = true}) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isBackIconShow = !isHiinde;
    });
  }

  ///弹对话框
  void showToastDialog(
    String message, {
        String title="",
        String leftbtn="",
        String rightbtn="",
        Function leftfunc,
        Function rightfunc,
        bool isDismissible = true,
  }) {
    if (_contextBaseFunction != null) {
      if (message != null && message.isNotEmpty) {
//        showDialog<Null>(
//            context: _contextBaseFunction, //BuildContext对象
//            barrierDismissible: false,
//            builder: (BuildContext context) {
//              return new MessageDialog(
//                title: title,
//                negativeText: negativeText,
//                message: message,
//                onCloseEvent: () {
//                  Navigator.pop(context);
//                },
//              );
//              //调用对话框);
//            });

        if(isDismissible)
          {
            showDialog(
              context: _contextBaseFunction,
              builder: (_) => _generateAlertDialog(_contextBaseFunction,message,title: title,
              leftbtn: leftbtn,leftbtnfunc: leftfunc,rightbtn: rightbtn,rightbtnfunc: rightfunc),
            );
          }else{
          showGeneralDialog(
            context: _contextBaseFunction,
            pageBuilder: (context, a, b) => _generateAlertDialog(_contextBaseFunction,message,title: title,
                leftbtn: leftbtn,leftbtnfunc: leftfunc,rightbtn: rightbtn,rightbtnfunc: rightfunc),
            barrierDismissible: false,
//            barrierLabel: 'barrierLabel',
            transitionDuration: Duration(milliseconds: 400),
          );
//            showGeneralDialog(context: _contextBaseFunction, pageBuilder: _generateAlertDialog(_contextBaseFunction));
        }
      }
    }
  }

  //显示常规对话框
  void showDefaultDialog(
      String message, {
        String title,
        Function leftfunc,
        Function rightfunc,
        bool isDismissible = true,
      }) {
    if(isDismissible)
    {
      showDialog(
        context: _contextBaseFunction, builder: (_) => _generateAlertDialog(_contextBaseFunction,message,title: title,leftbtn:"取消",rightbtn:"确定",leftbtnfunc: leftfunc,rightbtnfunc: rightfunc),
      );
    }else{
      showGeneralDialog(
        context: _contextBaseFunction,
        pageBuilder: (context, a, b) => _generateAlertDialog(_contextBaseFunction,message,title: title,leftbtn:"取消",rightbtn:"确定",leftbtnfunc: leftfunc,rightbtnfunc: rightfunc),
        barrierDismissible: false,
//            barrierLabel: 'barrierLabel',
        transitionDuration: Duration(milliseconds: 400),
      );
//            showGeneralDialog(context: _contextBaseFunction, pageBuilder: _generateAlertDialog(_contextBaseFunction));
    }
  }



  _generateSimpleDialog(BuildContext context,String message,{
      String title
      ,String leftbtn
      ,String rightbtn
      ,Function leftbtnfunc
      ,Function rightbtnfunc}) {
    return SimpleDialog(
      title: Text(title==null||title.isEmpty?"提示":title),
      children: <Widget>[
        Container(
          height: 100,
          child: Text(message),
        ),
        FlatButton(
          child: Text(leftbtn),
          onPressed: () {
            if(leftbtnfunc!=null)
              {
                leftbtnfunc();
              }
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(rightbtn),
          onPressed: () {
            if(rightbtnfunc!=null)
            {
              rightbtnfunc();
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  _generateAlertDialog(BuildContext context,String message,{
    String title
    ,String leftbtn
    ,String rightbtn
    ,Function leftbtnfunc
    ,Function rightbtnfunc}) {
    return AlertDialog(
      title: Text(title==null||title.isEmpty?"提示":title),
      content: Text(message),
      actions: <Widget>[
        Offstage(
          offstage: leftbtn==null||leftbtn.isEmpty?true:false,
          child: FlatButton(
            child: Text(leftbtn),
            onPressed: () {
              if(leftbtnfunc!=null)
              {
                leftbtnfunc();
              }
              Navigator.of(context).pop();
            },
          ),
        ),
        Offstage(
          offstage: rightbtn==null||rightbtn.isEmpty?true:false,
          child: FlatButton(
            child: Text(rightbtn),
            onPressed: () {
              if(rightbtnfunc!=null)
              {
                rightbtnfunc();
              }
              Navigator.of(context).pop();
            },
          ),
        ),


      ],
    );
  }


  String getClassName() {
    if (_contextBaseFunction == null) {
      return null;
    }
    String className = _contextBaseFunction.toString();
    if (className == null) {
      return null;
    }
    className = className.substring(0, className.indexOf("("));
    return className;
  }

  void setLoadingWidgetTextFontWeight(FontWeight value) {
    _LoadingWidgetTextFontWeight = value;
  }

  void setLoadingWidgetTextSize(double value) {
    _LoadingWidgetTextSize = value;
  }

  void setLoadingWidgetColor(Color value) {
    _LoadingWidgetColor = value;
  }


  ///弹吐司
  void showToast(String content){
    YuiToast.info(_contextBaseFunction)(content);
  }


  ///初始化一些变量 相当于 onCreate ， 放一下 初始化数据操作
  void onCreate();

  ///相当于onResume, 只要页面来到栈顶， 都会调用此方法，网络请求可以放在这个方法
  void onResume();

  ///页面被覆盖,暂停
  void onPause();

  ///返回UI控件 相当于setContentView()
  Widget buildWidget(BuildContext context);

  ///app切回到后台
  void onBackground() {
    log("回到后台");
  }

  ///app切回到前台
  void onForeground() {
    log("回到前台");
  }

  ///页面注销方法
  void onDestory() {
    log("destory");
  }

  void log(String content) {
    print(getClassName() + "------:" + content);
  }



}
