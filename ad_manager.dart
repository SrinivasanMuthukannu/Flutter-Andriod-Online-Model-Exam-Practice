import 'dart:io';
//syasan
class AdManager {

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6282530384518850~7267506611";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6282530384518850~7267506611";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6282530384518850/4203070015";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6282530384518850/4203070015";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6282530384518850/1100982694";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6282530384518850/1100982694";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/8673189370";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/7552160883";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}

//Golearn

/*class AdManager {

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6282530384518850~7128873418";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6282530384518850~7128873418";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6282530384518850/4653811363";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6282530384518850/4653811363";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6282530384518850/1836076331";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6282530384518850/1836076331";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/8673189370";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/7552160883";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}*/
