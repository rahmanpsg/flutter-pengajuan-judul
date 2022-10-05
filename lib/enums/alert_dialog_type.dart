enum AlertDialogType {
  success(0),
  warning(1);

  final int value;

  const AlertDialogType(this.value);

  static AlertDialogType fromValue(int value) =>
      AlertDialogType.values.firstWhere((e) => e.value == value);

  static AlertDialogType fromString(String value) =>
      AlertDialogType.values.firstWhere((e) => e.toString() == value);

  String get svg => 'assets/svg/$name.svg';
}
