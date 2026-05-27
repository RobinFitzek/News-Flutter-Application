import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Local notifications for price/geo/signal alerts (replaces email/web-push on mobile).
class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
    _initialized = true;
  }

  Future<void> showAlert({
    required String title,
    required String body,
    int id = 0,
  }) async {
    await init();
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'stockholm_alerts',
        'Stockholm Alerts',
        channelDescription: 'Price, geo, and signal alerts',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(id, title, body, details);
  }

  Future<void> notifyPriceAlert(String symbol, double price, String direction) async {
    await showAlert(
      id: symbol.hashCode,
      title: 'Price Alert: $symbol',
      body: '$symbol hit \$${price.toStringAsFixed(2)} ($direction target)',
    );
  }

  Future<void> notifyGeoAlert(int severity, String summary) async {
    if (severity < 8) return;
    await showAlert(
      id: 9001,
      title: 'Geopolitical Alert ($severity/10)',
      body: summary.length > 120 ? '${summary.substring(0, 120)}…' : summary,
    );
  }

  Future<void> notifySignalAlert(String symbol, String signal, int confidence) async {
    if (confidence < 80) return;
    await showAlert(
      id: symbol.hashCode + 10000,
      title: 'Strong Signal: $symbol',
      body: '$signal at $confidence% confidence',
    );
  }

  Future<void> notifyPortfolioAlert(String message) async {
    await showAlert(
      id: 8001,
      title: 'Portfolio Alert',
      body: message,
    );
  }
}
