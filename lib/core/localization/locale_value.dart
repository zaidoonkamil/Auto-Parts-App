String localizedValue({
  required String localeCode,
  String? arabicValue,
  String? kurdishValue,
  required String fallback,
}) {
  if (localeCode == 'ckb') {
    final String value = (kurdishValue ?? '').trim();
    if (value.isNotEmpty) return value;
  }

  if (localeCode == 'ar') {
    final String value = (arabicValue ?? '').trim();
    if (value.isNotEmpty) return value;
  }

  final String arabic = (arabicValue ?? '').trim();
  if (arabic.isNotEmpty) return arabic;

  final String kurdish = (kurdishValue ?? '').trim();
  if (kurdish.isNotEmpty) return kurdish;

  return fallback;
}
