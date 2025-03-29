import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/services/analytics_service.dart';

mixin ScreenStateMixin<T extends StatefulWidget> on State<T> {
  bool loading = false;

  String? error;

  bool _hasTrackedScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _trackScreenViewIfNeeded();
  }

  void _trackScreenViewIfNeeded() {
    // Only track the first time the screen is shown
    if (!_hasTrackedScreen &&
        mounted &&
        AnalyticsService.instance.isInitialized) {
      trackScreenView();
      _hasTrackedScreen = true;
    }
  }

  String get screenName => T.runtimeType.toString();

  /// Track additional properties specific to this screen
  Map<String, dynamic>? get screenProperties => null;

  void trackScreenView() {
    final properties = {
      'screen_name': T.toString(),
      'route': ModalRoute.of(context)?.settings.name,
      if (screenProperties != null) ...screenProperties!,
    };

    AnalyticsService.instance.trackScreenView(screenName);
    AnalyticsService.instance.trackEvent('screen_view', properties: properties);
  }

  /// Helper method to track screen-specific events
  void trackScreenEvent(String eventName, {Map<String, dynamic>? properties}) {
    final eventProperties = {
      'screen_name': screenName,
      if (properties != null) ...properties,
    };

    AnalyticsService.instance.trackEvent(
      eventName,
      properties: eventProperties,
    );
  }

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
