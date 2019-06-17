import 'package:flutter/material.dart';
import 'package:provide/provide.dart'
    show
    Provider,
    Provide,
    ProviderNode,
    Providers,
    ProvideMulti,
    ProviderScope;
import 'package:provide/provide.dart';
import 'package:yui_flutter/config/index.dart';
import 'package:yui_flutter/theme/index.dart';

class YuiView  {

  static dynamic storeCtx;
  static dynamic widgetCtx;

  static init({model, child, providers,yuitheme,yuiconfig,dispose = true}){
    if(providers == null)
      {
        final providers = Providers();
        if(yuitheme==null) {
            providers
              ..provide(Provider.value(new YuiTheme()));
          }else if(yuitheme!=null){
            providers
                  ..provide(Provider.value(yuitheme as YuiTheme));
            }
        return ProviderNode(
          child: child,
          providers: providers,
          dispose: dispose,
        );
      }else if(providers != null){
          if(yuitheme==null) {
            providers
              ..provide(Provider.value(new YuiTheme()));
          }else if(yuitheme!=null){
            providers
              ..provide(Provider.value(yuitheme as YuiTheme));
          }
          return ProviderNode(
            child: child,
            providers: providers,
            dispose: dispose,
          );
        }

    if(yuiconfig=null)
      {

      }

  }


  /*设置数据层上下文*/
  static setStoreCtx(context) {
    storeCtx = context;
  }

  /*设置Widget上下文*/
  static setWidgetCtx(context) {
    widgetCtx = context;
  }

  /*获取*/
  static T valueNotCtx<T>() {
    return Provide.value<T>(storeCtx);
  }

  /*根据 Context 获取*/
  static T value<T>(context, {scope}) {
    return Provide.value<T>(context, scope: scope);
  }

  /*监听*/
  static connect<T>({builder, child, scope}) {
    return Provide<T>(
      builder: builder,
      child: child,
      scope: scope,
    );
  }

  /*通过流的方式 监听*/
  static stream<T>({builder, model, context}) {
    return StreamBuilder<T>(
        initialData: model,
        stream: Provide.stream<T>(context),
        builder: builder);
  }

  /*链接多个类型*/
  static multi(
      {builder,
        child,
        List<Type> requestedValues,
        Map<ProviderScope, List<Type>> requestedScopedValues}) {
    return ProvideMulti(
        builder: builder,
        child: child,
        requestedValues: requestedValues,
        requestedScopedValues: requestedScopedValues);
  }


}