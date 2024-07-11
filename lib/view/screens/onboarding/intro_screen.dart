import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/route_config/route_names.dart';
import '../../../core/utils/helper.dart';
import '../../../main.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PageController pageController = PageController();
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: Helper.introductionMessges.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                  Helper.introductionMessges[index].image!),
                              height: 200,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              Helper.introductionMessges[index].title!,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              Helper.introductionMessges[index].subtitle!,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge!,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          onDotClicked: (value) {
                            pageController.animateToPage(
                              value,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                          effect: WormEffect(
                            activeDotColor: theme.colorScheme.primary,
                            dotColor: theme.colorScheme.secondary,
                            dotHeight: 8,
                            dotWidth: 16,
                            type: WormType.thin,
                          ),
                          count: Helper.introductionMessges.length,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.signup)!.then(
                            (value) => sharedPreferences!.setBool(
                              "skipIntro",
                              true,
                            ),
                          );
                        },
                        child: const Text(
                          "Get Started",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
