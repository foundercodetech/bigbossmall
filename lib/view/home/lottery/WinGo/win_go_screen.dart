// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, camel_case_types, non_constant_identifier_names, use_build_context_synchronously, unrelated_type_equality_checks
import 'dart:async';
import 'dart:convert';
import 'package:bbm/main.dart';
import 'package:bbm/res/components/audio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/model/bettingHistory_Model.dart';
import 'package:bbm/model/user_model.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/api_urls.dart';
import 'package:bbm/res/app_constant.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/clipboard.dart';
import 'package:bbm/view/home/lottery/WinGo/commonbottomsheet.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/helper/api_helper.dart';
import 'package:bbm/res/provider/user_view_provider.dart';
import 'package:bbm/res/provider/wallet_provider.dart';
import 'package:bbm/view/bottom/bottom_nav_bar.dart';
import 'package:bbm/view/home/lottery/WinGo/dummy_grid.dart';
import 'package:bbm/view/home/lottery/WinGo/imagetoastWINGO.dart';
import 'package:bbm/view/randomlist.dart';
import 'package:bbm/view/wallet/deposit_screen.dart';
import 'package:bbm/view/wallet/withdraw_screen.dart';
import 'package:provider/provider.dart';


class WinGoScreen extends StatefulWidget {
  const WinGoScreen({super.key});

  @override
  _WinGoScreenState createState() => _WinGoScreenState();
}

class _WinGoScreenState extends State<WinGoScreen> with SingleTickerProviderStateMixin {
  late int selectedCatIndex;

  @override
  void initState() {
    Audio.audioPlayers;
    startCountdown();
    walletfetch();
    Partelyrecord(1);
    Partelyrecords(1);
    BettingHistory();
    super.initState();
    selectedCatIndex = 0;

  }

  int selectedContainerIndex = -1;

  List<BetNumbers> betNumbers = [
    BetNumbers(Assets.images0,Colors.red,Colors.purple,"0"),
    BetNumbers(Assets.images1,Colors.green,Colors.green,"1"),
    BetNumbers(Assets.images2,Colors.red,Colors.red,"2"),
    BetNumbers(Assets.images3,Colors.green,Colors.green,"3"),
    BetNumbers(Assets.images4,Colors.red,Colors.red,"4"),
    BetNumbers(Assets.images5,Colors.red,Colors.purple,"5"),
    BetNumbers(Assets.images6,Colors.red,Colors.red,"6"),
    BetNumbers(Assets.images7,Colors.green,Colors.green,"7"),
    BetNumbers(Assets.images8,Colors.red,Colors.red,"8"),
    BetNumbers(Assets.images9,Colors.green,Colors.green,"9"),
  ];

  List<Winlist> list = [
    Winlist(1,"Win Go", "1 Min",60),
    Winlist(2,"Win Go", "3 Min",180),
    Winlist(3,"Win Go", "5 Min",300),
    Winlist(4,"Win Go", "10 Min",600),
  ];

  int countdownSeconds = 60;
  int gameseconds=60;
  String gametitle='Wingo';
  String subtitle='1 Min';
  Timer? countdownTimer;


  Future<void> startCountdown() async {
    DateTime now = DateTime.now().toUtc();
    int minutes=now.minute;
    int minsec=minutes*60;
    int initialSeconds =60;
    if(gameseconds==60){
      initialSeconds= gameseconds - now.second;
    }else if(gameseconds==180){
      for(var i=0; i<20;i++){
        if(minsec>=180) {
          minsec = minsec - 180;
        }else{
          initialSeconds= gameseconds - minsec- now.second;
        }
        if (kDebugMode) {
          print(initialSeconds);
        }
      }
    }else if(gameseconds==300) {
      for (var i = 0; i < 12; i++) {
        if (minsec >= 300) {
          minsec = minsec - 300;
        }else{
          initialSeconds= gameseconds - minsec- now.second;
        }
      }
    }else if(gameseconds==600) {
      for (var i = 0; i < 6; i++) {
        if (minsec >= 600) {
          minsec = minsec - 600;
        }else{
          initialSeconds= gameseconds - minsec- now.second; // Calculate initial remaining seconds
        }
      }
    }
    setState(() {
      countdownSeconds = initialSeconds;
    });
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      gameconcept(countdownSeconds);
      updateUI(timer);
    });
  }

  void updateUI(Timer timer) {
    setState(() {
      if (countdownSeconds == 5) {

      } else if (countdownSeconds == 0) {
        countdownSeconds=gameseconds;
         walletfetch();
         Partelyrecord(1);
         Partelyrecords(1);
         BettingHistory();
         game_winPopup();
      }
      countdownSeconds = (countdownSeconds - 1) ;
    });
  }

  int ?responseStatuscode;


  @override
  void dispose() {
    countdownSeconds.toString();
    Audio.audioPlayers.stop();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final walletdetails = Provider.of<WalletProvider>(context).walletlist;
    
    return Scaffold(
        backgroundColor: AppColors.scaffolddark,
        resizeToAvoidBottomInset: true,
        appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  countdownTimer!.cancel();
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const BottomNavBar()));
                },
                child: Image.asset(Assets.iconsArrowBack)),
          ),
          title: Image.asset(
            Assets.imagesLogoredmeta,
            height: 50,
            color: AppColors.goldencolor,
          ),
          gradient: AppColors.secondaryappbar,
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: height / 2.8,
                decoration: const BoxDecoration(
                    gradient: AppColors.secondaryappbar,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                        gradient: AppColors.goldenGradientDir,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.currency_rupee_outlined, size: 20),
                            textWidget(
                                text: walletdetails==null?"":walletdetails.wallet.toString(),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: (){
                                  walletfetch();
                                },
                                child: Image.asset(Assets.iconsTotalBal, height: 30))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Assets.iconsRedWallet, height: 30,color: AppColors.browntextprimary,),
                            textWidget(
                                text: '  Wallet Balance',
                                fontWeight: FontWeight.w500,
                                fontSize: 18)
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppBtn(
                              titleColor: AppColors.goldencolorthree,
                              width: width * 0.4,
                              height: 38,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const WithdrawScreen()));
                              },
                              title: 'Withdraw',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              gradient: AppColors.containerBrownGradient,
                              hideBorder: true,
                            ),
                            AppBtn(
                              titleColor: AppColors.browntextprimary,
                              width: width * 0.4,
                              height: 38,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const DepositScreen()));
                              },
                              gradient: AppColors.transparentgradient,
                              title: 'Deposit',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              border: Border.all(color: AppColors.browntextprimary),


                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: height*0.07,
                    margin: const EdgeInsets.only(right: 10, left: 10),

                    decoration: BoxDecoration( color: AppColors.scaffolddark,
                    borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.volume_up,
                            color: AppColors.gradientFirstColor),
                        textWidget(
                          text: 'Welcome to ${AppConstants.appName}',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryTextColor
                        ),
                        AppBtn(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RandomList()));
                          },
                          height: 25,
                          width: width * 0.30,
                          title: '🔥 Details',
                          titleColor: AppColors.primaryTextColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: height * 0.18,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      gradient: AppColors.secondaryappbar,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(list.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCatIndex = index;
                              subtitle = list[index].subtitle;
                              gameseconds=list[index].time;
                              gameid=list[index].gameid;
                            });
                            countdownTimer!.cancel();
                            startCountdown();
                            offsetResult=0;
                            Partelyrecord(list[index].gameid);
                            Partelyrecords(list[index].gameid);
                          },
                          child: Container(
                            height: height * 0.28,
                            width: width * 0.23,
                            decoration: BoxDecoration(
                              gradient: selectedCatIndex == index
                                  ? AppColors.goldenGradientDir
                                  : const LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                selectedCatIndex == index ? Image.asset(Assets.imagesGoldentime, height: 70) : Image.asset(Assets.iconsTime, height: 70),
                                textWidget(
                                    text: list[index].title,
                                    color: selectedCatIndex == index ? AppColors.browntextprimary : Colors.grey,
                                    fontSize: 14),
                                textWidget(
                                    text: list[index].subtitle,
                                    color: selectedCatIndex == index ? AppColors.browntextprimary : Colors.grey,
                                    fontSize: 14),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.imagesBgCutRed),
                            fit: BoxFit.fill)),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                               // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HowtoplayScreen()));
                              },
                              child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                                  height: 26,
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: AppColors.browntextprimary)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.iconsHowtoplay,
                                        height: 16,
                                        color: AppColors.browntextprimary,
                                      ),
                                      const Text(
                                        ' How to Play',
                                        style: TextStyle(
                                            color: AppColors.browntextprimary),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(height: height*0.01,),
                            Text(
                              'Win Go $subtitle',
                              style: const TextStyle(color: AppColors.browntextprimary),
                            ),
                            // _listdata.isEmpty?Container():Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     children: List.generate(
                            //       5, (index) =>
                            //           Padding(
                            //             padding: const EdgeInsets.all(2.0),
                            //             child: Image(
                            //               image: AssetImage(betNumbers[int.parse(_listdata[index].number)].photo),
                            //               height: 25,
                            //             ),
                            //           ),
                            //     ))
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            const Text(
                              'Time Remaining',
                              style: TextStyle(
                                  color: AppColors.browntextprimary,
                                  fontWeight: FontWeight.bold),
                            ),

                            buildTime1(countdownSeconds),

                            Text(
                              period.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryTextColor),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  create==false?
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: ()async  {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(25))),
                                    context: (context),
                                    builder: (context) {
                                      return  CommonBottomSheet(colors: const [
                                        Colors.green, Colors.green
                                      ], colorName: "Green",
                                          predictionType: "10",
                                      gameid:gameid
                                      );
                                    });
                                await Future.delayed(const Duration(seconds: 5));
                                BettingHistory();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: width * 0.28,
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                child: textWidget(
                                    text: 'Green',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(25))),
                                    context: (context),
                                    builder: (context) {
                                      return  CommonBottomSheet(colors: const [
                                        Colors.purple, Colors.purple
                                      ],
                                          colorName: "Violet",
                                          predictionType: "20", gameid: gameid,);
                                    });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: width * 0.28,
                                decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                child: textWidget(
                                    text: 'Violet',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(25))),
                                    context: (context),
                                    builder: (context) {
                                      return  CommonBottomSheet(colors: const [
                                        Colors.red, Colors.red
                                      ],
                                          colorName: "Red",
                                          predictionType: "30", gameid: gameid,);
                                    });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: width * 0.28,
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: textWidget(
                                    text: 'Red',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 3),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            shrinkWrap: true,
                            itemCount: 10,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(25),
                                              topLeft: Radius.circular(25))),
                                      context: (context),
                                      builder: (context) {
                                        return CommonBottomSheet(
                                            colors: [
                                              betNumbers[index].colorone,
                                              betNumbers[index].colortwo
                                            ],
                                            colorName: betNumbers[index].number
                                                .toString(),
                                            predictionType: betNumbers[index]
                                                .number.toString(), gameid: gameid,);
                                      });
                                },
                                child: Image(
                                  image: AssetImage(
                                      betNumbers[index].photo.toString()),
                                  height: height / 15,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(25))),
                                    context: (context),
                                    builder: (context) {
                                      return  CommonBottomSheet(colors: const [
                                        Color(0xFF15CEA2 ), Color(0xFFB6FFE0)
                                      ], colorName: "Big", predictionType: "40", gameid: gameid,);
                                    });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: width * 0.35,
                                decoration: const BoxDecoration(
                                    gradient: AppColors.containerGreenGradient,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        bottomLeft: Radius.circular(50))),
                                child: textWidget(
                                    text: 'Big',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(25))),
                                    context: (context),
                                    builder: (context) {
                                      return  CommonBottomSheet(colors: const [
                                        Color(0xFF6da7f4), Color(0xFF6da7f4)
                                      ],
                                          colorName: "Small",
                                          predictionType: "50", gameid: gameid,);
                                    });
                                },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: width * 0.35,
                                decoration: const BoxDecoration(
                                    gradient: AppColors.btnBlueGradient,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50))),
                                child: textWidget(
                                    text: 'Small',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ):
                   Stack(
                    children: [
                      const DummyGrid(),
                      Container(
                        height: 250,
                        color: Colors.black26,
                        child: buildTime5sec(countdownSeconds),
                        ),

                    ],
                  ),
                  const SizedBox(height: 15),
                  WinGoResult()
                ],
              ),
            ],
          ),
        ));
  }
  bool create=false;
  int period=0;
  int gameid=1;
  final List<pertrecord> _listdata=[];
  Partelyrecord(int gameid) async {
    final response = await http.get(Uri.parse("${ApiUrl.colorresult}limit=0&offset=0&gameid=$gameid"));
    if (kDebugMode) {
      print(jsonDecode(response.body));
      print("${ApiUrl.colorresult}limit=5&offset=0&gameid=$gameid");
    }


    if (response.statusCode == 200) {
      _listdata.clear();
      final jsonData = json.decode(response.body)['data'];
      setState(() {
        period = int.parse(jsonData[0]['gamesno'].toString()) + 1;
      });
      for (var i = 0; i < jsonData.length; i++) {
        var period = jsonData[i]['gamesno'];
        var number = jsonData[i]['number'];
        _listdata.add(pertrecord(period,  number));
      }

      // return jsonData.map((item) => partlyrecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }


  int pageNumber = 1;
  int selectedTabIndex = 0;

  Widget WinGoResult() {
    setState(() {

    });
   

    return _listdataResult!= []?Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTabContainer('Game History', 0, width, Colors.red,),
            buildTabContainer('Chart', 1, width, Colors.red),
            buildTabContainer('My History', 2, width, Colors.red),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        selectedTabIndex == 0
            ? Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration:  const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width*0.3,
                    child: textWidget(
                        text: 'Period',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width*0.21,
                    child: textWidget(
                        text: 'Number',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width*0.21,
                    child: textWidget(
                        text: 'Big Small',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width*0.21,
                    child: textWidget(
                        text: 'Color',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor),
                  ),
                ],
              ),
            ),



            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _listdataResult.length,
              itemBuilder: (context, index) {

                List<Color> colors;

                if (_listdataResult[index].number == '0') {
                  colors = [
                    const Color(0xFFfd565c),
                    const Color(0xFFb659fe),
                  ];
                } else if (_listdataResult[index].number == '5') {
                  colors = [
                    const Color(0xFF40ad72),
                    const Color(0xFFb659fe),
                  ];
                } else {
                  int number = int.parse(_listdataResult[index].number.toString());
                  colors = number.isOdd
                      ? [
                    const Color(0xFF40ad72),
                    const Color(0xFF40ad72),
                  ]
                      : [
                    const Color(0xFFfd565c),
                    const Color(0xFFfd565c),
                  ];
                }

                Color getCircleAvatarColor(int number) {
                  return number.isOdd ? const Color(0xFF40ad72) : const Color(0xFFfd565c);
                }

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: height*0.06,
                          width: width * 0.3,
                          child: textWidget(
                            text: _listdataResult[index].period,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                            color: AppColors.primaryTextColor
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: width * 0.21,
                          height: height*0.06,
                          child: GradientTextview(
                            _listdataResult[index].number.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                            gradient: LinearGradient(
                          colors: colors,
                              stops: const [0.5, 0.5],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.mirror,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: width * 0.21,
                          height: height*0.06,
                          child: GradientTextview(
                            int.parse(_listdataResult[index].number.toString()) < 5
                                ? 'Small'
                                : 'Big',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w900),
                            gradient: LinearGradient(
                              colors: int.parse(_listdataResult[index].number.toString()) < 5
                                  ? [
                                const Color(0xFF6da7f4),
                                const Color(0xFF6da7f4)
                              ]
                                  : [
                                const Color(0xFF40ad72),
                                const Color(0xFF40ad72),
                              ],
                              stops: const [0.5, 0.5],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.mirror,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height*0.06,
                          width: width * 0.21,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: getCircleAvatarColor(
                                    int.parse(_listdata[index].number)),
                              ),
                              if (int.parse(_listdataResult[index].number.toString()) == 5 ||
                                  int.parse(_listdataResult[index].number.toString()) == 0)
                                const CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Color(0xFFb659fe),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(width: width, color: Colors.grey, height: 0.5),
                  ],
                );
              },
            ),
            SizedBox(height: height*0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: limitResult == 0
                      ? () {}
                      : () {
                    setState(() {
                      pageNumber--;
                      limitResult = limitResult - 10;
                      offsetResult=offsetResult-10;
                    });
                    Partelyrecords(gameid);
                    setState(() {});
                  },
                  child: Container(
                    height: height*0.06,
                    width: width*0.10,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldenGradientDir,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.navigate_before,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                textWidget(
                  text: '$pageNumber',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryTextColor,
                  maxLines: 1,
                ),
                const SizedBox(width: 16),
                GestureDetector(

                  onTap: (){
                    setState(() {
                      limitResult = limitResult + 10;
                      offsetResult=offsetResult+10;
                      pageNumber++;
                    });
                    Partelyrecords(gameid);
                    setState(() {});
                  },
                  child: Container(
                    height: height*0.06,
                    width: width*0.10,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldenGradientDir,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.navigate_next, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10)
          ],
        )
            :  selectedTabIndex == 1?  ChartScreen():
        responseStatuscode== 400 ?
        const Notfounddata(): items.isEmpty? const Center(child: CircularProgressIndicator()):
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                final int initialAmount = int.parse(items[index].amount.toString());
                const double percentage = 2.0;
                double finalAmount = initialAmount - (initialAmount * (percentage / 100));

                List<Color> colors;

                if (items[index].number == '0') {
                  colors = [
                    const Color(0xFFfd565c),
                    const Color(0xFFb659fe),
                  ];
                } else if (items[index].number == '5') {
                  colors = [
                    const Color(0xFF40ad72),
                    const Color(0xFFb659fe),
                  ];

                }  else if (items[index].number == '10') {
                  colors = [
                    const Color(0xFF40ad72),
                    const Color(0xFF40ad72),
                  ];
                }  else if (items[index].number == '20') {
                  colors = [

                    const Color(0xFFb659fe),
                    const Color(0xFFb659fe),
                  ];
                }  else if (items[index].number == '30') {
                  colors = [
                    const Color(0xFFfd565c),
                    const Color(0xFFfd565c),
                  ];
                }  else if (items[index].number == '40') {
                  colors = [
                    const Color(0xFF40ad72),
                    const Color(0xFF40ad72),

                  ];
                }  else if (items[index].number == '50') {
                  colors = [
                    //blue
                    const Color(0xFF6da7f4),
                    const Color(0xFF6da7f4)
                  ];
                } else {
                  int number = int.parse(items[index].number.toString());
                  colors = number.isOdd
                      ? [
                    const Color(0xFF40ad72),
                    const Color(0xFF40ad72),
                  ]
                      : [
                    const Color(0xFFfd565c),
                    const Color(0xFFfd565c),
                  ];
                }

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: AppColors.secondaryappbar,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 25,
                                    width: width * 0.40,
                                    decoration:  BoxDecoration(
                                       gradient: AppColors.goldenGradientDir,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: textWidget(
                                        text: 'Bet',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.browntextprimary),
                                  ),
                                ),
                                textWidget(text:  items[index].status=="0"?"Pending":items[index].status=="1"?"Win":"Loss",
                                    fontSize: width*0.05,
                                    fontWeight: FontWeight.w600,
                                    color: items[index].status=="0"?Colors.orange:items[index].status=="1"?Colors.green:Colors.red
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(text: "Balance",
                                    fontSize: width*0.03,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryTextColor
                                ),
                                textWidget(
                                     text: "₹$finalAmount",
                                  //  text: "₹${(double.parse(items[index].amount.toString())-0.02).toStringAsFixed(0)}",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryTextColor
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(text: "Bet Type",
                                    fontSize: width*0.03,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryTextColor
                                ),
                               int.parse(items[index].number.toString())<=9?
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: width*0.20,
                                  child: GradientTextview(
                                    items[index].number.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                    gradient: LinearGradient(
                                        colors: colors,
                                        stops: const [
                                          0.5,
                                          0.5,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        tileMode: TileMode.mirror),
                                  ),
                                ):GradientTextview(
                                 items[index].number.toString()=='10'?'Green':items[index].number.toString()=='20'?'Voilet':items[index].number.toString()=='30'?'Red':items[index].number.toString()=='40'?'Big':items[index].number.toString()=='50'?'Small':'',
                                 style: const TextStyle(
                                     fontSize: 15,
                                     fontWeight: FontWeight.w900),
                                 gradient: LinearGradient(
                                     colors: colors,
                                     stops: const [
                                       0.5,
                                       0.5,
                                     ],
                                     begin: Alignment.topCenter,
                                     end: Alignment.bottomCenter,
                                     tileMode: TileMode.mirror),
                               ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(text: "Type",
                                    fontSize: width*0.03,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryTextColor
                                ),
                                textWidget(text: items[index].gameid=="1"?"1 min":items[index].gameid=="2"?"3 min":items[index].gameid=="4"?"5 min":"10 min",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryTextColor
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(text: "Win Amount",
                                    fontSize: width*0.03,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryTextColor
                                ),
                                textWidget(text: items[index].win==null?'₹ 0.0':'₹ ${items[index].win}',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(text: "Time",
                                    fontSize: width*0.03,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryTextColor
                                ),
                                textWidget(
                                    text: DateFormat("dd-MMM-yyyy, hh:mm a").format(DateTime.parse(items[index].datetime.toString())),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryTextColor
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textWidget(text: "Order number",
                                    fontSize: width*0.03,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryTextColor
                                ),
                                Row(
                                  children: [
                                    textWidget(text: items[index].gamesno.toString(),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryTextColor
                                    ),
                                    SizedBox(width: width*0.01,),
                                    InkWell(
                                        onTap: (){
                                          copyToClipboard(items[index].gamesno.toString(),context);
                                        },
                                        child: Image.asset(Assets.iconsCopy,color: Colors.grey,height: height*0.027,)),

                                  ],
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );

              }),
        ),

      ],
    ):Container();
  }

  int limitResult=0;
  int offsetResult=0;


  game_winPopup() async {
    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();
    final response = await http.get(Uri.parse('${ApiUrl.game_win}$userid&gamesno=$period&gameid=$gameid'));

    var data = jsonDecode(response.body);
    if (kDebugMode) {
      print('${ApiUrl.game_win}$userid&gamesno=$period&gameid=$gameid');
      print('nbnbnbnbn');
      print(data);
      print('data');
    }
    if (data["status"] == "200") {
      var totalamount=data["totalamount"];
      var win=data["win"];
      var gamesno=data["gamesno"];
      var gameid=data["gameid"];
      var number=data["number"];



      win=="0"?ImageToastWingo.showloss(
          subtext: number,
          subtext1: totalamount,
          subtext2:win,
          subtext3:gamesno,
          subtext4:gameid,
          context: context
      ):
      ImageToastWingo.showwin(
          subtext: number,
          subtext1: totalamount,
          subtext2:win,
          subtext3:gamesno,
          subtext4:gameid,
          context: context
      );
    } else {
      setState(() {
        // loadingGreen = false;
      });
     // Utils.flushBarErrorMessage(data['msg'], context, Colors.black);
    }
  }

  void showPopup(BuildContext context,String totalamount,String win,String gamesno,String gameids) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          shape:  const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textWidget(
                text: "Win Go :",
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textWidget(
              text: gameids=='1'
                  ?'1 Min'
                  :gameids=='2'
                  ?'3 Min'
                  :gameids=='3'
                  ?'5 Min'
                  :'10 Min',
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
          ),
            ],
          ),
          content: SizedBox(
            height: 180,
            child: Column(
              children: [
                ListTile(
                 leading: textWidget(
                    text: "Game S.No.:",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: textWidget(
                    text: gamesno,
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ListTile(
                  leading: textWidget(
                    text: "Total Bet Amount:",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: textWidget(
                    text: totalamount,
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  leading: textWidget(
                    text: "Total Win Amount:",
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  trailing: textWidget(
                    text: win,
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );


  }

  ///chart page
  Widget ChartScreen() {
    setState(() {});
    
    return Column(
      children: [
        Column(
          children: List.generate(
            _listdataResult.length,
                (index) {
              return Container(
                height: 30,
                width: width*0.97,
                decoration: const BoxDecoration(gradient: AppColors.secondaryappbar),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textWidget(text: _listdataResult[index].period,color: Colors.white),
                    Row(
                        children: generateNumberWidgets(int.parse(_listdataResult[index].number))
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: int.parse(_listdataResult[index].number) < 5
                            ? AppColors.btnBlueGradient
                            : AppColors.btnYellowGradient,
                      ),
                      child: textWidget(
                        text:
                        int.parse(_listdataResult[index].number) < 5 ? 'S' : 'B',
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: height*0.02,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: limitResult == 0
                  ? () {}
                  : () {
                setState(() {
                  pageNumber--;
                  limitResult = limitResult - 10;
                  offsetResult=offsetResult-10;
                });
                Partelyrecords(gameid);
                setState(() {});
              },
              child: Container(
                height: height*0.06,
                width: width*0.10,
                decoration: BoxDecoration(
                  gradient: AppColors.goldenGradientDir,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            textWidget(
              text: '$pageNumber',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryTextColor,
              maxLines: 1,
            ),
            const SizedBox(width: 16),
            GestureDetector(

              onTap: (){
                setState(() {
                  limitResult = limitResult + 10;
                  offsetResult=offsetResult+10;
                  pageNumber++;
                });
                Partelyrecords(gameid);
                setState(() {});
              },
              child: Container(
                height: height*0.06,
                width: width*0.10,
                decoration: BoxDecoration(
                  gradient: AppColors.goldenGradientDir,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.navigate_next, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }


  // int selectedTabIndex=-5;

  Widget buildTabContainer(String label, int index, double width, Color selectedTextColor) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
        BettingHistory();
      },
      child: Container(
        height: 40,
        width: width / 3.3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: selectedTabIndex == index
                ? AppColors.goldenGradientDir
                : AppColors.secondaryappbar,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          label,
          style: TextStyle(
            fontSize: width / 24,
            fontWeight:
            selectedTabIndex == index ? FontWeight.bold : FontWeight.w500,
            color: selectedTabIndex == index ? AppColors.browntextprimary : Colors.grey,
          ),
        ),
      ),
    );
  }

  UserViewProvider userProvider = UserViewProvider();

  List<BettingHistoryModel> items = [];
  Future<void> BettingHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.betHistory+token),);
    if (kDebugMode) {
      print(ApiUrl.betHistory+token);
      print('betHistory+token');
    }


    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        items = responseData.map((item) => BettingHistoryModel.fromJson(item)).toList();
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  Future<void> walletfetch() async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final walletData = await baseApiHelper.fetchWalletData();
      if (kDebugMode) {
        print(walletData);
        print("wallet_data");
      }
      Provider.of<WalletProvider>(context, listen: false).setWalletList(walletData!);
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }


  gameconcept(int countdownSeconds) {
    if( countdownSeconds==6){
    setState(() {
     create=true;
    });
      if (kDebugMode) {
        print('5 sec left');
      }
    }else if(countdownSeconds==0){
      setState(() {
        create=false;
      });
      if (kDebugMode) {
        print('0 sec left');
      }

    }else{

    }
  }


  ///color result api

  final List<GameHistoryModel> _listdataResult=[];
  Partelyrecords(int gameid) async {
    // final gameid=widget.gameid;
    final response = await http.get(Uri.parse("${ApiUrl.colorresult}limit=$limitResult&gameid=$gameid&offset=$offsetResult",
    ));
    if (kDebugMode) {
      print('pankaj');
      print(jsonDecode(response.body));
      print("${ApiUrl.colorresult}limit=$limitResult&gameid=$gameid&offset=$offsetResult");
    }

    if (response.statusCode == 200) {
      _listdataResult.clear();
      final jsonData = json.decode(response.body)['data'];
      for (var i = 0; i < jsonData.length; i++) {
        var period = jsonData[i]['gamesno'];
        var number = jsonData[i]['number'];
        if (kDebugMode) {
          print(period);
        }
        _listdataResult.add(GameHistoryModel(period:period.toString(), number: number.toString()));
      }
      setState(() {});
      // return jsonData.map((item) => partlyrecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

Widget buildTime1(int time) {
  Duration myDuration =  Duration(seconds: time);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = strDigits(myDuration.inMinutes.remainder(11));
  final seconds = strDigits(myDuration.inSeconds.remainder(60));
  if (time == 5) {
    Audio.WingoTimerone();
  } else if(time>=1 && time <= 4){
    Audio.WingoTimertwo();
  }

  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    buildTimeCard(time: minutes[0].toString(), header: 'MINUTES'),
    const SizedBox(width: 3),
    buildTimeCard(time: minutes[1].toString(), header: 'MINUTES'),
    const SizedBox(width: 3),
    buildTimeCard(time: ':', header: 'MINUTES'),
    const SizedBox(width: 3),
    buildTimeCard(time: seconds[0].toString(), header: 'SECONDS'),
    const SizedBox(width: 3),
    buildTimeCard(time: seconds[1].toString(), header: 'SECONDS'),

  ]);
}
Widget buildTimeCard({required String time, required String header}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15),
          ),
        ),
      ],
    );



Widget buildTime5sec(int time) {
  Duration myDuration =  Duration(seconds: time);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  final seconds = strDigits(myDuration.inSeconds.remainder(60));

  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard5sec(time: seconds[0].toString(), header: 'SECONDS'),
        const SizedBox(width: 15),
        buildTimeCard5sec(time: seconds[1].toString(), header: 'SECONDS'),
  ]);
}
Widget buildTimeCard5sec({required String time, required String header}) =>

    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              gradient: AppColors.goldenGradientDir, borderRadius: BorderRadius.circular(10)),
          child:  Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.browntextprimary,
                fontSize: 100),
          ),)
      ],
    );


class TimeDigit extends StatelessWidget {
  final int value;
  const TimeDigit({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        value.toString(),
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}

class Winlist {
  int gameid;
  String title;
  String subtitle;
  int time;

  Winlist(this.gameid,this.title, this.subtitle,this.time);
}

class BetNumbers {

  String photo;
  final Color colorone;
  final Color colortwo;
  String number;
  BetNumbers(this.photo, this.colorone,this.colortwo,this.number);

}


class pertrecord {
  final String period;
  final String number;
  // final Color color;
  pertrecord(this.period,  this.number);
}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: height / 3,
          width: width / 2,
        ),
        SizedBox(height: height*0.07),
        const Text("Data not found",)
      ],
    );
  }

}



List<Widget> generateNumberWidgets(int parse) {
  return List.generate(10, (index) {
    List<Color> colors = [
      const Color(0xFFFFFFFF),
      const Color(0xFFFFFFFF),
    ];

    if (index == parse) {
      if (parse == 0) {
        colors = [
          const Color(0xFFfd565c),
          const Color(0xFFb659fe),
        ];
      } else if (parse == 5) {
        colors = [
          const Color(0xFF40ad72),
          const Color(0xFFb659fe),
        ];
      } else {
        colors = parse % 2 == 0
            ? [
          const Color(0xFFfd565c),
          const Color(0xFFfd565c),
        ]
            : [
          const Color(0xFF40ad72),
          const Color(0xFF40ad72),

        ];
      }
    }

    return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(),
        gradient: LinearGradient(
            colors: colors,
            stops: const [
              0.5,
              0.5,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.mirror),
      ),
      child: textWidget(
        text: '$index',
        fontWeight: FontWeight.w600,
        color: index == parse ? AppColors.primaryTextColor : Colors.black,
      ),
    );
  });
}




class GradientTextview extends StatelessWidget {
   const GradientTextview(
      this.text, {
        super.key,
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class GameHistoryModel {
  final String period;
  final String number;

  GameHistoryModel({
    required this.period,
    required this.number,
  });
}