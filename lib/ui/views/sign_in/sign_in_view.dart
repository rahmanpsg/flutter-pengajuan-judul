import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../app/themes/app_text.dart';
import '../../../utlis/validator.dart';
import '../../widgets/custom_textfield_outline.dart';
import './sign_in_view_model.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey widgetKey = GlobalKey();

    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      builder: (
        BuildContext context,
        SignInViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Form(
              key: model.formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'Sistem Pengajuan Judul Fakultas Teknik - UM Parepare',
                        style: boldTextStyle.copyWith(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      minLeadingWidth: 0,
                      leading: const Icon(Icons.info),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Silahkan login menggunakan nim masing-masing dengan password default ',
                              style: mediumTextStyle.copyWith(fontSize: 12),
                            ),
                            TextSpan(
                              text: '"tld"',
                              style: boldTextStyle.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    CustomTextFieldOutline(
                      controller: model.nimController,
                      hintText: "NIM",
                      validator: (val) => Validator.validateEmpty(
                        value: val,
                        errorMessage: "NIM tidak boleh kosong",
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 16),
                    CustomTextFieldOutline(
                      controller: model.passwordController,
                      hintText: "Password",
                      obscureText: true,
                      validator: (val) => Validator.validateEmpty(
                          value: val,
                          errorMessage: "Password tidak boleh kosong"),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: model.isBusy ? null : model.onSubmit,
                      child: model.isBusy
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            )
                          : const Text("Masuk"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
