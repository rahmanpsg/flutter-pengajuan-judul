import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../app/core/custom_base_view_model.dart';
import '../../../services/auth_service.dart';

class SignInViewModel extends CustomBaseViewModel {
  final log = getLogger("SignInViewModel");

  final _authService = locator<AuthService>();

  final formKey = GlobalKey<FormState>();

  final nimController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmit() async {
    if (formKey.currentState?.validate() != true) return;

    setBusy(true);

    final response = await _authService.login(
        nim: nimController.text, password: passwordController.text);

    setBusy(false);

    log.d("response: $response");

    if (!response.error) {
      navigationService.clearStackAndShow(Routes.homeView);

      return;
    }

    dialogService.showDialog(
      title: 'Error',
      description: response.message,
      dialogPlatform: DialogPlatform.Material,
    );
  }
}
