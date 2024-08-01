import 'package:flutter/material.dart';
import '../../../core/navigator/navigator.dart';
import '../views/pages/complete/complete_profile_page.dart';
import '../views/pages/edit/edit_profile_page.dart';

class ProfileRoutes extends IModuleRoutes {
  @override
  String get routeName => '/profile';

  @override
  Map<String, Widget Function(BuildContext context)> get routes => {
        '/edit': (context) => EditUserProfilePage(
              user: getArgs(context),
            ),
        '/complete': (context) => CompleteProfilePage(
              user: getArgs(context),
            ),
      };
}
