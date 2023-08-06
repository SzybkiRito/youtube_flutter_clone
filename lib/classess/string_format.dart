class StringFormat {
  String formatBigNumbers(String number) {
    int parsedNumber = int.parse(number);
    String formattedNumber = number;
    if (parsedNumber >= 1000000) {
      parsedNumber = (parsedNumber / 1000000).round();
      formattedNumber = '${parsedNumber}M';
    } else if (parsedNumber >= 1000) {
      parsedNumber = (parsedNumber / 1000).round();
      formattedNumber = '${parsedNumber}K';
    }

    return formattedNumber;
  }
}
