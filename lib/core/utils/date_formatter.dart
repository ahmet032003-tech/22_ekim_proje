/// Tarih ve saat biçimlendirme yardımcı sınıfı.
abstract final class DateFormatter {
  static const List<String> _months = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık',
  ];

  /// Tarihi "22 Ekim 2026" biçiminde döner.
  static String formatFullDate(DateTime date) {
    final monthName = _months[date.month - 1];
    return '${date.day} $monthName ${date.year}';
  }

  /// Kullanıcı dostu göreli zaman ("Bugün", "Dün", "3 gün önce")
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final diff = today.difference(target).inDays;

    if (diff == 0) return 'Bugün';
    if (diff == 1) return 'Dün';
    if (diff < 7) return '$diff gün önce';
    return formatFullDate(date);
  }
}
