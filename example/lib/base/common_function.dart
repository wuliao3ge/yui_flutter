import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yui_flutter/appbar/index.dart';
import 'package:yui_flutter/yui.dart';

/// base 类 常用的一些工具类 ， 放在这里就可以了
abstract class BaseFuntion {
  State _stateBaseFunction;
  BuildContext _baseContext;

  bool _isTopBarShow = true; //状态栏是否显示
  bool _isAppBarShow = true; //导航栏是否显示
  Color _gradientStart ; //标题栏开始颜色
  Color _gradientEnd ; //标题栏结束颜色
  List<Widget> _appBarActions; //标题栏右侧按钮
  Widget _leading; //标题栏左侧控件
  bool _isBackIconShow = true; //是否显示返回键
  dynamic _title; //标题栏中间控件




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
  FontWeight _fontWidget = FontWeight.w600; //错误页面和空页面的字体粗度
  bool _isErrorWidgetShow = false; //错误信息是否显示


  void initBaseCommon(State state, BuildContext context) {
    _stateBaseFunction = state;
    _baseContext = context;
  }

  BuildContext getBuidContext(){
    return _baseContext;
  }

  //主体页面渲染
  Widget getBaseView(BuildContext context) {
    return new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          print(viewportConstraints.maxHeight);
          return Column(
            children: <Widget>[
              _getBaseAppBar(),//标题栏和状态栏
              Container(
                width: getScreenWidth(),
                height: viewportConstraints.maxHeight-getCutdownHeight(),
//                  color: Colors.red, //背景颜色，可自己变更
                child: Stack(
                  children: <Widget>[
                    buildWidget(context),
//                      _getBaseErrorWidget(),
//                      _getBaseEmptyWidget(),
//                      _getBassLoadingWidget(),
                  ],
                ),
              ),
            ],
          );
        }
        );
  }

  //绘制标题栏
  Widget _getBaseAppBar() {
    if(_isTopBarShow && _isAppBarShow == false) { //如果隐藏标题不隐藏状态栏返回状态栏
        return Container(
          height: getTopBarHeight(),
          width: double.infinity,
          color: Theme.of(_baseContext).primaryColor,
        );
    }else if(_isTopBarShow == false && _isAppBarShow == false){ //如果标题和状态栏都隐藏返回空 用
          return Container();
    }else {
     return GradientAppBar(
          gradientStart: _gradientStart,  //渐变使用开始颜色
          gradientEnd: _gradientEnd,   //渐变使用结束颜色
          actions: _appBarActions,
          title:_getTitle(),
          centerTitle: true,
          leading:getLeading(),
      );
    }
  }

  //获取中间控件
  Widget _getTitle(){
    print("_getTitle");
    if (_title is String) {
      return Text(_title);
    }else if(_title != null){
      return _title;
    }else {
      return Text(getClassName());
    }
  }

  //标题栏左边控件
  Widget getLeading(){
    if(_isBackIconShow&&_leading==null) //显示返回键
      {
          return  IconButton(
            icon: Icon(YuiIcons.jiantou2),
            onPressed: clickAppBarBack,
          );
      }else if(_leading!=null) //显示leading
        {
          return _leading;
        }else{
         return Container(); //什么都不显示
    }
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
              valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(_baseContext).primaryColor),
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

  void clickAppBarBack() {
    if (Navigator.canPop(_baseContext)) {
      Navigator.pop(_baseContext);
    } else {
      //说明已经没法回退了 ， 可以关闭了
      finishDartPageOrApp();
    }
  }


  ///返回屏幕高度
  double getScreenHeight() {
    return MediaQuery.of(_baseContext).size.height;
  }

  ///返回状态栏高度
  double getTopBarHeight() {
    return MediaQuery.of(_baseContext).padding.top;
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
    return MediaQuery.of(_baseContext).size.width;
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

  ///设置导航栏隐藏或者显示
  void setAppBarVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    _stateBaseFunction.setState(() {
      _isAppBarShow = isVisible;
    });
  }

  void setAppBarTitle(dynamic title) {
      // ignore: invalid_use_of_protected_member
      _stateBaseFunction.setState(() {
        _title = title;
      });
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
    if (_baseContext != null) {
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
              context: _baseContext,
              builder: (_) => _generateAlertDialog(_baseContext,message,title: title,
              leftbtn: leftbtn,leftbtnfunc: leftfunc,rightbtn: rightbtn,rightbtnfunc: rightfunc),
            );
          }else{
          showGeneralDialog(
            context: _baseContext,
            pageBuilder: (context, a, b) => _generateAlertDialog(_baseContext,message,title: title,
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
        context: _baseContext, builder: (_) => _generateAlertDialog(_baseContext,message,title: title,leftbtn:"取消",rightbtn:"确定",leftbtnfunc: leftfunc,rightbtnfunc: rightfunc),
      );
    }else{
      showGeneralDialog(
        context: _baseContext,
        pageBuilder: (context, a, b) => _generateAlertDialog(_baseContext,message,title: title,leftbtn:"取消",rightbtn:"确定",leftbtnfunc: leftfunc,rightbtnfunc: rightfunc),
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
    if (_baseContext == null) {
      return null;
    }
    String className = _baseContext.toString();
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
    YuiToast.info(_baseContext)(content);
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
