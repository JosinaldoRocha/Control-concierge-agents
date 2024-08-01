import 'package:control_concierge_agents/app/core/helpers/common_state/common_state.dart';
import 'package:control_concierge_agents/app/presentation/authentication/provider/auth_provider.dart';
import 'package:control_concierge_agents/app/presentation/authentication/views/mixin/sign_in_mixin.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
import 'package:control_concierge_agents/app/widgets/input/input_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../widgets/input/input_validators.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> with SignInMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signInProvider);
    listen();

    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(
            top: 180,
            left: 16,
            right: 16,
          ),
          children: [
            Container(
              height: 150,
              width: 150,
              child: Image.asset('assets/images/agent.png'),
            ),
            const SpaceVertical.x5(),
            Text(
              "Entre com email e senha",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SpaceVertical.x5(),
            InputWidget(
              controller: emailController,
              hintText: 'seuemail@email.com',
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress,
              validator: InputValidators.email,
              autoFocus: true,
            ),
            const SpaceVertical.x5(),
            InputWidget(
              controller: passwordController,
              hintText: 'sua senha aqui',
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Digite sua senha';
                }
                if (p0.length < 8) {
                  return 'Senha curta';
                }
                return null;
              },
            ),
            const SpaceVertical.x8(),
            ButtonWidget(
              onTap: onTapButton,
              isLoading: state is CommonStateLoadInProgress,
              title: 'Continuar',
            ),
          ],
        ),
      ),
    );
  }
}
