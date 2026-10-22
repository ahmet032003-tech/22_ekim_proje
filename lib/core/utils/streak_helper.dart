/// Duolingo tarzı alevli seri (streak) hesaplama ve seviyelendirme yardımcı sınıfı.
abstract final class StreakHelper {
  /// Son tamamlama tarihine göre serinin korunup korunmadığını kontrol eder.
  static bool isStreakActive(DateTime? lastCompletedDate) {
    if (lastCompletedDate == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final completionDay = DateTime(
      lastCompletedDate.year,
      lastCompletedDate.month,
      lastCompletedDate.day,
    );

    final differenceInDays = today.difference(completionDay).inDays;
    // Bugün veya dün tamamlandıysa seri aktiftir.
    return differenceInDays <= 1;
  }

  /// Bugün tamamlanıp tamamlanmadığını kontrol eder.
  static bool isCompletedToday(DateTime? lastCompletedDate) {
    if (lastCompletedDate == null) return false;

    final now = DateTime.now();
    return lastCompletedDate.year == now.year &&
        lastCompletedDate.month == now.month &&
        lastCompletedDate.day == now.day;
  }

  /// Yeni seri gün sayısını hesaplar.
  static int calculateNextStreak({
    required int currentStreak,
    required DateTime? lastCompletedDate,
  }) {
    if (isCompletedToday(lastCompletedDate)) {
      return currentStreak; // Bugün zaten yapılmış
    }

    // Henüz tamamlanmamış başlangıç serisi ise artır
    if (lastCompletedDate == null) {
      return currentStreak > 0 ? currentStreak + 1 : 1;
    }

    if (isStreakActive(lastCompletedDate)) {
      return currentStreak + 1; // Dün yapılmış, seri büyüyor
    }

    // Seri kırılmış, baştan başlıyor
    return 1;
  }

  /// Seri gün sayısına göre alev unvanını döner.
  static String getStreakBadgeTitle(int streak) {
    if (streak <= 0) return 'Başlangıç';
    if (streak < 4) return 'Kıvılcım';
    if (streak < 8) return 'Parlayan Alev';
    if (streak < 15) return 'Sönmeyen Ateş';
    if (streak < 30) return 'Alev Ustası';
    return 'Efsanevi Seri';
  }

  /// Seri gün sayısına göre alev emojisi/ikon sembolü
  static String getStreakEmoji(int streak) {
    if (streak <= 0) return '🌱';
    if (streak < 4) return '🔥';
    if (streak < 8) return '🔥🔥';
    if (streak < 15) return '⚡🔥';
    if (streak < 30) return '🌟🔥';
    return '👑🔥';
  }
}
