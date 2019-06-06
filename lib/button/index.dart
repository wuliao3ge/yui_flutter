import 'package:flutter/material.dart';
import 'package:yui_flutter/animation/rotating.dart';
import 'package:yui_flutter/store/index.dart';
import 'package:yui_flutter/theme/index.dart';
import '../icons/index.dart';

// 颜色类型
enum YuiButtonType {
  acquiescent,
  primary,
  warn
}

// size
enum YuiButtonSize {
  acquiescent,
  mini
}

class YuiButton extends StatefulWidget {
  // 内容
  dynamic child;
  // 禁用
  final bool disabled;
  // 点击回调
  final Function onClick;
  // loading
  final bool loading;
  // 空心
  final bool hollow;
  // 按钮大小类型
  YuiButtonSize sizeType;
  // 按钮大小
  Map<String, double> size;
  // 主题
  final YuiButtonType type;
  //按钮中图标的颜色
  final Color iconColor;

  final double radius;


  // 大小配置
  final List<Map<String, double>> sizeConfig = [
    {
      'fontSize': 18.0,
      'height': 45.0,
      'iconSize': 16.0,
      'borderSize': 0.5
    },
    {
      'fontSize': 13.0,
      'height': 30.0,
      'iconSize': 14.0,
      'borderSize': 0.4
    }
  ];

  YuiButton(
      this.child,
      {
        this.onClick,
        YuiButtonSize size = YuiButtonSize.acquiescent,
        this.hollow = false,
        this.type = YuiButtonType.acquiescent,
        this.disabled = false,
        this.loading = false,
        this.iconColor = Colors.black45,
        this.radius = 5
      }
      ) {
    this.size = sizeConfig[size.index];
    this.sizeType = size;
  }

  @override
  _ButtonState createState() => _ButtonState();
}
class _ButtonState extends State<YuiButton> {

  // 按钮点击
  onClick() {
    if (widget.onClick is Function) {
      widget.onClick();
    }
  }

  // 渲染按钮内容
  Widget renderChild(content) {
    // size
    final size = widget.size;
    // 是否禁用状态
    final bool disabled = widget.loading || widget.disabled;
    Widget child;
    if (content is String) {
      child = Text(content);
    } else {
      child = content;
    }

    // 内容
    List<Widget> children = [
    YuiView.connect<YuiTheme>(builder: (context, child1, model) {
      return DefaultTextStyle(
          style: TextStyle(
              fontSize: size['fontSize'],
              color: model.primaryTextColor
          ),
          child: child
      );
    })

    ];

    if (widget.loading) {
      final Widget icon = Padding(
          padding: EdgeInsets.only(right: 5),
          child: Rotating(Icon(
              YuiIcons.jiazai,
              color: widget.iconColor,
              size: 30
          ))
      );
      children.insert(0, icon);
    }

    return Opacity(
        opacity: disabled ? 0.7 : 1,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: widget.sizeType == YuiButtonSize.mini ? MainAxisSize.min : MainAxisSize.max,
            children: children
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // size
    final size = widget.size;
    // 是否禁用状态
    final bool disabled = widget.loading || widget.disabled;
    // 圆角
    final BorderRadius borderRadius = BorderRadius.all(Radius.circular(widget.radius));

    // 禁用状态
    if (disabled) {
      return YuiView.connect<YuiTheme>(builder: (context, child, model) {
        return Container(
            height: size['height'],
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
            color: disabled ? model.primaryColorDisabled : null,
                borderRadius: borderRadius,
                // 空心或者默认按钮才添加边框
                border: widget.hollow ? Border.all(
                    width: size['borderSize'],
                    color: model.borderColor
                ) : null
            ),
            child: renderChild(widget.child)
        );
      });
    }

    return YuiView.connect<YuiTheme>(builder: (context, child, model) {
        return Material(
            borderRadius: borderRadius,
            color: model.primaryColor,
            child: InkWell(
                onTap: onClick,
                borderRadius: borderRadius,
                child: Container(
                    height: size['height'],
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        // 空心或者默认按钮才添加边框
                        border: widget.hollow ? Border.all(
                            width: size['borderSize'],
                            color: model.borderColor
                        ) : null
                    ),
                    child: renderChild(widget.child)
                )
            )
        );
    });
  }
}

