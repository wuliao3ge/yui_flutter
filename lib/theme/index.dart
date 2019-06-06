// 主题
import 'dart:ui';
import 'package:flutter/cupertino.dart';
const Color _primaryColor = Color(0xff1AAD19);
const Color _primaryColorDisabled = Color(0xffe3e3e3);
const Color _warnColor = Color(0xffE64340);
const Color _warnColorDisabled = Color(0xffEC8B89);
const Color _defaultBackgroundColor = Color(0xfff8f8f8);
const Color _defaultBorderColor = Color(0xffd8d8d8);
const Color _maskColor = Color.fromRGBO(17, 17, 17, 0.6);
const Color _primaryTextColor = Color(0xffffffff);
const Color _white = Color(0xffffffff);


class YuiTheme with ChangeNotifier{
  // 主色
  Color primaryColor;
  // 主色禁用
  Color primaryColorDisabled;
  // 警告色
  Color warnColor;
  // 警告色禁用
  Color warnColorDisabled;
  // 默认背景色
  Color defaultBackgroundColor;
  // 默认边框色
  Color defaultBorderColor;
  // 遮罩层颜色
  Color maskColor;
  //文字颜色
  Color primaryTextColor;
  //窗口背景色
  Color backGroundColor;

  YuiTheme({
    this.primaryColor : _primaryColor,
    this.primaryTextColor: _primaryTextColor,
    this.primaryColorDisabled : _primaryColorDisabled,
    this.warnColor : _warnColor,
    this.warnColorDisabled : _warnColorDisabled,
    this.defaultBackgroundColor : _defaultBackgroundColor,
    this.defaultBorderColor : _defaultBorderColor,
    this.maskColor : _maskColor,
    this.backGroundColor : _white
  });


  Future $setPrimaryColr(color) async {
    primaryColor = color;
//    LocalStorage.set('theme', payload);
    notifyListeners();
  }

}




