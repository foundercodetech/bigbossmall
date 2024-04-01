import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/model/addaccount_view_model.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:bbm/utils/routes/routes_name.dart';

class AccountView extends StatefulWidget {
  final AddacountViewModel data;
  const AccountView({super.key,required this.data});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffolddark,
        appBar: GradientAppBar(
            leading: const AppBackBtn(),
            title: textWidget(
                text: 'Account Details',
                fontSize: 25,
                color: AppColors.primaryTextColor),
            gradient: AppColors.secondaryappbar),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: height*0.01,),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: AppColors.secondaryappbar,
                ),
                child: Column(
                  children: [
                    Container(
                      height: height*0.06,
                      decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                        gradient: AppColors.goldenGradientDir,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: Container(
                        height: height*0.07,
                        color: Colors.black,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width*0.45,
                              child:  textWidget(text: "   Name",fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryTextColor),
                            ),
                            Container(
                              child:  textWidget(text: widget.data.name.toString(),fontWeight: FontWeight.w600,color: AppColors.primaryTextColor),
                            ),
                          ],
                        ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: Container(
                        height: height*0.07,
                        color: Colors.black,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width*0.45,
                              child:  textWidget(text: "   Account Number",fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryTextColor),
                            ),
                            Container(
                              child:  textWidget(text: widget.data.account_no.toString(),fontWeight: FontWeight.w600,color: AppColors.primaryTextColor),
                            ),
                          ],
                        ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: Container(
                        height: height*0.07,
                        color: Colors.black,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width*0.45,
                              child:  textWidget(text: "   Bank Name",fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryTextColor),
                            ),
                            Container(
                              child:  textWidget(text: widget.data.bank_name.toString(),fontWeight: FontWeight.w600,color: AppColors.primaryTextColor),
                            ),
                          ],
                        ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: Container(
                        height: height*0.07,
                        color: Colors.black,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width*0.45,
                              child:  textWidget(text: "   Branch",fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryTextColor),
                            ),
                            Container(
                              child:  textWidget(text: widget.data.branch.toString(),fontWeight: FontWeight.w600,color: AppColors.primaryTextColor),
                            ),
                          ],
                        ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      child: Container(
                        height: height*0.07,
                        color: Colors.black,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width*0.45,
                              child:  textWidget(text: "   IFSC",fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.primaryTextColor),
                            ),
                            Container(
                              child:  textWidget(text: widget.data.ifsc.toString(),fontWeight: FontWeight.w600,color: AppColors.primaryTextColor),
                            ),
                          ],
                        ),),
                    ),
                    SizedBox(height: height*0.02,)
                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.03,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.addBankAccount);
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Container(
                  width: width,
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  decoration: BoxDecoration(gradient: AppColors.secondaryappbar, borderRadius: BorderRadiusDirectional.circular(10)),
                  child: Column(
                    children: [
                      const SizedBox(width: 15),
                      Image.asset(Assets.iconsAddBank,height: 60,),
                      const SizedBox(width: 15),
                      textWidget(
                          text: 'Add a bank account number',
                          color: AppColors.primaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
