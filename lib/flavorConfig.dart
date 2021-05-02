import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

enum Flavor { Dev, Test, Prod }

class FlavorValues {
  final Box tokenBox;

  FlavorValues({
    @required this.tokenBox,
  });
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig _instance;

  factory FlavorConfig(
      {@required Flavor flavor, @required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(flavor, flavor.toString(), values);
    //flavor, StringUtils.enumName(flavor.toString()), color, values);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);
  static FlavorConfig get instance {
    return _instance;
  }

  static bool isProd() => _instance.flavor == Flavor.Prod;
  static bool isTest() => _instance.flavor == Flavor.Test;
  static bool isDev() => _instance.flavor == Flavor.Dev;

  static String flavorName() {
    switch (_instance.flavor) {
      case Flavor.Dev:
        return "on Dev";
      case Flavor.Test:
        return "on Test";
      case Flavor.Prod:
        return "";
    }

    return "";
  }
}
