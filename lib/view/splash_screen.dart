import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/provider/services/splash_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {

    super.initState();
    splashServices.checkAuthentication(context);

  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Container(
      height: height,
      width: width,
      decoration:  BoxDecoration(
        gradient: AppColors.goldenGradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.imagesSplashImage, height: 300),
          const SizedBox(height: 20),
          textWidget(
              text: 'Withdraw fast, safe and stable',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor),
          const SizedBox(height: 5),
          textWidget(
              text: 'Quick withdraw',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor),
          const SizedBox(height: 50),
          Image.asset(Assets.imagesLogoredmeta, height: 80,color: Colors.white,),


        ],
      ),
    ));
  }
}
