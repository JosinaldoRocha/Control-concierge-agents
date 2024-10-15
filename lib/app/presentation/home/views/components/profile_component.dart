import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/presentation/authentication/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../widgets/image/profile_image_widget.dart';
import '../../../../widgets/modal/agent_modal_widget.dart';
import '../../../../widgets/snack_bar/app_snack_bar_widget.dart';
import '../../../authentication/states/logout/logout_state_notifier.dart';

class ProfileComponent extends ConsumerStatefulWidget {
  const ProfileComponent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileComponentState();
}

class _ProfileComponentState extends ConsumerState<ProfileComponent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(getUserProvider.notifier).load());
  }

  void logoutListen() {
    ref.listen<LogoutState>(
      logoutProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) =>
              Navigator.of(context).pushReplacementNamed('/auth'),
          loadFailure: (message) {
            AppSnackBar.show(
              context,
              'Não foi possível sair do app. Tente novamente!',
              AppColor.error,
            );
          },
          orElse: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(getUserProvider);

    logoutListen();

    return userState.maybeWhen(
      loadInProgress: () => Center(
        child: SizedBox(
          height: 10,
          width: 80,
          child: LoadingIndicator(
            indicatorType: Indicator.ballPulse,
          ),
        ),
      ),
      loadSuccess: (data) {
        return Container(
          color: AppColor.lightPurple,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 48,
                    right: 16,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/profile/update',
                        arguments: data,
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/icons/edit.svg',
                      colorFilter: const ColorFilter.mode(
                        AppColor.secondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              ProfileImageWidget(
                image: data.photoUrl,
                size: 130,
              ),
              Spacer(),
              Container(
                height: 400,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileItem('Nome', data.name),
                    _buildProfileItem('E-mail', data.email),
                    if (data.phoneNumber != null ||
                        data.phoneNumber!.isNotEmpty)
                      _buildProfileItem('Telefone', data.phoneNumber),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          context: context,
                          builder: (context) => AgentModalWidget(
                            title: 'Sair do App?',
                            description: 'Você quer mesmo sair do aplicativo?',
                            confirmTitle: 'Sair',
                            onConfirm: () {
                              ref.read(logoutProvider.notifier).load();
                              Navigator.pop(context);
                            },
                            cancelTitle: 'Cancelar',
                            onCancel: () => Navigator.pop(context),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sair',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(Icons.exit_to_app_rounded),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      orElse: () {
        return Container();
      },
    );
  }

  Padding _buildProfileItem(
    String title,
    String? description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(description ?? ''),
        ],
      ),
    );
  }
}
