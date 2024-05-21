import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/core/style/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../widgets/modal/agent_modal_widget.dart';
import '../../../../widgets/spacing/spacing.dart';
import '../../../authentication/provider/auth_provider.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SpaceVertical.x2(),
        _buildItem(
          context,
          'Home',
          Icons.home,
          () => Navigator.pop(context),
        ),
        const Divider(color: AppColor.lightGrey),
        _buildItem(
          context,
          'Sobre',
          Icons.info,
          () {},
        ),
        const Divider(color: AppColor.lightGrey),
        const Spacer(),
        const Divider(color: AppColor.lightGrey),
        _buildItem(
          context,
          'Sair',
          Icons.exit_to_app,
          () {
            showModalBottomSheet(
              isDismissible: false,
              context: context,
              builder: (context) => AgentModalWidget(
                title: 'Sair do App?',
                description: '',
                confirmTitle: 'Sair',
                onConfirm: () {
                  ref.read(logoutProvider.notifier).load();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                cancelTitle: 'Cancelar',
                onCancel: () => Navigator.pop(context),
              ),
            );
          },
        ),
      ],
    );
  }

  ListTile _buildItem(
    BuildContext context,
    String title,
    IconData icon,
    Function() onTap,
  ) {
    return ListTile(
      leading: Text(
        title,
        style: AppText.text().titleMedium,
      ),
      trailing: Icon(
        icon,
        color: AppColor.primary,
      ),
      onTap: onTap,
    );
  }
}
