import 'dart:ui';

import 'i10n.dart';

class TranslationService {
  static String translate(String key, String locale) {
    if (translations.containsKey(locale) && translations[locale]!.containsKey(key)) {
      return translations[locale]![key]!;
    }
    // Default to English if the translation is not available
    return translations['en']![key]!;
  }

  static TextDirection textDirection(String locale) {
    return ['ar', 'fa', 'he'].contains(locale)
        ? TextDirection.rtl
        : TextDirection.ltr;
  }
}
