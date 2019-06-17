// 配置
import 'package:yui_flutter/toast/index.dart';

class YuiConfig {

  // toast 位置
  WeToastInfoAlign toastInfoAlign;
  // toast info自动关闭时间
  int toastInfoDuration;
  // toast loading关闭时间
  int toastLoadingDuration;
  // toast success关闭时间
  int toastSuccessDuration;
  // toast fail关闭时间
  int toastFailDuration;
  // notify自动关闭时间
  int notifyDuration;
  // notify成功关闭时间
  int notifySuccessDuration;
  // notify错误关闭时间
  int notifyErrorDuration;

  // 工厂模式
  factory YuiConfig() =>_getInstance();
  static YuiConfig get instance => _getInstance();
  static YuiConfig _instance;
  YuiConfig._internal() {
    // 初始化
    toastInfoAlign = WeToastInfoAlign.center;
    toastInfoDuration = 2500;
    toastLoadingDuration = 2500;
    toastSuccessDuration = 2500;
    toastFailDuration = 2500;
    notifyDuration = 3000;
    notifySuccessDuration = 3000;
    notifyErrorDuration = 3000;
  }
  static YuiConfig _getInstance() {
    if (_instance == null) {
      _instance = new YuiConfig._internal();
    }
    return _instance;
  }


}