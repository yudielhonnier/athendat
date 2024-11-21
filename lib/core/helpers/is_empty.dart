bool isNumeric(String number) {
  if (number.isEmpty) return false;

  final n = num.tryParse(number);

  return (n == null) ? false : true;
}
