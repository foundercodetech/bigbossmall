// ignore_for_file: use_build_context_synchronously
import 'package:bbm/main.dart';
import 'package:bbm/res/components/clipboard.dart';
import 'package:bbm/view/auth/customerService.dart';
import 'package:flutter/foundation.dart';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/api_urls.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/helper/api_helper.dart';
import 'package:bbm/res/provider/profile_provider.dart';
import 'package:bbm/utils/routes/routes_name.dart';
import 'package:bbm/view/account/aboutus.dart';
import 'package:bbm/view/account/change_password.dart';
import 'package:bbm/view/account/logout.dart';
import 'package:bbm/view/account/service_center/contact_us.dart';
import 'package:bbm/view/account/service_center/privacy_policy.dart';
import 'package:bbm/view/account/service_center/terms_condition.dart';
import 'package:bbm/view/home/notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();


  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<ProfileProvider>(context).userData;
    
    List<TranUiModel> tranUiList = [
      TranUiModel(
          image: Assets.iconsBetHistory,
          title: 'Bet',
          subtitle: 'My betting history',
         onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>const BetHistory()));
            Navigator.pushNamed(context, RoutesName.Bethistoryscreen);
         }
      ),
      TranUiModel(
          image: Assets.iconsDepositHistory,
          title: 'Deposit',
          subtitle: 'My deposit history',
        onTap: (){
          Navigator.pushNamed(context, RoutesName.depositHistory);
          }
      ),
      TranUiModel(
          image: Assets.iconsWithdrawHistory,
          title: 'Withdraw',
          subtitle: 'My withdraw history',
        onTap: (){
          Navigator.pushNamed(context, RoutesName.withdrawalHistory);

        }
      ),
    ];
    List<ServiceModel> serviceList = [
      ServiceModel(
        image: Assets.iconsSetting,
        title: 'Profile',
        onTap: (){
          Navigator.pushNamed(context, RoutesName.settingscreen);
        }
      ),
      ServiceModel(
        image: Assets.iconsFeedback,
        title: 'Feedback',
          onTap: (){
          Navigator.pushNamed(context, RoutesName.feedbackscreen);
        }
      ),
      ServiceModel(
        image: Assets.iconsNotification,
        title: 'Notification',
          onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));

          }
      ),
      ServiceModel(
          image: Assets.iconsCusService,
          title: 'Terms & ',
          subtitle: "Condition",
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const TermsCondition()));

          }
      ),
      ServiceModel(
          image: Assets.iconsBigGuide,
          title: "Privacy Policy",
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrivacyPolicy()));

          }
      ),
      ServiceModel(
        image: Assets.iconsAboutus,
        title: 'About us',
          onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Aboutus()));
          }
      ),
      ServiceModel(
          image: Assets.iconsAboutus,
          title: 'Contact us',
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactUs()));
          }
      ),
      ServiceModel(
          image: Assets.iconsCustomer,
          title: 'Customer',
          subtitle: "Services",
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomerService()));
          }
      ),

    ];
    List<ProInfoModel> proInfoList = [
      ProInfoModel(
        image: Assets.iconsGift,
        title: 'Gifts',
        onTap: (){
          Navigator.pushNamed(context, RoutesName.giftsscreen);
        }
      ),
      ProInfoModel(
        image: Assets.iconsPassword,
        title: 'Change password',
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangePassword()));
        }),

    ];

    return Scaffold(
        backgroundColor: AppColors.scaffolddark,
        body:
        userData !=null ?
        ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: height * 0.39,
                      width: width,
                      decoration:   BoxDecoration(gradient:AppColors.goldenGradientDir,borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight:Radius.circular(40) )),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 55, 10, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userData.photo==null?
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(Assets.person5),
                            )
                                :
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.deepPurple.shade100,
                              backgroundImage: NetworkImage(ApiUrl.uploadimage+userData.photo.toString()),
                            ),
                            // CircleAvatar(
                            //   radius: 50,
                            //   backgroundColor: Colors.grey.shade300,
                            //   // backgroundImage: AssetImage(Assets.person5),
                            //   child: Icon(Icons.person,size: 70,),
                            // ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                    text: userData.username==null?"MEMBERNGKC":userData.username.toString(),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.browntextprimary),
                                SizedBox(height: height*0.01,),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: AppColors.browntextprimary,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(30),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        textWidget(
                                            text: 'UID',
                                            color: AppColors.primaryTextColor,
                                            fontSize: 16),
                                        const SizedBox(width: 8),
                                        Container(
                                          width: 2,
                                          height: 18,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 8),
                                        textWidget(
                                            text: userData.custId.toString(),
                                            color: AppColors.primaryTextColor,
                                            fontSize: 16),
                                        const SizedBox(width: 8),
                                        InkWell(
                                            onTap: (){
                                              copyToClipboard(userData.custId.toString(),context);
                                            },
                                            child: Image.asset(Assets.iconsCopy)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: 190,
                        child: Container(
                          height: height*0.15,
                          width: width * 0.95,
                          decoration: BoxDecoration(
                              gradient: AppColors.secondaryappbar,
                              borderRadius: BorderRadiusDirectional.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                    text: 'Total Balance',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 25,
                                  color: AppColors.goldencolortwo
                                    ),
                                Row(
                                  children: [
                                    const Icon(Icons.currency_rupee, size: 25,color: AppColors.goldencolortwo),
                                    textWidget(
                                        text: double.parse(userData.wallet).toStringAsFixed(2),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 25,
                                        color: AppColors.goldencolortwo
                                    ),
                                    InkWell(
                                        onTap: (){
                                          fetchData();
                                        },
                                        child: Image.asset(Assets.iconsTotalBal,color: AppColors.primaryTextColor,)),
                                  ],
                                ),
                                // const Spacer(),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     InkWell(
                                //       onTap: () {
                                //         FeedbackProvider.navigateToWallet(context);
                                //         },
                                //       child: Column(
                                //         children: [
                                //           Image.asset(Assets.iconsProWallet),
                                //           textWidget(
                                //               text: 'Wallet',
                                //               fontWeight: FontWeight.w400,
                                //               fontSize: 18,
                                //               color:
                                //                   AppColors.secondaryTextColor),
                                //         ],
                                //       ),
                                //     ),
                                //     InkWell(
                                //       onTap: () {
                                //         Navigator.pushNamed(context, RoutesName.depositScreen);
                                //       },
                                //       child: Column(
                                //         children: [
                                //           Image.asset(Assets.iconsProDeposit),
                                //           textWidget(
                                //               text: 'Deposit',
                                //               fontWeight: FontWeight.w400,
                                //               fontSize: 18,
                                //               color: AppColors.secondaryTextColor),
                                //         ],
                                //       ),
                                //     ),
                                //     InkWell(
                                //       onTap: () {
                                //         Navigator.pushNamed(context, RoutesName.withdrawScreen);
                                //       },
                                //       child: Column(
                                //         children: [
                                //           Image.asset(
                                //               Assets.iconsProWithdraw),
                                //           textWidget(
                                //               text: 'Withdraw',
                                //               fontWeight: FontWeight.w400,
                                //               fontSize: 18,
                                //               color: AppColors.secondaryTextColor),
                                //         ],
                                //       ),
                                //     ),
                                //
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(9, 20, 9, 5),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: tranUiList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              crossAxisCount: 2,
                              childAspectRatio: 4 / 2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: tranUiList[index].onTap,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: AppColors.secondaryappbar,
                                borderRadius: BorderRadiusDirectional.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  tranUiList[index].image,
                                  height: height*0.07
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textWidget(
                                        text: tranUiList[index].title,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                    color: AppColors.primaryTextColor),
                                    SizedBox(
                                      width: width * 0.3,
                                      child: textWidget(
                                          text: tranUiList[index].subtitle,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondaryTextColor,
                                          maxLines: 2,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient:AppColors.secondaryappbar,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: proInfoList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: proInfoList[index].onTap,
                              leading: Image.asset(proInfoList[index].image,height: height*0.055,),
                              title: textWidget(
                                  text: proInfoList[index].title,
                                  fontSize: 18,
                                color: AppColors.primaryTextColor
                                 ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: AppColors.secondaryTextColor,
                              ));
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: AppColors.secondaryappbar,
                        borderRadius: BorderRadiusDirectional.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 15),
                          child: textWidget(
                              text: 'Service center',
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            color: AppColors.primaryTextColor
                          ),
                        ),
                        GridView.builder(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: serviceList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    crossAxisCount: 3,
                                    childAspectRatio: 2.5 / 2),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: serviceList[index].onTap,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      serviceList[index].image,height: height*0.055,
                                    ),
                                    textWidget(
                                        text: serviceList[index].title,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.primaryTextColor
                                        ),
                                    textWidget(
                                        text: serviceList[index].subtitle ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.primaryTextColor
                                       ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  const EdgeInsets.fromLTRB(10, 30, 10, 50),
                  child: GestureDetector(
                    onTap: ()  {
                      showDialog(context: context, builder: (context)=>const Logout());
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(30),
                          border: Border.all(width: 0.5, color: AppColors.goldencolor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Assets.iconsLogOut),
                          textWidget(
                              text: '  Log out',
                              fontSize: 25,
                              color: AppColors.primaryTextColor)
                        ],
                      ),
                    ),
                  ),
                ),
                // const Text("Version 1.0.0")
              ],
            ),
          ),
        )
            :Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: const AssetImage(Assets.imagesNoDataAvailable),
                    height: height / 3,
                    width: width / 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget(text: "No data available"),
                    TextButton(onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('token');
                      Navigator.pushNamed(context, RoutesName.loginScreen);
                    }, child: const Text("Try Again"))
                  ],
                )
              ],
            )
    );
  }

///profile
  Future<void> fetchData() async {
    try {
      final userDataa = await  baseApiHelper.fetchProfileData();
      if (kDebugMode) {
        print(userDataa);
        print("userData");
      }
      if (userDataa != null) {
        Provider.of<ProfileProvider>(context, listen: false).setUser(userDataa);
      }
    } catch (error) {
      // Handle error here
    }
  }
}
class TranUiModel {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  TranUiModel({
    required this.image,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
}

class ServiceModel {
  final String image;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  ServiceModel({
    required this.image,
    required this.title,
    this.subtitle,
    this.onTap,
  });
}

class ProInfoModel {
  final String image;
  final String title;
  final VoidCallback? onTap;

  ProInfoModel({
    required this.image,
    required this.title,
    this.onTap,
  });
}
