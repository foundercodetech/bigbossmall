import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_field.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/provider/addacount_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({super.key});

  @override
  State<AddBankAccount> createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  TextEditingController accNumberCon=TextEditingController();
  TextEditingController nameCon=TextEditingController();
  TextEditingController ifscCon=TextEditingController();
  TextEditingController banknameCon=TextEditingController();
  TextEditingController branchnameCon=TextEditingController();

  @override


  Widget build(BuildContext context) {

    final authProvider = Provider.of<AddacountProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Add a bank account number',
              fontSize: height*0.025,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                  padding: const EdgeInsets.only(left: 5, right: 5,top: 5,bottom: 5),
                  decoration: BoxDecoration(
                      gradient: AppColors.secondaryappbar,
                      borderRadius: BorderRadiusDirectional.circular(30)),
                  child: ListTile(
                    leading: Image.asset(Assets.iconsAttention,color: AppColors.goldencolorthree,),
                    title: textWidget(
                        text: 'Need to add beneficiary information to be able to withdraw money',
                        color: AppColors.goldencolorthree,
                        fontWeight: FontWeight.w900),
                  )
              ),
              const SizedBox(height: 15),
              titleWidget(Assets.iconsPeople,"Full recipient's name"),
              const SizedBox(height: 15),
              CustomTextField(
                controller: nameCon,
                cursorColor: AppColors.secondaryTextColor,
                hintText: "Please enter the recipient's name",
                style: const TextStyle(color: AppColors.primaryTextColor),
                hintColor: AppColors.primaryTextColor
              ),
              const SizedBox(height: 15),
              titleWidget(Assets.iconsBank,'Bank name'),
              const SizedBox(height: 15),
              CustomTextField(
                controller: banknameCon,
                cursorColor: AppColors.secondaryTextColor,
                hintText: 'Please enter your bank name ',
                style: const TextStyle(color: AppColors.primaryTextColor),
                hintColor: AppColors.primaryTextColor

              ),
              // GestureDetector(
              //   onTap: (){
              //     Navigator.pushNamed(context, RoutesName.selectBank);
              //   },
              //   child: Container(
              //     height: 60,
              //     width: widths,
              //     padding: const EdgeInsets.only(left: 15, right: 15),
              //     decoration: BoxDecoration(
              //         gradient: AppColors.containerTopToBottomGradient,
              //         borderRadius: BorderRadiusDirectional.circular(15)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         textWidget(
              //             text: 'Please select a bank',
              //             fontSize: 18,
              //             fontWeight: FontWeight.w900,
              //             color: AppColors.primaryTextColor),
              //         const Icon(Icons.arrow_forward_ios,
              //             color: AppColors.iconSecondColor),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 15),
              titleWidget(Assets.iconsAccNumber,'Bank account number'),
              const SizedBox(height: 15),
              CustomTextField(
                controller: accNumberCon,
                cursorColor: AppColors.secondaryTextColor,
                hintText: 'Please enter your bank account no.',
                style: const TextStyle(color: AppColors.primaryTextColor),
                hintColor: AppColors.primaryTextColor,

              ),

              const SizedBox(height: 15),
              titleWidget(Assets.iconsAccNumber,'Bank branch'),
              const SizedBox(height: 15),
              CustomTextField(
                controller: branchnameCon,
                cursorColor: AppColors.secondaryTextColor,
                hintText: 'Please enter your branch name ',
                style: const TextStyle(color: AppColors.primaryTextColor),
                hintColor: AppColors.primaryTextColor

              ),
              // titleWidget(Assets.iconsBankPhone,'Phone number'),
              // const SizedBox(height: 15),
              // CustomTextField(
              //   controller: phoneCon,
              //   cursorColor: AppColors.secondaryTextColor,
              //   hintText: 'Please enter your phone number',
              // ),
              const SizedBox(height: 15),
              titleWidget(Assets.iconsIfscCode,'IFSC code'),
              const SizedBox(height: 15),
              CustomTextField(
                controller: ifscCon,
                cursorColor: AppColors.secondaryTextColor,
                hintText: 'Please enter IFSC code',
                style: const TextStyle(color: AppColors.primaryTextColor),
                hintColor: AppColors.primaryTextColor
              ),
              const SizedBox(height: 15),
              AppBtn(
                onTap: () async {
                  authProvider.Addacount(context, nameCon.text,banknameCon.text, accNumberCon.text, branchnameCon.text, ifscCon.text);
                },
                title: 'S a v e',
                fontSize: 20,
                hideBorder: true,
                fontWeight: FontWeight.w900,
                gradient: AppColors.primaryappbargrey,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  Widget titleWidget(String image,String title){
    return Row(
      children: [
        Image.asset(image,color: AppColors.goldencolortwo,height: 30,),
        const SizedBox(width: 10),
        textWidget(
            text:
            title,
            fontSize: 18,
            color: AppColors.goldencolorthree,
            fontWeight: FontWeight.w600),
      ],
    );
  }

}
