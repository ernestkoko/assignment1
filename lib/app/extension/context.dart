import 'package:flutter/material.dart';

extension AppContext on BuildContext {
  void pop<T extends Object?>([T? result]) {
    return Navigator.of(this).pop();
  }

  Future<T?> pushNamed<T extends Object?>(
      String routeName, {
        Object? arguments,
      }) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;

  double get height => size.height;

  double get width => size.width;
}