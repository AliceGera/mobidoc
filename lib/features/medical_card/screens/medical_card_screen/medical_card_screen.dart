// ignore_for_file: avoid_field_initializers_in_const_classes

import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_loading_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_widget.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

/// medical card screens.
@RoutePage(
  name: AppRouteNames.medicalCardScreen,
)
class MedicalCardScreen extends ElementaryWidget<IMedicalCardScreenWidgetModel> {
  /// Create an instance [MedicalCardScreen].
  const MedicalCardScreen({
    Key? key,
    WidgetModelFactory wmFactory = medicalCardScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IMedicalCardScreenWidgetModel wm) {
    return Scaffold(
      body: _Body(
        themeState: wm.themeState,
        setThemeMode: wm.setThemeMode,
        openNextScreen: wm.openNextScreen,
        controller: wm.controller,
        result: wm.result,
        onQRViewCreated: wm.onQRViewCreated,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final ListenableState<ThemeMode> themeState;
  final void Function(ThemeMode?) setThemeMode;
  final bool isLoading = false;
  final VoidCallback openNextScreen;
  final void Function(QRViewController) onQRViewCreated;
  final QRViewController? controller;
  final Barcode? result;

  _Body({
    required this.themeState,
    required this.setThemeMode,
    required this.openNextScreen,
    required this.controller,
    required this.result,
    required this.onQRViewCreated,
  });

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isLoading
        ? _LoadingStateWidget()
        : Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.backgroundColor,
              title: Text(
                'Медицинская карта ',
                style: AppTextStyle.bold30.value.copyWith(color: AppColors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: openNextScreen,
                          child: const AppItemWidget(
                            title: 'Abril',
                            textInfo: 'Informe completo',
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                      child: AppButtonWidget(
                        title: 'Добавить карту',
                        onPressed: () {
                          showModalBottomSheet<void>(
                            backgroundColor: AppColors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => Navigator.pop(context),
                                          child: Text(
                                            'Отмена',
                                            style: AppTextStyle.medium16.value.copyWith(color: AppColors.darkBlue),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 40),
                                          child: Text(
                                            'Добавить карту',
                                            style: AppTextStyle.bold20.value.copyWith(color: AppColors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.45,
                                      child: Column(
                                        children: [
                                          Expanded(flex: 4, child: _buildQrView(context)), FittedBox(
                                            fit: BoxFit.contain,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                if (result != null)
                                                  Text('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                                                else
                                                  const Text('Scan a code'),
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}

class _LoadingStateWidget extends StatelessWidget {
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text('Медицинская карта', style: AppTextStyle.bold30.value),
              ),
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const AppItemLoadingWidget();
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
