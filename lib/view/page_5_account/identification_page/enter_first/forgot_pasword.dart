import 'package:flutter/cupertino.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/reset_passwod/reset_password.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

Widget forgotPassword(
    {required BuildContext context,
    }) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => ResetPasswords(),));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          child: MyWidgets.robotoFontText(
              text: "resetPassword".tr(), textColor: MyColors.appColorGrey400()),
        ),
      ],
    ),
  );
}
