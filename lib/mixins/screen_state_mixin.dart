import 'package:flutter/material.dart';

mixin ScreenStateMixin<T extends StatefulWidget> on State<T> {
  bool loading = false;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }

    super.setState(fn);
  }

  /// This stores the loading value with the given boolean
  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  /// Loads the data with additional loading logic
  Future<void> setData() async {
    try {
      setLoading(true);
      await loadData();
      setLoading(false);
    } finally {
      setLoading(false);
    }
  }

  /// Override this method to add a data loader to your screen
  Future<void> loadData() async {}

  @override
  void initState() {
    Future(() {
      setData();
    });
    super.initState();
  }
}
