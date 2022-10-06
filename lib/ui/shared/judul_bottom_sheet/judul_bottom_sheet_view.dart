import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pengajual_judul/app/themes/app_colors.dart';
import 'package:pengajual_judul/ui/widgets/custom_textfield_outline.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unicons/unicons.dart';

import '../../../utlis/validator.dart';
import './judul_bottom_sheet_view_model.dart';

class JudulBottomSheetView extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const JudulBottomSheetView({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JudulBottomSheetViewModel>.reactive(
      viewModelBuilder: () => JudulBottomSheetViewModel(),
      onModelReady: (JudulBottomSheetViewModel model) async {
        await model.init(completer);
      },
      builder: (
        BuildContext context,
        JudulBottomSheetViewModel model,
        Widget? child,
      ) {
        return Container(
          padding: const EdgeInsets.only(
            left: 16,
            top: 8,
            right: 16,
            bottom: 16,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: const _HookForm(),
        );
      },
    );
  }
}

class _HookForm extends HookViewModelWidget<JudulBottomSheetViewModel> {
  const _HookForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildViewModelWidget(
      BuildContext context, JudulBottomSheetViewModel viewModel) {
    final judulController = useTextEditingController();
    final fileController = useTextEditingController();

    return Form(
      key: viewModel.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: mainColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          CustomTextFieldOutline(
            controller: judulController,
            onChanged: (val) {
              viewModel.judul.judul = val;
            },
            hintText: 'Judul skripsi*',
            prefixIcon: const Icon(
              UniconsLine.book,
              color: secondaryColor,
            ),
            textInputAction: TextInputAction.next,
            validator: (val) =>
                Validator.validateEmpty(value: val, field: 'judul skripsi'),
          ),
          const SizedBox(height: 16),
          CustomTextFieldOutline(
            controller: fileController,
            onChanged: (val) {
              viewModel.judul.judul = val;
            },
            prefixIcon: const Icon(
              UniconsLine.file_upload_alt,
              color: secondaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () => viewModel.openFilePicker(fileController),
              icon: const Icon(
                Icons.upload_file,
                color: greenColor,
              ),
            ),
            hintText: 'File pengajuan judul skripsi',
            readOnly: true,
            textInputAction: TextInputAction.next,
            validator: (val) => Validator.validateEmpty(
                value: val, errorMessage: 'Silahkan pilih file pengajuan'),
          ),
          const SizedBox(height: 32),
          Flexible(
            child: ElevatedButton.icon(
              icon: viewModel.isBusy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : const Icon(
                      UniconsLine.envelope_send,
                    ),
              label: const Text('Kirim'),
              onPressed: viewModel.isBusy ? null : viewModel.onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
