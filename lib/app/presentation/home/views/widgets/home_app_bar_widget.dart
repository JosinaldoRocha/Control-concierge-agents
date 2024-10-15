import 'package:control_concierge_agents/app/presentation/home/views/widgets/loading_home_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text.dart';
import '../../../../widgets/image/profile_image_widget.dart';
import '../../../../widgets/spacing/space_horizontal_widget.dart';
import '../../../authentication/provider/auth_provider.dart';

class HomeAppBarWidget extends ConsumerStatefulWidget {
  const HomeAppBarWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeAppBarWidgetState();
}

class _HomeAppBarWidgetState extends ConsumerState<HomeAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(getUserProvider);

    return Container(
      height: 110,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: userState.maybeWhen(
          loadInProgress: () => LoadingHomeAppBarWidget(),
          loadSuccess: (data) => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpaceHorizontal.x1(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${getGreetingMessage()}, ${getFirstAndSecondName(data.name)} 😊',
                    style: AppText.text().titleMedium!.copyWith(),
                  ),
                  Text(
                    '${DateFormat('dd MMMM yyyy', 'Pt-br').format(DateTime.now())}',
                    style: AppText.text().bodyMedium!.copyWith(
                          color: AppColor.primaryGrey,
                        ),
                  ),
                ],
              ),
              Spacer(),
              ProfileImageWidget(
                image: data.photoUrl,
                size: 48,
              ),
            ],
          ),
          orElse: () => Container(),
        ),
      ),
    );
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Bom dia';
    } else if (hour >= 12 && hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  String getFirstAndSecondName(String fullName) {
    final names = fullName.split(' ');
    if (names.length >= 2) {
      return '${names[0]} ${names[1]}';
    }
    return names[0];
  }
}
