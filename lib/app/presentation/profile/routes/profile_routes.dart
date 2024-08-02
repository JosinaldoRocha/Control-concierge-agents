import 'package:flutter/material.dart';
import '../../../core/navigator/navigator.dart';
import '../views/pages/update_user_profile_page.dart';

class ProfileRoutes extends IModuleRoutes {
  @override
  String get routeName => '/profile';

  @override
  Map<String, Widget Function(BuildContext context)> get routes => {
        '/update': (context) => UpdateUserProfilePage(
              user: getArgs(context),
            ),
      };
}
