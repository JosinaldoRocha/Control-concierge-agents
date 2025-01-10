import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_init;
import 'package:timezone/timezone.dart' as tz;

import 'notification_handler_mixin.dart';

class NotificationService with NotificationHandleMixin {
  NotificationService() {
    tz_init.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
  }
  Future<void> initialize() async {
    // PERMISSIONS
    requestIOSPermissions();

    // FIREBASE MESSAGE NOTIFICATION
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // LOCAL NOTIFICATIONS
    await _setupLocalNotification();
    await _initLocalNotifications();

    _onMessage();
    _onMessageOpenedApp();
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<String?> getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('=======================================');
    debugPrint('DEVICE TOKEN: $token');
    debugPrint('=======================================');
    return token;
  }

  void setupBackgrounHandler(
    BuildContext context,
  ) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleNotificationMessage(initialMessage, context);
    }
  }

  void onOpenHandler(BuildContext context) {
    onMessageOpenedApp = FirebaseMessaging.onMessageOpenedApp.listen(
      (event) => handleNotificationMessage(event, context),
    );

    if (Platform.isIOS) {
      setupBackgrounHandler(context);
    }
    onMessageHandler(context);
  }

  Future<void> _initLocalNotifications() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('icon');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _setupLocalNotification() async {
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'Geral',
      description: 'Canal utilizado para notificações com alta importância',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
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
              color: AppColor.primary,
              channelDescription: channel.description,
              icon: 'icon',
            ),
          ),
        );
      }
    });
  }

  void _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  void _goToPageAfterMessage(message) {
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {}
  }

  Future<void> showScheduledLocalNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required int seconds,
  }) async {
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      notificationDetails,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelScheduledNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> cancelAllScheduledNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> messageHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    NotificationService().onMessageHandler;
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(2 ^ 30),
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
