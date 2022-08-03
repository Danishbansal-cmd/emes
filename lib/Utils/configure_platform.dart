class ConfigurePlatform {
  //making into singleton class
  static final ConfigurePlatform _configurePlatform =
      ConfigurePlatform._internal();
  ConfigurePlatform._internal();
  factory ConfigurePlatform() {
    return _configurePlatform;
  }
  late bool _isIos;
  get getConfigurePlatformBool {
    return _isIos;
  }
  setConfigurePlatformBool(bool value) {
    _isIos = value;
  }
}
