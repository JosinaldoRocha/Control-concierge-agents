import 'dart:io';

import 'package:control_concierge_agents/app/presentation/profile/provider/profile_provider.dart';
import 'package:control_concierge_agents/app/presentation/profile/states/complete/complete_profile_state_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/helpers/helpers.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../../widgets/button/button_widget.dart';
import '../../../../../widgets/input/input_formatters.dart';
import '../../../../../widgets/input/input_validators.dart';
import '../../../../../widgets/input/input_widget.dart';
import '../../../../../widgets/snack_bar/app_snack_bar_widget.dart';
import '../../../../../widgets/spacing/vertical_space_widget.dart';
import '../../widgets/select_user_image_widget.dart';

class CompleteProfilePage extends ConsumerStatefulWidget {
  const CompleteProfilePage({
    super.key,
    required this.user,
  });
  final User user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteProfilePageState();
}

class _CompleteProfilePageState extends ConsumerState<CompleteProfilePage> {
  final nameController = TextEditingController();
  var emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.user.email);
  }

  Future<void> getImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  listen() {
    ref.listen<CompleteProfileState>(
      completeProfileProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) {
            Navigator.of(context).pushReplacementNamed('/home');
          },
          loadFailure: (message) {
            AppSnackBar.show(
              context,
              'Não foi possível completar seu perfil. Tente novamente!',
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
    final state = ref.watch(completeProfileProvider);
    listen();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                SelectUserImageWidget(
                  image: image,
                  onTap: getImage,
                ),
                const SpaceVertical.x10(),
                InputWidget(
                  controller: nameController,
                  hintText: 'Nome',
                  validator: InputValidators.fullName,
                ),
                const SpaceVertical.x4(),
                InputWidget(
                  controller: emailController,
                  hintText: 'E-mail',
                  validator: InputValidators.email,
                  isEnabled: false,
                ),
                const SpaceVertical.x4(),
                InputWidget(
                  controller: phoneNumberController,
                  hintText: 'Celular',
                  inputFormatters: [InputFormatters.phone()],
                  keyboardType: TextInputType.phone,
                ),
                const SpaceVertical.x10(),
                ButtonWidget(
                  isLoading: state is CommonStateLoadInProgress,
                  title: 'Confirmar',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final user = UserModel(
                        id: widget.user.uid,
                        name: nameController.text,
                        photoUrl: image?.path,
                        phoneNumber: phoneNumberController.text,
                        email: emailController.text,
                        createdAt: DateTime.now(),
                      );

                      ref
                          .read(completeProfileProvider.notifier)
                          .load(user: user);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
