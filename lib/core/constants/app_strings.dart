/// Proje genelinde kullanılan sabit metinler ve arayüz dizgileri.
abstract final class AppStrings {
  // Uygulama & Marka
  static const String appName = 'WeAreTogether';
  static const String appTagline = 'Birlikte Güçlüyüz';

  // Karşılama & Sıralı Animasyon Metinleri (SKILL.md Bölüm 1)
  static const String welcomeGreetingStep1 =
      'Yalnız değilsin. Birlikte başaracağız';
  static const String welcomeGreetingStep2 = 'Sen de Aramıza Katıl';
  static const String welcomeDescription =
      'Duolingo tarzı alevli seriler, topluluk desteği ve sevimli Yavru Ördek AI Koç ile alışkanlıklarını taçlandır.';

  // Giriş ve Kayıt Butonları
  static const String signIn = 'Oturum Aç';
  static const String register = 'Kayıt Ol';
  static const String guestMode = 'Hemen Keşfet';
  static const String emailHint = 'E-posta adresiniz';
  static const String passwordHint = 'Şifreniz';

  // Onboarding & Motivasyon Geçiş Ekranı (SKILL.md Bölüm 2)
  static const String onboardingMotivationTitle =
      'Harika Bir Adım Attın!';
  static const String onboardingMotivationSubtitle =
      'Küçük alışkanlıklar, büyük zaferler doğurur. Birlikte seri yapacağın ilk alışkanlığını seçelim.';
  static const String habitSelectionHeader = 'İlk Alışkanlığını Seç';
  static const String habitSelectionSubHeader =
      'Hazır şablonlardan birini seç veya kendi serini başlat.';
  static const String confirmHabit = 'Alışkanlığı Başlat & Seriye Katıl';

  // Dashboard & Metrikler (SKILL.md Bölüm 3)
  static const String communityStreakTitle =
      'Bugün seninle beraber 14.820 kişi seri yaptı!';
  static const String communityStreakSubtitle =
      'Alevler hiç sönmesin! Topluluğun gücü seninle.';
  static const String progressStatsHeader = 'Gelişim İstatistikleri';
  static const String aiCoachCardTitle = 'Günün AI İlhamı & Motivasyonu';
  static const String myActiveHabits = 'Aktif Alışkanlıklarım';
  static const String markAsCompleted = 'Tamamla & Alevi Yak';
  static const String completedToday = 'Bugün Tamamlandı!';

  // Alt Navigasyon Çubuğu (SKILL.md Bölüm 4)
  static const String navFriends = 'Arkadaş Ekle';
  static const String navAchievements = 'Başarımlar';
  static const String navAddHabit = 'Alışkanlık Ekle';
  static const String navCommunity = 'Topluluk';
  static const String navProfile = 'Profil';

  // Hazır Alışkanlık Şablonları
  static const String templateRunningTitle = 'Sabah Koşusu & Yürüyüş';
  static const String templateRunningDesc =
      'Güne 30 dakikalık tempolu adım veya koşu ile enerjik başla.';

  static const String templateSmokingTitle = 'Sigarayı Bırakma Serisi';
  static const String templateSmokingDesc =
      'Her temiz gün, ciğerlerin ve geleceğin için parlayan bir alevdir.';

  static const String templateKnittingTitle = 'El İşi & Örgü Terapisi';
  static const String templateKnittingDesc =
      'Günde 20 dakika el işi veya örgü ile zihnini sakinleştir.';

  static const String templateReadingTitle = 'Her Gün 20 Sayfa Kitap';
  static const String templateReadingDesc =
      'Kelime dağarcığını ve vizyonunu her gün yeni sayfalarla besle.';

  static const String templateWaterTitle = 'Günlük 2.5L Su Hedefi';
  static const String templateWaterDesc =
      'Vücudunu canlı, enerjini yüksek tutmak için su içmeyi aksatma.';

  // Yerel AI Motivasyon Havuzu (Fallback Quotes)
  static const List<String> fallbackAiQuotes = [
    'Bugün attığın o küçük adım, yarın gururla bakacağın büyük bir alev olacak. Sakın durma!',
    'Yavru Ördek seninle gurur duyuyor! Alışkanlık bir günde değil, her gün inşa edilir.',
    'Seriyi bozmamak için sadece bugünü kazanman yeterli. Odaklan ve alevi canlı tut!',
    'Topluluk arkanda, alevin elinde. Bir gün daha başardığında kendini tebrik etmeyi unutma.',
    'Yorgun hissediyorsan dinlen ama asla vazgeçme. Birlikte daha güçlüyüz!',
    'Büyük hedefler, sabırla tekrarlanan mikro adımlarla fethedilir. Bugün o adımlardan biri.',
    'Alevin ışığı hem seni hem de topluluktaki dostlarını aydınlatıyor. Harika gidiyorsun!',
    'Zorlandığın anlar, karakterinin ve iradenin en çok güçlendiği anlardır. Devam et!',
  ];
}
