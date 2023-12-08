// ignore_for_file: avoid_field_initializers_in_const_classes, use_if_null_to_convert_nulls_to_bools

import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/medical_card/medical_cards_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_error_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_loading_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_widget.dart';
import 'package:flutter_template/features/medical_card/screens/medical_card_screen/medical_card_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:union_state/union_state.dart';

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
        medicalCardsState: wm.medicalCardsState,
        onQRViewCreated: wm.onQRViewCreated,
        openNextScreen: wm.openNextScreen,
        onShowModalBottomSheet: wm.onShowModalBottomSheet,
        isFindQr: wm.isFindQr,
        isShow: wm.isShow,
        isFirstTime: wm.isFirstTime,
        someMethod: wm.someMethod,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final ListenableState<bool> isFindQr;
  final ListenableState<bool> isShow;
  final ListenableState<bool> isFirstTime;
  final UnionStateNotifier<MedicalCards> medicalCardsState;
  final OpenNextScreen openNextScreen;
  final void Function(QRViewController) onQRViewCreated;
  final void Function(BuildContext context) onShowModalBottomSheet;
  final VoidCallback someMethod;

  const _Body({
    required this.isFirstTime,
    required this.isFindQr,
    required this.isShow,
    required this.medicalCardsState,
    required this.openNextScreen,
    required this.onQRViewCreated,
    required this.onShowModalBottomSheet,
    required this.someMethod,
  });

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return UnionStateListenableBuilder<MedicalCards>(
      unionStateListenable: widget.medicalCardsState,
      builder: (_, medicalCards) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.backgroundColor,
            title: Text(
              'Медицинская карта',
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
                    itemCount: medicalCards.member.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          widget.openNextScreen(
                            medicalCards.member[index].name ?? '',
                            medicalCards.member[index].description ?? '',
                          );
                        },
                        child: AppItemWidget(
                          title: medicalCards.member[index].name,
                          textInfo: medicalCards.member[index].description,
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
                        var isModalBottomSheetOpened = false;
                        showModalBottomSheet<void>(
                          backgroundColor: AppColors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            if (!isModalBottomSheetOpened) {
                              isModalBottomSheetOpened = true;
                              widget.onShowModalBottomSheet.call(context);
                            }
                            return StateNotifierBuilder(
                              listenableState: widget.isShow,
                              builder: (context, isShowValue) {
                                return StateNotifierBuilder(
                                  listenableState: widget.isFindQr,
                                  builder: (context, isFindQrValue) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 18),
                                            child: Row(
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
                                          ),
                                          Stack(
                                            children: [
                                              if(isShowValue != true)
                                              SizedBox(
                                                height: size.height * 0.40,
                                                child: Column(
                                                  children: [
                                                    Expanded(flex: 4, child: _buildQrView(context)),
                                                  ],
                                                ),
                                              ),
                                              if (isFindQrValue == true && isShowValue == true)
                                                Container(
                                                  width: double.infinity,
                                                  color: AppColors.backgroundColor.withOpacity(.5),
                                                  height: size.height * 0.40,
                                                  child: SvgPicture.asset(
                                                    'assets/images/check_circle.svg',
                                                    height: 30,
                                                    width: 30,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                ),
                                              if (isFindQrValue == false && isShowValue == true)
                                                Container(
                                                  color: AppColors.backgroundColor.withOpacity(.5),
                                                  height: size.height * 0.40,
                                                  child: Column(
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets.only(top: 40),
                                                        child: AppErrorWidget(
                                                          wrongText: 'Ошибка\n сканирования.\nПопробуйте еще раз!',
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 33,vertical: 15),
                                                        child: AppButtonWidget(
                                                          title: 'Повторить',
                                                          onPressed: widget.someMethod,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
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
      },
      loadingBuilder: (_, medicalCards) => _LoadingStateWidget(),
      failureBuilder: (_, exception, medicalCards) => const AppErrorWidget(
        wrongText: 'Что-то пошло не так!\nПовторите попытку.',
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: QRView(
        key: qrKey,
        onQRViewCreated: widget.onQRViewCreated,
        overlay: QrScannerOverlayShape(borderColor: AppColors.backgroundColor, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
