extension TimestampExtension on int {
  String toFormattedDateTime() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
