import 'package:flutter/material.dart';

class SettingProvider with ChangeNotifier {
  String languageCode = 'en';

  void changeLanguage( String newCode){
    languageCode = newCode ;
    notifyListeners();
  }
}