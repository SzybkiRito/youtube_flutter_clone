class Date {
  String formatDateToTimeAgo(Duration diff) {
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0) return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0) return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0) return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";

    return "just now";
  }

  String formatDuration(String duration) {
    if (!duration.startsWith('PT')) {
      throw const FormatException('Invalid duration format.');
    }
    duration = duration.substring(2);
    List<String> parts = [];

    int hoursIndex = duration.indexOf('H');
    int minutesIndex = duration.indexOf('M');
    int secondsIndex = duration.indexOf('S');

    if (hoursIndex != -1) {
      parts.add(duration.substring(0, hoursIndex));
    } else {
      parts.add('');
    }

    if (minutesIndex != -1) {
      parts.add(duration.substring(hoursIndex + 1, minutesIndex));
    } else {
      parts.add('00');
    }

    if (secondsIndex != -1) {
      parts.add(duration.substring(minutesIndex + 1, secondsIndex));
    }

    if (parts[0] == '') {
      return parts.sublist(1).join(':');
    }

    return parts.join(':');
  }
}
