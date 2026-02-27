class BusinessInfo {
  final String nameArabic;
  final String nameEnglish;
  final String slogan;
  final String whatsapp;
  final String phoneDisplay;
  final String address;
  final String facebook;
  final String instagram;
  final String kuraimiName;
  final String kuraimiAccount;
  final String jeebName;
  final String jeebNumber;

  const BusinessInfo({
    required this.nameArabic,
    required this.nameEnglish,
    required this.slogan,
    required this.whatsapp,
    required this.phoneDisplay,
    required this.address,
    required this.facebook,
    required this.instagram,
    required this.kuraimiName,
    required this.kuraimiAccount,
    required this.jeebName,
    required this.jeebNumber,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) {
    final social = (json['social'] as Map?)?.cast<String, dynamic>() ?? const {};
    final payment = (json['payment'] as Map?)?.cast<String, dynamic>() ?? const {};
    final kuraimi = (payment['kuraimi'] as Map?)?.cast<String, dynamic>() ?? const {};
    final jeeb = (payment['jeeb'] as Map?)?.cast<String, dynamic>() ?? const {};

    return BusinessInfo(
      nameArabic: (json['nameArabic'] ?? '').toString(),
      nameEnglish: (json['nameEnglish'] ?? '').toString(),
      slogan: (json['slogan'] ?? '').toString(),
      whatsapp: (json['whatsapp'] ?? '').toString(),
      phoneDisplay: (json['phoneDisplay'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      facebook: (social['facebook'] ?? '').toString(),
      instagram: (social['instagram'] ?? '').toString(),
      kuraimiName: (kuraimi['name'] ?? '').toString(),
      kuraimiAccount: (kuraimi['account'] ?? '').toString(),
      jeebName: (jeeb['name'] ?? '').toString(),
      jeebNumber: (jeeb['number'] ?? '').toString(),
    );
  }
}
