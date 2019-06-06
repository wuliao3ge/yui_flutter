import 'dart:io';

main() {


  var result = """import 'package:flutter/widgets.dart';

const String fontFamily = 'iconfont';

class YuiIcons {

    YuiIcons._();
""";
  var file = File.fromUri(Uri.parse("${Uri.base}assets/font-icon/iconfont.css"));
  var read = file.readAsStringSync();

  var split = read.split(".icon-");
  split.forEach((str) {
    if (str.contains("before")) {
      var split = str.split(":");
      result += "static const IconData " +
          split[0].replaceAll("-", "_") +
          " = const IconData(" +
          split[2].replaceAll("\"\\", "0x").split("\"")[0] +
          ", fontFamily: fontFamily);\n";
    }
  });
  result+="}";
  var fileOut = File.fromUri(Uri.parse("${Uri.base}lib/icons/index.dart"));
  fileOut.writeAsStringSync(result);
}