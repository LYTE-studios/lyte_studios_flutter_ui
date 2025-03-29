import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/mixins/screen_analytics_mixin.dart';
import 'package:lyte_studios_flutter_ui/services/analytics_service.dart';

mixin ScreenStateMixin on ScreenAnalyticsMixin {
  bool loading = false;

  String? error;

  void setError(String value) {
    AnalyticsService.instance.trackError(
      errorType: 'Data Error',
      errorMessage: value,
    );
    setState(() {
      error = value;
    });
  }

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
