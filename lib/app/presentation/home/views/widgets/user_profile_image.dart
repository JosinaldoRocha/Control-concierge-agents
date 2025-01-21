import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../authentication/provider/auth_provider.dart';

class UserProfileWidget extends ConsumerWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(getUserProvider);

    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColor.cardBackground,
      child: userState.maybeWhen(
        loadInProgress: () => Center(
          child: SizedBox(
            height: 6,
            width: 24,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
            ),
          ),
        ),
        loadSuccess: (data) => data.photoUrl == null || data.photoUrl!.isEmpty
            ? Text(
                _getInitials(data.name),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.lightGrey2,
                ),
              )
            : ClipOval(
                child: Image.network(
                  data.photoUrl!,
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
        loadFailure: (failure) => Center(
          child: Text(
            '!',
            style: TextStyle(color: AppColor.error),
          ),
        ),
        orElse: () => Container(),
      ),
    );
  }

  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    if (nameParts.length > 1) {
      return nameParts[0][0] + nameParts[1][0];
    }
    return nameParts[0][0];
  }
}
