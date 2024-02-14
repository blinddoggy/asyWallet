class NamedRoute {
  static const String login = 'login';
  static const String welcome = 'welcome';
  static const String signUpWeb3 = 'signUpWeb3';
  static const String pinLogin = 'signUpPin';
  static const String importAccount = 'import_account';

  static const String root = 'root';
  static const String home = 'home';

  static const String portfolio = 'portfolio';
  static const String portfolioAssetDetail = 'asset_detail';
  static const String nft = 'nft';
  static const String settings = 'settings';
  static const String settingsImportAccount = 'settings_import_account';
  static const String settingsThemeChanger = 'theme_changer';

  static const Map<String, String> _path = {
    root: '/',
    welcome: '/welcome',
    signUpWeb3: 'signup_web_3',
    importAccount: 'import_account',
    pinLogin: '/login_pin',
    login: '/login',
    home: '/home',
    portfolio: '/portfolio',
    portfolioAssetDetail: 'asset_detail/:id',
    nft: '/nft',
    settings: '/settings',
    settingsImportAccount: 'settings_import_account',
    settingsThemeChanger: 'theme_changer',
  };

  static const Map<String, String> _fullPath = {
    root: '/',
    welcome: '/welcome',
    signUpWeb3: '/welcome/signup_web_3',
    importAccount: '/welcome/import_account',
    pinLogin: '/login_pin',
    login: '/login',
    home: '/home',
    portfolio: '/portfolio',
    portfolioAssetDetail: '/portfolio/asset_detail/:id',
    nft: '/nft',
    settings: '/settings',
    settingsImportAccount: '/settings/settings_import_account',
    settingsThemeChanger: '/settings/theme_changer',
  };

  static String getPath(String name) {
    assert(_path[name] != null, 'Recuerda agregar el path al named_route.dart');
    return _path[name]!;
  }

  static String getFullPath(String name) {
    assert(_fullPath[name] != null,
        'Recuerda agregar el full path al named_route.dart');
    return _fullPath[name]!;
  }
}
