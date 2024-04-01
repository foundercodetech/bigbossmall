// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/model/Mlm_Plan_model.dart';
import 'package:bbm/model/user_model.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/api_urls.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/clipboard.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/helper/api_helper.dart';
import 'package:bbm/res/provider/profile_provider.dart';
import 'package:bbm/res/provider/user_view_provider.dart';
import 'package:bbm/view/promotion/horizontal_scale.dart';
import 'package:bbm/view/promotion/level_plan.dart';
import 'package:bbm/view/promotion/level_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  void initState() {
    mLMPlan();
    bhagona();
    fetchData(context);
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  int? responseStatuscode;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ProfileProvider>(context).userData;

    
    return Scaffold(
        backgroundColor: AppColors.scaffolddark,
        appBar: GradientAppBar(
            title: textWidget(
                text: 'Agency',
                fontSize: 25,
                color: AppColors.primaryTextColor),
            gradient: AppColors.primaryappbargrey),
        body: userData != null
            ? ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.01),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                        child: Container(
                          height: height*0.28,
                          decoration: BoxDecoration(
                            gradient: AppColors.secondaryappbar,
                            borderRadius: BorderRadiusDirectional.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(Assets.iconsInvitionCode,color: AppColors.goldencolortwo,height: height*0.06,),
                                    SizedBox(width: width * 0.02),
                                    textWidget(
                                      text: 'Invitation code',
                                      fontSize: width * 0.06,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.primaryTextColor
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.01),
                                Container(
                                  height: height * 0.07,
                                  width: width,
                                  decoration: BoxDecoration(
                                     color: AppColors.gradientSecondColor.withOpacity(0.05),
                                      borderRadius: BorderRadiusDirectional.circular(30)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30),
                                        child: textWidget(
                                            text: userData.referralCode.toString(),
                                            fontSize: width*0.055,
                                            color: AppColors.primaryTextColor),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          copyToClipboard(userData.referralCode.toString(),context);
                                        },
                                        child: Container(
                                          height: 55,
                                          width: 120,
                                          decoration:  const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesCopyBg), fit: BoxFit.fill)),
                                          child: Image.asset(Assets.iconsCopy, height: 15,color: AppColors.goldencolorthree,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                kIsWeb==true?
                                AppBtn(
                                  gradient: AppColors.primaryGradient,
                                  hideBorder: true,
                                  title: 'INVITATION LINK',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  onTap: () async {
                                    String referralUrl = 'https://web.bigbossmall.live?id=${userData.referralCode}';
                                    Share.share('Its my referral Code : *${userData.referralCode}* link to join: $referralUrl  ,'
                                        ' Download Now :https://bigbossmall.live/bigbossmall.apk',
                                        subject: 'Join Now !!');
                                  },
                                ):
                                AppBtn(
                                  titleColor: AppColors.browntextprimary,
                                  gradient: AppColors.goldenGradientDir,
                                  hideBorder: true,
                                  title: 'INVITATION LINK',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  onTap: () async {
                                    await FlutterShare.share(
                                        title: 'Referral Code :',
                                        text: 'Join Now & Get Exiting Prizes. here is my Referral Code : ${userData.referralCode}',
                                        linkUrl: "https://bigbossmall.live",
                                        chooserTitle: 'Referral Code : ');
                                  },
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 20,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Container(
                                height: height * 0.3,
                                width: width * 0.95,
                                decoration: BoxDecoration(
                                    gradient: AppColors.goldenGradientDir,
                                    image: const DecorationImage(image: AssetImage(Assets.imagesContainerBg),fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          alignment: Alignment.center,
                                          height: height / 15,
                                          width: width / 5,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryContColor,
                                              borderRadius: BorderRadius.circular(10)),
                                          child: textWidget(
                                            text: users,
                                            fontSize: width * 0.045,
                                          ),
                                        ),
                                        textWidget(
                                          text: 'Total \n User',
                                          fontSize: width * 0.04,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          alignment: Alignment.center,
                                          height: height / 15,
                                          width: width / 5,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryContColor,
                                              borderRadius: BorderRadius.circular(10)),
                                          child: textWidget(
                                            text: commission,
                                            fontSize: width * 0.045,
                                          ),
                                        ),
                                        textWidget(
                                          text: '       Total\nCommission',
                                          fontSize: width * 0.04,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          alignment: Alignment.center,
                                          height: height / 15,
                                          width: width / 5,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryContColor,
                                              borderRadius: BorderRadius.circular(10)),
                                          child: textWidget(
                                            text: double.parse(bonus.toString()).toStringAsFixed(2),
                                            fontSize: width * 0.045,
                                          ),
                                        ),
                                        textWidget(
                                          text: ' Refer\nBonus',
                                          fontSize: width * 0.04,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(height: height * 0.20),
                              FutureBuilder<List<Mlm>>(
                                  future: bhagona(),
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!.length,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                      child: Container(
                                                        height: 55,
                                                        decoration: const BoxDecoration(color: AppColors.primaryContColor),
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 2, 5, 5),
                                                          child: InkWell(
                                                            onTap: () {
                                                              userdata == null ? () :
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => LevelScreen(name: snapshot.data![index].name, data: userdata)));
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    textWidget(
                                                                      text: snapshot.data![index].name.toString(),
                                                                      fontWeight: FontWeight.w700,
                                                                      fontSize: 15,
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: [
                                                                        textWidget(
                                                                          text: snapshot.data![index].count.toString(),
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 13,
                                                                        ),
                                                                        textWidget(
                                                                          text: 'User',
                                                                          fontWeight: FontWeight.w700,
                                                                          fontSize: 13,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: [
                                                                        textWidget(
                                                                          text: snapshot.data![index].commission.toString(),
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 13,
                                                                        ),
                                                                        textWidget(
                                                                          text: 'Commission',
                                                                          fontWeight: FontWeight.w700,
                                                                          fontSize: 13,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Icon(
                                                                      Icons.arrow_forward_ios,
                                                                      color: AppColors.iconColor,
                                                                      size: 20,
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (index < snapshot.data!.length - 1)
                                                                  const Divider(),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          )
                                        : Container();
                                  }),
                              const SizedBox(height: 10),
                              SizedBox(
                                  height: height / 5.6,
                                  child: HorizontalScale(count: count)),
                              const SizedBox(height: 5),
                              responseStatuscode == 400 ? const Notfounddata() : planItems.isEmpty ? const Center(child: CircularProgressIndicator()) :
                              GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 8,
                                            childAspectRatio: 1,
                                          ),
                                          itemCount: planItems.length > 4 ? 4 : planItems.length,
                                        itemBuilder: (BuildContext context, int index) {
                                            return Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                child: Container(
                                                    padding: const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      gradient: AppColors.secondaryappbar,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: index != 3
                                                        ? Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                                textWidget(
                                                                    text: planItems[index].name.toString(),
                                                                    fontSize: 13,
                                                                    fontWeight: FontWeight.bold,
                                                                  color:AppColors.primaryTextColor
                                                                ),
                                                                textWidget(
                                                                    text: "${planItems[index].commission}%",
                                                                    fontSize: 13,
                                                                    color:AppColors.primaryTextColor,

                                                                    fontWeight: FontWeight.bold),
                                                                textWidget(
                                                                    text: "Commision",
                                                                    fontSize: 13,
                                                                    color:AppColors.primaryTextColor,
                                                                    fontWeight: FontWeight.bold)
                                                              ])
                                                        : InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context, MaterialPageRoute(builder: (context) => const LevelPlan()));
                                                            },
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                const Icon(Icons.arrow_forward_ios),
                                                                textWidget(
                                                                    text: "${planItems.length - 3}+ more",
                                                                    fontWeight: FontWeight.bold,
                                                                    color:AppColors.primaryTextColor,

                                                                    fontSize: width * 0.041),
                                                              ],
                                                            ))));
                                          },
                                        ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Container());
  }

  Future<void> fetchData(context) async {
    try {
      final userDataa = await baseApiHelper.fetchProfileData();
      if (kDebugMode) {
        print(userDataa);
        print("userData");
      }
      if (userDataa != null) {
        Provider.of<ProfileProvider>(context, listen: false).setUser(userDataa);
      }
    } catch (error) {
      //
    }
  }

  UserViewProvider userProvider = UserViewProvider();

  ///mlm plan
  List<MlmPlanModel> planItems = [];

  Future<void> mLMPlan() async {
    final response = await http.get(Uri.parse(ApiUrl.planMlm));
    if (kDebugMode) {
      print(ApiUrl.planMlm);
      print('planMlm');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        planItems =
            responseData.map((item) => MlmPlanModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });
    } else if (response.statusCode == 400) {
      if (kDebugMode) {
        print('Data not found');
      }
    } else {
      setState(() {
        planItems = [];
      });
      throw Exception('Failed to load data');
    }
  }

  int count = 0;
  var userdata = {};
  String commission = '0';
  String bonus = '0';
  String users = '0';

  Future<List<Mlm>> bhagona() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(
      Uri.parse("${ApiUrl.MLM_PLAN}$token"),
    );
    var jsond = json.decode(response.body)["levelwisecommission"];
    setState(() {
      userdata = json.decode(response.body)["userdata"];
      users = json.decode(response.body)["totaluser"].toString();
      commission = json.decode(response.body)["totalcommission"].toString();
      count = userdata['Level 1'].length;
      bonus = json.decode(response.body)["bonus"].toString();
    });

    List<Mlm> allround = [];
    for (var o in jsond) {
      Mlm al = Mlm(
        o["count"],
        o["name"],
        o["commission"].toStringAsFixed(2),
        o["bonus"],
      );
      allround.add(al);
    }
    return allround;
  }
}

class Mlm {
  int? count;
  String? name;
  String? commission;
  String? bonus;
  Mlm(this.count, this.name, this.commission, this.bonus);
}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: height / 3,
          width: width / 2,
        ),
        const Text(
          "Data not found",
        )
      ],
    );
  }
}

//
// class LevelModel {
//   final String level;
//   final String user;
//   final String commission;
//
//   LevelModel({
//     required this.level,
//     required this.user,
//     required this.commission,
//   });
// }

//
// background: -webkit-linear-gradient(top,#ffbd40 0%,#ff7f3d 100%);
// background: linear-gradient(180deg,#ffbd40 0%,#ff7f3d 100%);
// box-shadow: 0 0.05333rem #f24b16, 0 0.02667rem #ffec75 inset;
