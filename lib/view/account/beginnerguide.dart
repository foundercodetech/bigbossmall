// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:bbm/main.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/helper/api_helper.dart';
import 'package:bbm/res/provider/Beginner_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class BeginnersGuideScreen extends StatefulWidget {
  const BeginnersGuideScreen({super.key});

  @override
  State<BeginnersGuideScreen> createState() => _BeginnersGuideScreenState();
}

class _BeginnersGuideScreenState extends State<BeginnersGuideScreen> {

  @override
  void initState() {
    fetchbegin();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final DataBeginnerGuide = Provider.of<BeginnerProvider>(context).BeginnerData;


    return SafeArea(child: Scaffold(
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Beginner Guide',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: DataBeginnerGuide!= null?SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(DataBeginnerGuide.disc.toString()),
                ),

              ],
            )),


      ):Container(),
    ));
  }
  Future<void> fetchbegin() async {
    try {
      final DataBegin = await  baseApiHelper.fetchBeginnerData();
      if (DataBegin != null) {
        Provider.of<BeginnerProvider>(context, listen: false).setbeginner(DataBegin);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
