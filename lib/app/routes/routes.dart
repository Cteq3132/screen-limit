import 'package:flutter/widgets.dart';
import 'package:screen_limit/app/app.dart';
import 'package:screen_limit/home/home.dart';
import 'package:screen_limit/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
