import 'dart:async';
import 'dart:math';

import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

mixin NotificationHandleMixin {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late NotificationAppLaunchDetails? notificationAppLaunchDetails;

  late AndroidNotificationChannel channel;

  void dispose() {
    onMessageOpenedApp.cancel();
    onMessage.cancel();
  }

  late StreamSubscription<RemoteMessage> onMessageOpenedApp;

  late StreamSubscription<RemoteMessage> onMessage;

  void handleNotificationMessage(
    RemoteMessage message,
    BuildContext context,
  ) {
    if (message.data['route'] != null) {
      try {
        Navigator.pushNamed(
          context,
          message.data['route'],
          arguments: int.tryParse(message.data['id'].toString()),
        );
      } catch (e) {
        debugPrint('route not foud');
      }
    }
  }

  void onMessageHandler(
    BuildContext context,
  ) {
    onMessage = FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      debugPrint('ON message: ${notification?.title}');

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          Random().nextInt(2 ^ 30),
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'icon',
              color: AppColor.primaryRed,
            ),
          ),
          payload: message.data.toString(),
        );
      }
    });
  }
}
