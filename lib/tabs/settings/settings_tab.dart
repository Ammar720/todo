import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/cache_data.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/tabs/settings/languages.dart';
import 'package:todo/tabs/settings/setting_provider.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    List<Languages> languages = [
      Languages(name: AppLocalizations.of(context)!.english, code: 'en'),
      Languages(name: AppLocalizations.of(context)!.arabic, code: 'ar')
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.logout,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                    onPressed: () {
                      FirebaseFunctions.logout();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                      Provider.of<TasksProvider>(context, listen: false)
                          .resetData();
                      Provider.of<UserProvider>(context, listen: false)
                          .updateUser(null);
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 30,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: settingProvider.languageCode,
                    items: languages
                        .map((language) => DropdownMenuItem(
                              value: language.code,
                              child: Text(language.name),
                            ))
                        .toList(),
                    onChanged: (selectedLanguage) => {
                      settingProvider.changeLanguage(selectedLanguage!),
                      CacheData.setlanguage(value: selectedLanguage)
                    },
                    dropdownColor: AppTheme.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
