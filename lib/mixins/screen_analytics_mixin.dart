import 'package:flutter/widgets.dart';
import 'package:lyte_studios_flutter_ui/services/analytics_service.dart';

mixin ScreenAnalyticsMixin<T extends StatefulWidget> on State<T> {
  bool _hasTrackedScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _trackScreenViewIfNeeded();
  }

  void _trackScreenViewIfNeeded() {
    // Only track the first time the screen is shown
    if (!_hasTrackedScreen) {
      trackScreenView();
      _hasTrackedScreen = true;
    }
  }

  String get screenName => T.toString();

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
}
