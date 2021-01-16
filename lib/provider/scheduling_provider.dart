import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dicoding_news_app/utils/background_service.dart';
import 'package:dicoding_news_app/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  ///on / off notification
  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;

    if (_isScheduled) {
      print('Scheduling News Activated');
      notifyListeners();

      ///periodic merupakan fungsi alarm terjadwal
      ///jika _isScheduled true maka alarm manager diaktifkan dengan ID 1
      ///Di sini kita menambahkan parameter durasi selama 24 jam.
      ///Mengapa demikian? Karena parmeter startAt akan dijalankan pertama kali saja,
      ///lalu untuk selanjutnya akan menjalankan berdasarkan interval durasi tersebut.
      ///Dengan demikian, scheduling ini akan terus dijalankan setiap hari pada jam yang ditentukan di startAt.
      return await AndroidAlarmManager.periodic(
          Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      print("Scheduling News Canceled");
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
