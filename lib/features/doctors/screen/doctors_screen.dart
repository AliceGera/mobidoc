import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/doctors/doctors_data.dart';
import 'package:flutter_template/features/common/widgets/app_doctor_widget.dart';
import 'package:flutter_template/features/common/widgets/app_error_widget.dart';
import 'package:flutter_template/features/common/widgets/app_item_loading_widget.dart';
import 'package:flutter_template/features/doctors/screen/doctors_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// Main widget for DoctorsScreen feature.
@RoutePage(
  name: AppRouteNames.doctorsScreen,
)
class DoctorsScreen extends ElementaryWidget<IDoctorsScreenWidgetModel> {
  /// Create an instance [DoctorsScreen].
  const DoctorsScreen({
    Key? key,
    WidgetModelFactory wmFactory = doctorsScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IDoctorsScreenWidgetModel wm) {
    return StateNotifierBuilder<EntityState<Doctors>>(
      listenableState: wm.DoctorsState,
      builder: (_, doctors) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.backgroundColor,
            centerTitle: false,
            title: Text(
              'Наши врачи',
              style: AppTextStyle.bold30.value.copyWith(color: AppColors.black),
            ),
          ),
          body: doctors?.hasError == true
              ? const AppErrorWidget(
                  wrongText: 'Что-то пошло не так!\nПовторите попытку.',
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 31),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return doctors?.isLoading == true
                                  ? const AppItemLoadingWidget()
                                  : AppDoctorWidget(
                                      doctor: doctors?.data?.member[index].speciality ?? '',
                                      doctorName: doctors?.data?.member[index].name ?? '',
                                      bio: doctors?.data?.member[index].bio ?? '',
                                    );
                            },
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
