import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_1_main/widgets_main/main_body.dart';
import 'package:shopping/view/page_1_main/widgets_main/main_header.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  getData(){}
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
            title: Text('UZ BAZAR'),
            elevation: 0,
            backgroundColor: MyColors.appColorUzBazar()),
        body: SafeArea(
          child: NestedScrollView(
              floatHeaderSlivers: false,

              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  mainHeader(context: context, ref: ref)
                ];
              },
              body:mainBody(context: context, ref: ref)),
        ));
  }
}
