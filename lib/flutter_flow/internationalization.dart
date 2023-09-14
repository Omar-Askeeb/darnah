import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // login
  {
    'fac0vx9x': {
      'en': 'Darnah Hurricane',
      'ar': 'درنة',
    },
    '6xr2gqqm': {
      'en': 'Sign in',
      'ar': 'تسجيل الدخول',
    },
    'g74grkju': {
      'en': 'Fill The followin fields',
      'ar': 'املئ الحقول التالية',
    },
    'j2ev3y0c': {
      'en': 'Email',
      'ar': 'البريد الالكتروني',
    },
    'rez08b58': {
      'en': 'Password',
      'ar': 'كلمة المرور',
    },
    '74tsnpea': {
      'en': 'Sign in',
      'ar': 'تسجيل الدخول',
    },
    'b5inw9gn': {
      'en': 'Don\'t have account',
      'ar': 'ليس لديك حساب ',
    },
    '2xkrr2rw': {
      'en': ' - Sign Up',
      'ar': 'تسجيل مستخدم',
    },
    'hqwhiw73': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // addPeople
  {
    'eqxl527s': {
      'en': 'Person Data',
      'ar': 'بيانات',
    },
    'wxhgy15z': {
      'en': 'First Name',
      'ar': 'الاسم',
    },
    'p4csic5d': {
      'en': 'Father Name',
      'ar': 'اسم الاب',
    },
    'u1ij8h0c': {
      'en': 'Grandfather Name',
      'ar': 'اسم الجد',
    },
    '5dc8saif': {
      'en': 'SurName',
      'ar': 'اسم العائلة',
    },
    'lrrzdbc0': {
      'en': 'Birth Date',
      'ar': 'تاريخ الميلاد',
    },
    'ma4xrodc': {
      'en': 'Missing',
      'ar': 'مفقود',
    },
    'yulxe96c': {
      'en': 'Missing',
      'ar': 'مفقود',
    },
    '6dfziuz4': {
      'en': 'Found',
      'ar': 'تم ايجاده',
    },
    '7dp1vhdy': {
      'en': 'Injuried',
      'ar': 'مصاب',
    },
    'jczskeri': {
      'en': 'Dead',
      'ar': 'متوفى',
    },
    '0kkvd1mk': {
      'en': 'لم يتعرف عليه',
      'ar': 'لم يتعرف عليه',
    },
    '5z9epauq': {
      'en': 'state',
      'ar': 'الحالة',
    },
    'ukdmq13q': {
      'en': 'Search for an item...',
      'ar': '',
    },
    'bgb3gjrf': {
      'en': 'National ID',
      'ar': 'الرقم الوطني',
    },
    'rxrp9l6b': {
      'en': 'ID number',
      'ar': 'رقم اثبات الهوية',
    },
    'epqck5bd': {
      'en': 'ID',
      'ar': '',
    },
    'ae12gm98': {
      'en': 'Save',
      'ar': 'حفظ',
    },
    '2h59b9hz': {
      'en': 'Field is required',
      'ar': '',
    },
    '73oqthzx': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'rhoohxsz': {
      'en': 'Field is required',
      'ar': '',
    },
    'o9g433nj': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'gi5g6kh9': {
      'en': 'Field is required',
      'ar': '',
    },
    '1cx1wv7v': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'nrds3823': {
      'en': 'Field is required',
      'ar': '',
    },
    'qrzeci2t': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'jzjvjo67': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // codeSearch
  {
    'f5x5t30a': {
      'en': 'search...',
      'ar': 'بحث...',
    },
    'xk7qv915': {
      'en': 'Log out',
      'ar': 'تسجيل الخروج',
    },
    'ki7146q2': {
      'en': 'Statistics',
      'ar': 'إحصائيات',
    },
    '4okyfa3p': {
      'en': 'search',
      'ar': 'بحث',
    },
    'o2f2yhqx': {
      'en': 'Not Recognizable',
      'ar': 'لم يتعرف عليهم',
    },
    'mi0oo9d7': {
      'en': 'Add',
      'ar': 'اضافة',
    },
    'x4iit1gm': {
      'en': 'all people',
      'ar': 'عرض الكل',
    },
    'i6wbtpoe': {
      'en': 'Developer',
      'ar': 'المطور',
    },
    'm0afamqe': {
      'en': 'Search by Code',
      'ar': 'بحث عبر الكود',
    },
    '4a7a84jz': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // signup
  {
    '1gu5twh1': {
      'en': 'Darnah Hurricane',
      'ar': 'درنة',
    },
    'ydbofzhr': {
      'en': 'Sign Up',
      'ar': 'تسجيل الدخول',
    },
    '3cvojjcc': {
      'en': 'Fill The followin fields',
      'ar': 'املئ الحقول التالية',
    },
    '4m3tbdaq': {
      'en': 'Email',
      'ar': 'البريد الالكتروني',
    },
    '0lrl8hzh': {
      'en': 'user Name',
      'ar': 'اسم المستخدم',
    },
    'z79jqd9v': {
      'en': 'Password',
      'ar': 'كلمة المرور',
    },
    'mk97sqwu': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
    },
    'v2vnu1hf': {
      'en': 'Mobile Number',
      'ar': 'رقم الهاتف',
    },
    '6o4h5vdd': {
      'en': 'Sign Up',
      'ar': 'تسجيل الدخول',
    },
    'wi63rn34': {
      'en': 'Already have account',
      'ar': ' لديك حساب بالفعل',
    },
    '3ml82zl6': {
      'en': ' - login',
      'ar': 'تسجيل الدخول ',
    },
    'it1cm3gf': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Statistics
  {
    '5x52zt20': {
      'en': 'Statistics',
      'ar': 'الإحصائيات',
    },
    'd0icgxts': {
      'en': 'Missing',
      'ar': 'مفقودين',
    },
    '2vzgstv4': {
      'en': 'Found',
      'ar': 'تم العثور عليهم',
    },
    'chhdfqn7': {
      'en': 'Lost',
      'ar': 'متوفين',
    },
    'dcpt20tg': {
      'en': 'Injuried',
      'ar': 'مصابين',
    },
    'tdfjeyiq': {
      'en': 'Not Recognized',
      'ar': 'لم يتم التعرف عليهم',
    },
    'c1wu6952': {
      'en': 'Total',
      'ar': 'الاجمالي',
    },
    'aqxwkr24': {
      'en': 'Log out',
      'ar': 'تسجيل الخروج',
    },
    'ya0ktpy5': {
      'en': 'Statistics',
      'ar': 'إحصائيات',
    },
    'olex1ajp': {
      'en': 'search',
      'ar': 'بحث',
    },
    'e6ydoreu': {
      'en': 'Not Recognizable',
      'ar': 'لم يتعرف عليهم',
    },
    '5p5kfk2b': {
      'en': 'Add',
      'ar': 'اضافة',
    },
    '6okc85lw': {
      'en': 'all people',
      'ar': 'عرض الكل',
    },
    'axlgblam': {
      'en': 'Developer',
      'ar': 'المطور',
    },
    'jgd1ur87': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // aboutMe
  {
    'dkbbgpoj': {
      'en': 'If I can help with anything please contact me:\n',
      'ar': 'اذا كان هناك اي مساعدة استطيع تقديمها يرجى التواصل',
    },
    'xdyfhgb3': {
      'en': '+218944580235\n',
      'ar': '+218944580235\n',
    },
    '702aiyh8': {
      'en': 'omar.askeeb@gmail.com',
      'ar': 'omar.askeeb@gmail.com',
    },
    'wqf9zci1': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // updateState
  {
    'qdhv5f7z': {
      'en': 'Person Data',
      'ar': 'بيانات',
    },
    'sy7d00pj': {
      'en': 'First Name',
      'ar': 'الاسم',
    },
    '5v274jsr': {
      'en': 'father Name',
      'ar': 'اسم الاب',
    },
    'vsy1mly3': {
      'en': 'grandfather name',
      'ar': 'اسم الجد',
    },
    '7r4edi95': {
      'en': 'SurName',
      'ar': 'اسم العائلة',
    },
    'du3gwg2f': {
      'en': 'Missing',
      'ar': ' مفقود',
    },
    'uukrx2ag': {
      'en': 'Missing',
      'ar': 'مفقود',
    },
    'mcvk9zzt': {
      'en': 'Found',
      'ar': 'تم ايجاده',
    },
    'izpoxhfo': {
      'en': 'Injuried',
      'ar': 'مصاب',
    },
    'q4rzy6w7': {
      'en': 'Dead',
      'ar': 'متوفى',
    },
    'bhwqheaz': {
      'en': 'لم يتعرف عليه',
      'ar': 'لم يتعرف عليه',
    },
    'nb3gfsbh': {
      'en': 'state',
      'ar': 'الحالة',
    },
    'g4qare66': {
      'en': 'Search for an item...',
      'ar': '',
    },
    '7n0glqau': {
      'en': 'National ID',
      'ar': 'الرقم الوطني',
    },
    'pzlvik5w': {
      'en': 'ID number',
      'ar': 'رقم اثبات الهوية',
    },
    '6ulpaa6o': {
      'en': 'ID',
      'ar': '',
    },
    'kplvskjo': {
      'en': 'Save',
      'ar': 'حفظ',
    },
    'exzabtc6': {
      'en': 'Field is required',
      'ar': '',
    },
    'kzzgmrr2': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '3ij9b9ax': {
      'en': 'Field is required',
      'ar': '',
    },
    'myrfmrcy': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '7jq2i0ob': {
      'en': 'Field is required',
      'ar': '',
    },
    '2tun8b09': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'x29yie6a': {
      'en': 'Field is required',
      'ar': '',
    },
    'hw5tnhja': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'ubpkkhpa': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // allMissing
  {
    '2lm8vs9l': {
      'en': 'Log out',
      'ar': 'تسجيل الخروج',
    },
    'cblest8u': {
      'en': 'Statistics',
      'ar': 'إحصائيات',
    },
    'hxlckp3c': {
      'en': 'search',
      'ar': 'بحث ',
    },
    'hbdinaai': {
      'en': 'Not Recognizable',
      'ar': 'لم يتعرف عليهم',
    },
    'rq5gu8v0': {
      'en': 'Add',
      'ar': 'اضافة',
    },
    'fd66ck9w': {
      'en': 'all people',
      'ar': 'عرض الكل',
    },
    '6e6magls': {
      'en': 'Developer',
      'ar': 'المطور',
    },
    '7vfqxzem': {
      'en': 'All',
      'ar': 'الكل',
    },
    '4u0usnxl': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // notRecognizable
  {
    'z3o5ahm4': {
      'en': 'Log out',
      'ar': 'تسجيل الخروج',
    },
    'icows9yt': {
      'en': 'Statistics',
      'ar': 'إحصائيات',
    },
    '00bjtsgr': {
      'en': 'search',
      'ar': 'بحث ',
    },
    'mh97bmfg': {
      'en': 'Not Recognizable',
      'ar': 'لم يتعرف عليهم',
    },
    '2buvot7v': {
      'en': 'Add',
      'ar': 'اضافة',
    },
    'tjzrr9k7': {
      'en': 'all people',
      'ar': 'عرض الكل',
    },
    'gacm482j': {
      'en': 'Developer',
      'ar': 'المطور',
    },
    'sucennwb': {
      'en': 'not Recognizable',
      'ar': 'لم يتم التعرف عليهم',
    },
    'qbh6zsv3': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // searchPeople
  {
    'dcms4ll2': {
      'en': 'search By Code',
      'ar': 'بحث عبر الكود',
    },
    'b9c4pww7': {
      'en': 'search...',
      'ar': 'بحث...',
    },
    'a7a2s6mi': {
      'en': 'Log out',
      'ar': 'تسجيل الخروج',
    },
    'q84k80eq': {
      'en': 'Statistics',
      'ar': 'إحصائيات',
    },
    'b092x1qw': {
      'en': 'search',
      'ar': 'بحث',
    },
    '2psl7zwf': {
      'en': 'Not Recognizable',
      'ar': 'لم يتعرف عليهم',
    },
    'ssb1lqq4': {
      'en': 'Add',
      'ar': 'اضافة',
    },
    's1ebxqaq': {
      'en': 'all people',
      'ar': 'عرض الكل',
    },
    'erxcdc0b': {
      'en': 'Developer',
      'ar': 'المطور',
    },
    'tskzly6n': {
      'en': 'Search',
      'ar': 'بحث',
    },
    'g1tqnrvz': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // Miscellaneous
  {
    '2qu6a2f0': {
      'en': '',
      'ar': '',
    },
    'nid9bd3c': {
      'en': '',
      'ar': '',
    },
    'rw41lpwq': {
      'en': '',
      'ar': '',
    },
    '2uevd8xb': {
      'en': '',
      'ar': '',
    },
    '3nxne0b3': {
      'en': '',
      'ar': '',
    },
    '5ogop8uv': {
      'en': '',
      'ar': '',
    },
    'gi4rr1eq': {
      'en': '',
      'ar': '',
    },
    '9lbpveng': {
      'en': '',
      'ar': '',
    },
    'eczxq70x': {
      'en': '',
      'ar': '',
    },
    '4b1zw1st': {
      'en': '',
      'ar': '',
    },
    'qkp65h6v': {
      'en': '',
      'ar': '',
    },
    '4ujiiltb': {
      'en': '',
      'ar': '',
    },
    '9gli4b0z': {
      'en': '',
      'ar': '',
    },
    'kp30fm5t': {
      'en': '',
      'ar': '',
    },
    'avzznjdd': {
      'en': '',
      'ar': '',
    },
    'rwidosmq': {
      'en': '',
      'ar': '',
    },
    'h6lty0ne': {
      'en': '',
      'ar': '',
    },
    'zklpda5j': {
      'en': '',
      'ar': '',
    },
    'k6dqjxhm': {
      'en': '',
      'ar': '',
    },
    '0h0u6osw': {
      'en': '',
      'ar': '',
    },
    '7k4dfwzv': {
      'en': '',
      'ar': '',
    },
    '984ei9w8': {
      'en': '',
      'ar': '',
    },
    'q71jyrx2': {
      'en': '',
      'ar': '',
    },
    'o3x46xbm': {
      'en': '',
      'ar': '',
    },
    'zec9u3l2': {
      'en': '',
      'ar': '',
    },
  },
].reduce((a, b) => a..addAll(b));
