
import 'dart:convert';
import 'package:bbm/main.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/api_urls.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;



class HowtoplayScreen extends StatefulWidget {
  const HowtoplayScreen({super.key});

  @override
  State<HowtoplayScreen> createState() => _HowtoplayScreenState();
}

class _HowtoplayScreenState extends State<HowtoplayScreen> {

  @override
  void initState() {
    viewprofile();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
          title: textWidget(
              text: 'How to Play',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryGradient),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              disc==null?Container():
              HtmlWidget(disc.description.toString()),
            ),


          ],
        ),


      ),
    ));
  }


  // var disc;
  // var name;
  // fetchHowtoplayDatacolor() async {
  //
  //   final response = await http.get(Uri.parse('${ApiUrl.HowtoplayApi}2')).timeout(const Duration(seconds: 10));
  //
  //   print(ApiUrl.HowtoplayApi+"2");
  //   print("ApiUrl.HowtoplayApi2");
  //   if(response.statusCode==200){
  //     print(response.statusCode);
  //     print("guyguggggu");
  //     final responseData = json.decode(response.body)['data'];
  //     print(responseData);
  //     print('wwwwww');
  //     print('wwwwww');
  //     setState(() {
  //       disc= responseData['description'];
  //
  //     });
  //
  //
  //
  //     print("guygugu");
  //
  //   }else{
  //     throw Exception("load to display");
  //   }
  // }


  dynamic disc;
  viewprofile() async {

    final response = await http.get(
      Uri.parse('${ApiUrl.HowtoplayApi}2'),

    );
    // .onError((error, stackTrace) => InternetSlowMsg(context));
    var data = jsonDecode(response.body)['data'];
    if (data['error'] == '200') {
      setState(() {
        disc = data['description'];
      });
    }
  }


}
