class Language {
  final int id;
  final String flag;
  final String name;
  final String code;

  Language(this.id, this.flag, this.name, this.code);

  static List<Language> languageList() {
    return [
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇻🇳", "Tiếng Việt", "vi"),
      Language(3, "🇰🇷", "한국어", "ko"),
    ];
  }
}
