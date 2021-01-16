import 'dart:convert';

import 'package:dicoding_news_app/common/navigation.dart';
import 'package:dicoding_news_app/data/models/article.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ArticlesResult articles) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "dicoding news channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Headline News</b>";
    var titleNews = articles.articles[0].title;

    ///karena payload hanya menerima data dengan format string maka
    ///parameter model articles dirubah formatnya kedalam bentuk Json.
    ///untuk mengirimkan bundle data yang bersumber dari API
    ///haruslah dalam bentuk format JSON yang akan diubah menjadi String.
    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(articles.toJson()));
  }

  ///Kemudian pada fungsi configureSelectNotificationSubject
  ///kita melakukan decoding data payload untuk merubah data JSON ke dalam model article
  ///Lalu kita mengirimkannya ke dalam navigasi yang telah kita buat agar dapat ditampilkan di dalam halaman detail.
  void configureSelectNotificationSubject(String route) {
    ///membuka stream
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = ArticlesResult.fromJson(json.decode(payload));
        var article = data.articles[0];
        Navigation.intentWithData(route, article);
      },
    );
  }
}
