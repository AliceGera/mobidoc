import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// Onboarding screen.
@RoutePage(name: AppRouteNames.onboardingScreen)
class OnboardingScreen extends StatefulWidget {
  // ignore: public_member_api_docs
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _AppBarOnboardingWidget(index: index),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  onPageChanged: (idx) {
                    setState(() {
                      index = idx;
                    });
                  },
                  children: const <Widget>[
                    _MainWidget(
                      assetName: 'assets/images/onboarding_first.svg',
                      title: 'Обращайтесь к врачу',
                      subtitle: 'Консультациия посредством мобильной связи',
                    ),
                    _MainWidget(
                      assetName: 'assets/images/onboarding_second.svg',
                      title: 'Большой ассортимент',
                      subtitle: 'Большой ассортимент врачей, с которыми можно пообщаться',
                    ),
                    _MainWidget(
                      assetName: 'assets/images/onboarding_third.svg',
                      title: 'Электронная медкарта',
                      subtitle: 'Возможность использования смартфона в качестве медкарты',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 21, top: 30),
                child: AppButtonWidget(
                  title: index == 0
                      ? 'Ох ты!'
                      : index == 1
                          ? 'Обалдеть!'
                          : index == 2
                              ? 'Начать работу!'
                              : '',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainWidget extends StatelessWidget {
  const _MainWidget({
    required this.assetName,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String assetName;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(assetName),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.bold22.value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyle.regular16.value,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarOnboardingWidget extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarOnboardingWidget({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: index != 2
          ? InkWell(
              onTap: () {},
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 18, 16, 18),
                      child: InkWell(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onTap: () {},
                        child: Text(
                          'Пропустить',
                          style: AppTextStyle.semiBold16.value.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
