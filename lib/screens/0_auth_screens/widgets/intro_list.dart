import 'package:flutter/material.dart';
import 'package:footsteps/screens/0_auth_screens/widgets/intro_model.dart';
import 'package:footsteps/styles/text_theme.dart';

class IntroList extends StatelessWidget {
  IntroList({
    required this.onPageChanged,
    required this.messages,
    required this.pageController,
  });
  final List<IntroMessage> messages;
  final Function(int) onPageChanged;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    messages[index].image,
                    height: 300,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    messages[index].title,
                    style: AppTextStyle.headline4,
                  ),
                  SizedBox(height: 16),
                  Text(
                    messages[index].description,
                    style: AppTextStyle.bodyText1,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      controller: pageController,
      itemCount: messages.length,
      onPageChanged: onPageChanged,
    );
  }
}
