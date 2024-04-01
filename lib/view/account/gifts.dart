import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_field.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/provider/giftcode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GiftsPage extends StatefulWidget {
  const GiftsPage({super.key});

  @override
  GiftsPageState createState() => GiftsPageState();
}

class GiftsPageState extends State<GiftsPage> {

  TextEditingController giftcode = TextEditingController();

  String number = "";

  @override
  Widget build(BuildContext context) {
    final giftProvider = Provider.of<GiftcardProvider>(context);

    
    return Scaffold(
      appBar: GradientAppBar(
          leading:const AppBackBtn(),
          title: textWidget(
              text: 'Gift',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.goldenGradient),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height/3.5,
              width: width,
              decoration:  BoxDecoration(
                  gradient: AppColors.goldenGradient,
                  image:const DecorationImage(
                    image: AssetImage(Assets.imagesGift),
                  )
              ),
            ),
            const SizedBox(height: 5,),
            Container(
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(text: '   Hi',fontSize: 14,color: AppColors.secondaryTextColor),
                    textWidget(text: '   We have a gift for you',fontSize: 14,color: AppColors.secondaryTextColor),
                    const SizedBox(height: 20,),
                    CustomTextField(
                      controller: giftcode,
                      hintText: 'Please enter gift code',
                      fieldRadius: BorderRadius.circular(50),
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    ),
                     AppBtn(
                      title: 'Receive',
                      titleColor: Colors.white,
                       gradient: AppColors.goldenGradient,
                       onTap: (){
                        giftProvider.Giftcode(context, giftcode.text);
                      },
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}