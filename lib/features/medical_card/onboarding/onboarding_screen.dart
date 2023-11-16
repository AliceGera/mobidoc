// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

// ignore: public_member_api_docs
@RoutePage(name: AppRouteNames.onboardingScreen)
class OnboardingScreen extends StatefulWidget {

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.7,
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  onPageChanged: (idx) {
                    setState(() {
                      index = idx;
                    });
                  },
                  children: <Widget>[
                    _MainWidget(
                      size: size,
                      title: 'Добро пожаловать \nв Путеводитель',
                      subtitle: 'Ищи новые локации и сохраняй \nсамые любимые.',
                    ),
                    _MainWidget(
                      size: size,
                      title: 'Построй маршрут \nи отправляйся в путь',
                      subtitle: 'Достигай цели максимально \nбыстро и комфортно.',
                    ),
                    _MainWidget(
                      size: size,
                      title: 'Добавляй места,\nкоторые нашёл сам',
                      subtitle: 'Делись самыми интересными\nи помоги нам стать лучше!',
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (index == 2) ...[
                SizedBox(height: size.height * 0.04),
                SizedBox(height: size.height * 0.01),
              ] else
                SizedBox(height: size.height * 0.05 + 48),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainWidget extends StatelessWidget {
  const _MainWidget({
    required this.size,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final Size size;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.23),
          SizedBox(height: size.height * 0.05),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            subtitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
