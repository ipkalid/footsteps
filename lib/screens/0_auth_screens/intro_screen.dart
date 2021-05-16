import 'package:flutter/material.dart';
import 'package:footsteps/helpers/image_path.dart';
import 'package:footsteps/screens/0_auth_screens/widgets/intro_list.dart';
import 'package:footsteps/screens/0_auth_screens/widgets/intro_model.dart';
import 'package:footsteps/styles/app_colors.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro-screen';
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentPage = 0;
  PageController pageController = PageController(initialPage: 0);
  List<IntroMessage> introMessages = [
    IntroMessage(
        image: ImagePath.walk,
        title: "Walk",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    IntroMessage(
        image: ImagePath.win,
        title: "ee",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    IntroMessage(
        image: ImagePath.gift,
        title: "ee",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    IntroMessage(image: ImagePath.sign, title: "", description: ""),
    //IntroMessage(description: "ccc", title: "cc"),
  ];
  //@override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   introMessages = [
  //     IntroMessage(image: ImagePath.walk, description: "aaa", title: "ee"),
  //     IntroMessage(image: ImagePath.win, description: "aaa", title: "ee"),
  //     IntroMessage(image: ImagePath.gift, description: "aaa", title: "ee"),
  //     //IntroMessage(description: "bbb", title: "cc"),
  //     //IntroMessage(description: "ccc", title: "cc"),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Image.asset("assets/illustrations/gift.png"),
            Expanded(
              child: IntroList(
                messages: introMessages,
                pageController: pageController,
                onPageChanged: (index) => _updateIndicator(index),
              ),
            ),
            if (_lastPage())
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: ElevatedButton(
                        child: Text("kk"),
                        onPressed: () {},
                        //onPressed: () => _goToSignUpPage(context),
                        //hideShadow: true,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(100, 0),
                      primary: _firstPage() ? Colors.grey : AppColor.lightGreen,
                    ),
                    child: Text(
                      "Previous",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () => _firstPage()
                        ? null
                        : pageController.previousPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.ease,
                          ),
                  ),
                  if (!_lastPage()) indicator(),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(100, 0),
                      primary:
                          _lastPage() ? Colors.blue[300] : AppColor.lightGreen,
                    ),
                    child: Text(
                      _lastPage() ? "Sign In" : "Next",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () => _lastPage()
                        ? null
                        : pageController.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.ease,
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: introMessages.map(
        (message) {
          var index = introMessages.indexOf(message);
          return Container(
            width: (currentPage == index) ? 20 : 7.0,
            height: 7.0,
            margin: EdgeInsets.symmetric(horizontal: 2.3),
            decoration: BoxDecoration(
              //shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(10),
              color: (currentPage == index)
                  ? AppColor.lightGreen
                  : Color(0xFFA6AEBD),
            ),
          );
        },
      ).toList(),
    );
  }

  // void _goToSignUpPage(BuildContext context) {
  //   showModalBottomSheet(
  //     enableDrag: true,
  //     isDismissible: false,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(32),
  //       ),
  //     ),
  //     context: context,
  //     builder: (ctx) {
  //       return CustomBottomSheet(
  //         child: SignUpScreen(),
  //       );
  //     },
  //   );
  // }

  // void _goToSignInPage(BuildContext context) {
  //   showModalBottomSheet(
  //     enableDrag: true,
  //     isDismissible: false,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(32),
  //       ),
  //     ),
  //     context: context,
  //     builder: (ctx) {
  //       return CustomBottomSheet(
  //         child: SignInScreen(),
  //       );
  //     },
  //   );
  // }

  void _updateIndicator(int index) {
    setState(
      () {
        currentPage = index;
      },
    );
  }

  bool _lastPage() {
    return (currentPage == introMessages.length - 1);
  }

  bool _firstPage() {
    return (currentPage == 00);
  }
}
