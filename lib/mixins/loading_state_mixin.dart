import 'package:flutter/cupertino.dart';

mixin LoadingStateMixin on State<StatefulWidget> {
  bool loading = false;

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }
}
