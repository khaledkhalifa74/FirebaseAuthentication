import 'package:firebase_features/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_features/core/utils/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({super.key});

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  UniqueKey _imageKey = UniqueKey();
  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<DropDownTemplate>(
      value:
      languages.where((element) => element.value == globals.appLang).first,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: kContentTextColor,
      ),
      dropdownColor: kWhiteColor,
      borderRadius: BorderRadius.circular(8),
      underline: const SizedBox(),
      onChanged: (DropDownTemplate? value) async {
        await sharedPrefs.setString('locale', value!.value.toString());
        // await CasheHelper.addStringToSP('locale', value!.value.toString());
        globals.appLang = value.value;
        setState(() {
          _imageKey = UniqueKey();
        });
        globals.restartApp();
      },
      items: languages
          .map<DropdownMenuItem<DropDownTemplate>>((DropDownTemplate value) {
        return DropdownMenuItem<DropDownTemplate>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(value.image, width: 30, key: _imageKey),
              const SizedBox(
                width: 10,
              ),
              Text(
                value.text,
                style: const TextStyle(
                    color: kContentTextColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class DropDownTemplate {
  String text;
  String value;
  String image;
  DropDownTemplate(this.text, this.value, this.image);
}

List<DropDownTemplate> languages = <DropDownTemplate>[
  DropDownTemplate('العربية', 'ar', 'assets/images/ar_sa.png'),
  DropDownTemplate('English', 'en', 'assets/images/en_en.png')
];
