import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class Localization {
  final Locale locale;

  Localization(this.locale);


  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'general_loading': {
      'nl': 'Laden...',
      'en': 'Loading...'
    },
    'general_no_data': {
      'nl': 'Geen data',
      'en': 'No data'
    },
    'general_input_title': {
      'nl': 'Titel',
      'en': 'Title'
    },
    'general_input_message': {
      'nl': 'Bericht',
      'en': 'Message'
    },
    'general_input_post': {
      'nl': 'Plaats',
      'en': 'Post'
    },
    'title': {
      'nl': 'V.S.L. Catena',
      'en': 'V.S.L. Catena'
    },
    'login_title': {
      'nl': 'V.S.L. Catena - Login',
      'en': 'V.S.L. Catena - Login'
    },
    'login_username': {
      'nl': 'Emailadres',
      'en': 'Email adress',
    },
    'login_password': {
      'nl': 'Wachtwoord',
      'en': 'Password'
    },
    'login_login': {
      'nl': 'Login',
      'en': 'Login'
    },
    'drawer_news': {
      'nl': 'Nieuws',
      'en': 'News'
    },
    'drawer_promo': {
      'nl': 'Promo',
      'en': 'Promo'
    },
    'news_title': {
      'nl': 'V.S.L. Catena - Nieuws',
      'en': 'V.S.L. Catena - News'
    },
    'news_new_item': {
      'nl': 'Nieuw nieuwsbericht',
      'en': 'New news item'
    },
    'news_edit_item': {
      'nl': 'Nieuwsbericht aanpassen',
      'en': 'Edit news item'
    }
  };
  
  String get(String referenceString){
    return _localizedValues[referenceString][locale.languageCode];
  }
}



class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['nl', 'en'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<Localization>(Localization(locale));
  }

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}