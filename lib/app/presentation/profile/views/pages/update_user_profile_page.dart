import 'dart:io';

import 'package:control_concierge_agents/app/presentation/authentication/provider/auth_provider.dart';
import 'package:control_concierge_agents/app/presentation/authentication/states/authentication/check_authentication_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:control_concierge_agents/app/presentation/profile/provider/profile_provider.dart';
import 'package:control_concierge_agents/app/presentation/profile/states/update_user_profile_state_notifier.dart';

import '../../../../core/helpers/helpers.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../data/models/user_model.dart';
import '../../../../widgets/button/button_widget.dart';
import '../../../../widgets/input/input_formatters.dart';
import '../../../../widgets/input/input_validators.dart';
import '../../../../widgets/input/input_widget.dart';
import '../../../../widgets/snack_bar/app_snack_bar_widget.dart';
import '../../../../widgets/spacing/vertical_space_widget.dart';
import '../widgets/select_user_image_widget.dart';

class UpdateUserProfilePage extends ConsumerStatefulWidget {
  const UpdateUserProfilePage({
    super.key,
    required this.user,
  });
  final UserModel? user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateUserProfilePageState();
}

class _UpdateUserProfilePageState extends ConsumerState<UpdateUserProfilePage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      final user = widget.user!;
      nameController = TextEditingController(text: user.name);
      emailController = TextEditingController(text: user.email);
      phoneNumberController = TextEditingController(text: user.phoneNumber);
      image = user.photoUrl != null ? File(user.photoUrl!) : null;
    } else {
      final authUser = ref.read(authenticationState) as IsLogged;
      emailController = TextEditingController(text: authUser.user!.email);
    }
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
    ref.listen<UpdateUserProfileState>(
      updateUserProfileProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) {
            Navigator.of(context).pushReplacementNamed('/home');
          },
          loadFailure: (message) {
            AppSnackBar.show(
              context,
              widget.user != null
                  ? 'Não foi possível completar seu perfil. Tente novamente!'
                  : 'Não foi possível atualizar seu perfil. Tente novamente!',
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
    final state = ref.watch(updateUserProfileProvider);

    listen();

    return Scaffold(
      appBar: widget.user != null
          ? AppBar(
              backgroundColor: AppColor.bgColor,
              foregroundColor: AppColor.primary,
            )
          : null,
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
                        id: '',
                        name: nameController.text,
                        photoUrl: image?.path,
                        phoneNumber: phoneNumberController.text,
                        email: emailController.text,
                        createdAt: DateTime.now(),
                      );

                      ref
                          .read(updateUserProfileProvider.notifier)
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
