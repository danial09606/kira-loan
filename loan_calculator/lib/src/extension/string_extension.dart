extension StringExtension on String {
  String getCurrencyFormat() {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';

    return replaceAllMapped(reg, mathFunc);
  }
}
