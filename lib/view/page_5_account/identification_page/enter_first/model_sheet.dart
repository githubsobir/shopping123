import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

var box = Hive.box("online");
modelSheet(
    {required BuildContext context,
   }) {
  showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10))),
      context: context,
      builder: (BuildContext context) {
        return const ModelAppBarSheetLang();
      });
}
class ModelAppBarSheetLang extends StatefulWidget {
  const ModelAppBarSheetLang({Key? key}) : super(key: key);

  @override
  State<ModelAppBarSheetLang> createState() => _ModelAppBarSheetLangState();
}

class _ModelAppBarSheetLangState extends State<ModelAppBarSheetLang> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height:  10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                textColor: MyColors.appColorBlack(),
                title: MyWidgets.robotoFontText(
                    text: "O'zbekcha", textFontWeight: FontWeight.w400),
                leading: const CircleAvatar(
                  backgroundImage:
                  AssetImage("assets/images/uz.png"),
                  radius: 15,
                ),
                trailing: const Icon(CupertinoIcons.chevron_forward),
                onTap: () {
                  box.delete("language");
                  box.put("language", "1");
                  context.locale = const Locale("uz", "UZ");
                  Navigator.of(context).pop();
                  // Navigator.push(
                  //     context,
                  //     CupertinoPageRoute(
                  //       builder: (context) => const MainPages(),
                  //     ));
                },
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                textColor: MyColors.appColorBlack(),
                title: MyWidgets.robotoFontText(
                    text: "Qaraqalpaqsha", textFontWeight: FontWeight.w400),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/kk.png"),
                  radius: 15,
                ),
                trailing: const Icon(CupertinoIcons.chevron_forward),
                onTap: () {
                  box.delete("language");
                  box.put("language", "2");
                  context.locale = const Locale("kk", "KK");
                  Navigator.of(context).pop();
                },
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                textColor: MyColors.appColorBlack(),
                title: MyWidgets.robotoFontText(
                    text: "Русский", textFontWeight: FontWeight.w400),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/ru.png"),
                  radius: 15,
                ),
                trailing: const Icon(CupertinoIcons.chevron_forward),
                onTap: () {
                  box.delete("language");
                  box.put("language", "3");
                  context.locale = const Locale("ru", "RU");
                  Navigator.of(context).pop();
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

