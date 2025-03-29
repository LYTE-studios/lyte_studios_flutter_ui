import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class AnalyticsService {
  static AnalyticsService? _instance;
  late final Mixpanel _mixpanel;
  bool _initialized = false;

  // Singleton pattern
  static AnalyticsService get instance {
    _instance ??= AnalyticsService._();
    return _instance!;
  }

  AnalyticsService._();

  bool get isInitialized => _initialized;

  Future<void> initialize(String token) async {
    if (_initialized) return;
    _mixpanel = await Mixpanel.init(token, trackAutomaticEvents: true);
    _initialized = true;
  }

  // User identification
  void identify(String userId) {
    if (!_initialized) return;
    _mixpanel.identify(userId);
  }

  void setUserProperties(Map<String, dynamic> properties) {
    if (!_initialized) return;
    properties.forEach((key, value) {
      _mixpanel.getPeople().set(key, value);
    });
  }

  // Event tracking
  void trackEvent(String eventName, {Map<String, dynamic>? properties}) {
    if (!_initialized) return;
    _mixpanel.track(eventName, properties: properties);
  }

  // Screen tracking
  void trackScreenView(String screenName) {
    trackEvent('Screen View', properties: {'screen': screenName});
  }

  void trackError({
    required String errorType,
    required String errorMessage,
    String? stackTrace,
  }) {
    trackEvent('Error Occurred', properties: {
      'error_type': errorType,
      'error_message': errorMessage,
      if (stackTrace != null) 'stack_trace': stackTrace,
    });
  }

  // Reset user
  void reset() {
    if (!_initialized) return;
    _mixpanel.reset();
  }
}
