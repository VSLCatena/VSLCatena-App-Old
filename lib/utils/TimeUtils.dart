import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  static String formatFull(int timestamp) {
    var format = new DateFormat('dd-MM-yyyy, HH:mm');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date);
  }

  static String formatFullTs(Timestamp timestamp) {
    return formatFull(timestamp.seconds);
  }
}