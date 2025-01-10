import 'package:control_concierge_agents/app/core/notifications/notification_service.dart';
import 'package:control_concierge_agents/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'app/core/firebase/firebase_options.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService().showNotification(
    message.notification?.title ?? 'Título',
    message.notification?.body ?? 'Corpo',
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  runApp(const AppWidget());
}
