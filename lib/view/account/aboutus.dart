// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:bbm/main.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/helper/api_helper.dart';
import 'package:bbm/res/provider/aboutus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {

  @override
  void initState() {
    fetchDataAboutus();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final dataabout = Provider.of<AboutusProvider>(context).aboutusData;

    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
          title: textWidget(
              text: 'About Us',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: dataabout!= null?SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(dataabout.disc.toString(),textStyle: const TextStyle(color: AppColors.primaryTextColor),),
                ),

              ],
            )),


      ):Container(),
    ));
  }
  Future<void> fetchDataAboutus() async {
    try {
      final AbouttDataa = await  baseApiHelper.fetchaboutusData();

      if (AbouttDataa != null) {
        Provider.of<AboutusProvider>(context, listen: false).setUser(AbouttDataa);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
