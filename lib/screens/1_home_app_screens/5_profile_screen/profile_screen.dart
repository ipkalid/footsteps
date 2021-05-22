import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footsteps/main.dart';
import 'package:footsteps/provider/app_language_provider.dart';
import 'package:footsteps/provider/app_theme_provider.dart';
import 'package:footsteps/screens/1_home_app_screens/5_profile_screen/edit_profile.dart';
import 'package:footsteps/screens/1_home_app_screens/5_profile_screen/widget/image_profile.dart';
import 'package:footsteps/screens/1_home_app_screens/5_profile_screen/widget/setting_item.dart';
import 'package:footsteps/styles/app_colors.dart';
import 'package:footsteps/styles/text_theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppLanguageProvider appLanguageProvider =
        Provider.of<AppLanguageProvider>(context);
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Setting"),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Row(
              children: [
                ProfileImageView(src: auth.getUserImageUrl()),
                SizedBox(
                  height: 64,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        auth.getUser()!.displayName!,
                        style: AppTextStyle.headline5,
                      ),
                      Text(
                        "es",
                        style: AppTextStyle.subtitle1,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.black26,
            ),
            SettingItem(
                label: "Account",
                icon: Icons.person_outlined,
                onTap: () => goToEditProfileScreen()),
            SettingItem(
                label: "Language",
                icon: Icons.language,
                onTap: () => selectLanguages(context, appLanguageProvider)),
            SettingItem(
              label: "View Mode",
              icon: Icons.dark_mode_outlined,
              onTap: () => selectViewMode(context, appThemeProvider),
            ),
            Divider(
              color: Colors.black26,
            ),
            SettingItem(
              label: "Twitter",
              icon: FontAwesomeIcons.twitter,
              onTap: () => launchURL("https://twitter.com/ikalhazmi"),
            ),
            SettingItem(
              label: "GitHub",
              icon: FontAwesomeIcons.github,
              onTap: () => launchURL("https://github.com/ipkalid/footsteps"),
            ),
          ],
        ));
  }

  void launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void signOut() => auth.signOut();

  void selectViewMode(BuildContext context, AppThemeProvider appTheme) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text("Select Theme"),
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "cancel",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Light',
              style: TextStyle(color: AppColor.darkGreen),
            ),
            onPressed: () {
              // appLanguage.changeLanguage(Locale("en"));
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Dark",
              style: TextStyle(color: AppColor.darkGreen),
            ),
            onPressed: () {
              // appLanguage.changeLanguage(Locale("ar"));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void selectLanguages(BuildContext context, AppLanguageProvider appLanguage) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text("Select Language"),
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "cancel",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'English',
              style: TextStyle(color: AppColor.darkGreen),
            ),
            onPressed: () {
              // appLanguage.changeLanguage(Locale("en"));
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "العربية",
              style: TextStyle(color: AppColor.darkGreen),
            ),
            onPressed: () {
              // appLanguage.changeLanguage(Locale("ar"));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void goToEditProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(),
      ),
    );
  }
}
