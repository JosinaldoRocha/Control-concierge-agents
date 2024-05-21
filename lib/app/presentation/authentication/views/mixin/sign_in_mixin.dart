import 'package:control_concierge_agents/app/presentation/authentication/views/pages/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../widgets/snack_bar/app_snack_bar_widget.dart';
import '../../provider/auth_provider.dart';
import '../../states/sign_in/sign_in_state_notifier.dart';

mixin SignInMixin<T extends SignInPage> on ConsumerState<T> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void listen() {
    ref.listen<SignInState>(
      signInProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) =>
              Navigator.of(context).pushReplacementNamed('/auth'),
          loadFailure: (message) {
            AppSnackBar.show(
              context,
              'Houve um erro ao tentar acessar o app.',
              AppColor.error,
            );
          },
          orElse: () {},
        );
      },
    );
  }

  void onTapButton() {
    if (formKey.currentState!.validate()) {
      ref.read(signInProvider.notifier).load(
            email: emailController.text,
            password: passwordController.text,
          );
    }
  }
}
