import 'package:flutter/widgets.dart';

class NavigationHelper {
  Future<Object?> push(BuildContext context, Route<Object> route) {
    return Navigator.of(context).push(route);
  }

  void pop<T extends Object?>(BuildContext context, [T? result]) {
    return Navigator.of(context).pop(result);
  }
}
