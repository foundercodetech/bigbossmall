// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously, camel_case_types
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bbm/main.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/model/bettingHistory_Model.dart';
import 'package:bbm/model/user_model.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/api_urls.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/clipboard.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/helper/api_helper.dart';
import 'package:bbm/res/provider/user_view_provider.dart';
import 'package:bbm/res/provider/wallet_provider.dart';
import 'package:bbm/view/bottom/bottom_nav_bar.dart';
import 'package:bbm/view/home/lottery/5d/slotmachine.dart';
import 'package:bbm/view/home/lottery/K3/dummygridK3.dart';
import 'package:bbm/view/home/lottery/trx/image_toast_trx.dart';
import 'package:bbm/view/wallet/deposit_screen.dart';
import 'package:bbm/view/wallet/withdraw_screen.dart';
import 'package:provider/provider.dart';


class Big{
  String type;
  String amount;
  final Color color;
  Big(this.type,this.amount,this.color);
}



class Digitselect{
  String digit;
  String setdigit;
  Digitselect(this.digit,this.setdigit);
}

class ScreenK3 extends StatefulWidget {
  const ScreenK3({super.key});

  @override
  _ScreenK3State createState() => _ScreenK3State();
}

class _ScreenK3State extends State<ScreenK3> with SingleTickerProviderStateMixin {
  late int selectedCatIndex;
   TabController ?tabController;

  @override
  void initState() {
    startCountdown();
    walletfetch();
    Partelyrecord(1);
    GamehistoryTRX(1);
    BettingHistory();
    super.initState();
    selectedCatIndex = 0;
    tabController = TabController(length: 4, vsync: this);
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
    Winlist(1,"K3 Lotre", "1 Min",60),
    Winlist(2,"K3 Lotre", "3 Min",180),
    Winlist(3,"K3 Lotre", "5 Min",300),
    Winlist(4,"K3 Lotre", "10 Min",600),
  ];


  List<TotalWidget> totalitems = [
    TotalWidget(Assets.imagesRedplainK3, "3", "207.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "4", "69.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "5", "34.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "6", "20.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "7", "13.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "8", "207.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "9", "07.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "10", "27.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "11", "207.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "12", "7.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "13", "27.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "14", "7.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "15", "207.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "16", "207.36X",Colors.green),
    TotalWidget(Assets.imagesRedplainK3, "17", "207.36X",Colors.red),
    TotalWidget(Assets.imagesGreenplainK3, "18", "207.36X",Colors.green),
  ];

  int countdownSeconds = 60;
  int gameseconds=60;
  String gametitle='K3 Lotre';
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
          initialSeconds= gameseconds - minsec- now.second; // Calculate initial remaining seconds
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
        GamehistoryTRX(1);
        BettingHistory();
        game_winPopup();
        onStart();
      }
      else if(countdownSeconds == 59){
        onButtonTap();
      }
      countdownSeconds = (countdownSeconds - 1) ;
    });
  }

  int ?responseStatuscode;

  late SlotMachineController _controller;

  void onButtonTap() {
    for (int i = 0; i < 5; i++) {
      _controller.stop(reelIndex: i);
    }
  }
  void onStart() {
    final index = Random().nextInt(20);
    _controller.start(hitRollItemIndex: index < 5 ? index : null);
  }

  @override
  void dispose() {
    countdownSeconds.toString();
    tabController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  List<Big> SizeTypelist = [
    Big("Big", "1.98",Colors.yellow),
    Big("Small", "1.98",Colors.blue),
    Big("Even", "1.98",Colors.green),
    Big("Odd", "1.98",Colors.red),
  ];

  List<int> sametwoitemone = [11,22,33,44,55,66];
  List<int> sametwoitemtwo = [11,22,33,44,55,66];
  List<int> sametwoitemthree = [1,2,3,4,5,6];
  List<int> samethreeitemone = [111,222,333,444,555,666];
  List<int> differentitemone = [1,2,3,4,5,6];
  int ?showalphabet = 0;


  String ?selectedAlphabet;
  String ?selectedSizeType;
  String ?selectedNumberType;

  @override
  Widget build(BuildContext context) {

    final walletdetails = Provider.of<WalletProvider>(context).walletlist;
    
    return Scaffold(
        backgroundColor: AppColors.scaffolddark,
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
                            const Icon(Icons.currency_rupee_outlined, size: 20,color: AppColors.browntextprimary),
                            textWidget(
                                text: walletdetails==null?"":walletdetails.wallet.toString(),
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.browntextprimary
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(Assets.iconsTotalBal, height: 30)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Assets.iconsRedWallet, height: 30),
                            textWidget(
                              text: '  Wallet Balance',
                              fontWeight: FontWeight.w500,
                              fontSize: 18,)
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
                    height: 50,
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.scaffolddark
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: width*0.02,),
                        const Icon(Icons.volume_up, color: AppColors.goldencolorthree),
                        _rotate()

                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
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
                            GamehistoryTRX(list[index].gameid);
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
                      width: width*0.93,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: AppColors.secondaryappbar,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
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
                                                color: AppColors.goldencolortwo)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              Assets.iconsHowtoplay,
                                              height: 16,
                                              color: AppColors.goldencolortwo,
                                            ),
                                            const Text(
                                              ' How to Play',
                                              style: TextStyle(
                                                  color: AppColors.goldencolortwo),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Text(
                                    'K3 Lotre $subtitle',
                                    style:  const TextStyle(color: AppColors.goldencolortwo),
                                  ),
                                  Text(
                                    period.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.goldencolortwo),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Draw Time',
                                    style: TextStyle(
                                        color: AppColors.goldencolortwo,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  buildTime1(countdownSeconds),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: height*0.02,),
                          Container(
                            decoration: const BoxDecoration(gradient: AppColors.secondaryappbar),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(width: 10,color: const Color(0xffc4933f))
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 4,color: Colors.brown)
                                    ),
                                    child: SlotMachine(
                                      rollItems: [
                                        RollItem(index: 0, child: Image.asset(Assets.imagesNum1)),
                                        RollItem(index: 1, child: Image.asset(Assets.imagesNum2)),
                                        RollItem(index: 2, child: Image.asset(Assets.imagesNum3)),
                                        RollItem(index: 3, child: Image.asset(Assets.imagesNum4)),
                                        RollItem(index: 4, child: Image.asset(Assets.imagesNum5)),
                                        RollItem(index: 5, child: Image.asset(Assets.imagesNum6)),
                                      ],
                                      onCreated: (controller) {
                                        _controller = controller;
                                      },
                                      onFinished: (resultIndexes) {
                                        if (kDebugMode) {
                                          print('Result: $resultIndexes');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height*0.02,),

                          create==false?
                          Column(
                            children: [
                              DefaultTabController(
                                length: 4,
                                child: TabBar(
                                  indicator: BoxDecoration(color: Colors.grey,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                                  controller: tabController,
                                  tabs: [
                                    Tab(
                                        child: textWidget(
                                            text: "Total",
                                            textAlign: TextAlign.center,
                                        fontSize: width*0.03,
                                        fontWeight: FontWeight.bold,
                                          color: Colors.white
                                        ),
                                    ),
                                    Tab(
                                      child: textWidget(text: "2 same",
                                          textAlign: TextAlign.center,
                                          fontSize: width*0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Tab(
                                      child: textWidget(
                                          text: "3 same",
                                          textAlign: TextAlign.center,
                                          fontSize: width*0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Tab(
                                      child: textWidget(
                                          text: "Different",
                                          textAlign: TextAlign.center,
                                          fontSize: width*0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],),),
                              Container(
                                height: height*0.58,
                                child: TabBarView(
                                  physics: const BouncingScrollPhysics(),
                                  controller: tabController,
                                  children:  [
                                    Total(),
                                    Same2(),
                                    Same3(),
                                    Different()
                                  ],
                                ),
                              ),
                            ],
                          ) :
                          Stack(
                            children: [
                              const DummygridK3(),
                              Container(
                                height: 250,
                                color: Colors.black26,
                                child: buildTime5sec(countdownSeconds),
                              ),
                            ],
                          ),




                        ],
                      )
                  ),
                  const SizedBox(height: 15),
                  Result5d()
                ],
              ),
            ],
          ),
        ));
  }


  /// how to play ke pass wala api
  bool create=false;
  int period=0;
  int gameid=1;
  final List<pertrecord> _listdata=[];
  Partelyrecord(int gameid) async {
    if (kDebugMode) {
      print("f6td");
    }
    final response = await http.get(Uri.parse("${ApiUrl.colorresultTRX}limit=1&offset=0&gameid=$gameid"));
    if (kDebugMode) {
      print(jsonDecode(response.body));
      print("vygciydt");
      print("${ApiUrl.colorresultTRX}limit=1&offset=1&gameid=$gameid");
    }
    if (response.statusCode == 200) {
      _listdata.clear();
      final jsonData = json.decode(response.body)['data'];
      // setState(() {
      //   period = int.parse(jsonData[0]['gamesno'].toString()) + 1;
      // });
      for (var i = 0; i < jsonData.length; i++) {
        var period = jsonData[i]['gamesno'];
        var number = jsonData[i]['number'];
        var hashh = jsonData[i]['hash'];

        _listdata.add(pertrecord(period,number,hashh));

      }
      // return jsonData.map((item) => partlyrecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  ///condition for obscure text
  String obscureCenterDigits(String input) {
    if (input.length < 4) {
      return input; // If the input is shorter than 4 characters, return the original string
    }

    // Get the length of the input string
    int length = input.length;

    // Calculate the start index for obscuring
    int startIndex = (length ~/ 2) - 1;

    // Calculate the end index for obscuring
    int endIndex = (length ~/ 2) + 1;

    // Create a List of characters from the input string
    List<String> chars = input.split('');

    // Replace characters in the specified range with asterisks
    for (int i = startIndex; i <= endIndex; i++) {
      chars[i] = '*';
    }

    // Join the List of characters back into a single string
    return chars.join('');
  }


  int pageNumber = 1;
  int selectedTabIndex = 0;

  Widget Result5d() {
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
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width*0.25,
                    child: textWidget(
                        text: 'Period',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width*0.17,
                    child: textWidget(
                        text: 'Result',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width*0.21,
                    child: textWidget(
                        text: 'Total',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor),
                  ),

                ],
              ),
            ),



            Container(
              width: width*0.94,
              decoration: const BoxDecoration(gradient: AppColors.secondaryappbar),
              child: ListView.builder(
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

                  Color _getCircleAvatarColor(int number) {
                    return number.isOdd ? const Color(0xFF40ad72) : const Color(0xFFfd565c);
                  }

                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: height*0.09,
                            alignment: Alignment.center,
                            width: width * 0.3,
                            child: textWidget(
                              text: _listdataResult[index].period,
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(width: width*0.05,),
                          Container(
                            height: height*0.09,
                            alignment: Alignment.center,
                            width: width*0.30,
                            child: textWidget(
                              text: _listdataResult[index].hash.toString(),
                              fontSize: 12,
                              color: AppColors.primaryTextColor,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(width: width*0.14,),

                          Container(
                              height: height*0.055,
                              width: width*0.065,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: colors,
                                  stops: const [0.5, 0.5],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  tileMode: TileMode.mirror,
                                ),
                              ),
                              child: Center(
                                child: textWidget(text: _listdataResult[index].number.toString(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryTextColor
                                ),
                              )
                          ),

                        ],
                      ),
                      Container(width: width, color: AppColors.primaryContColor, height: 0.5),
                    ],
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
                    GamehistoryTRX(gameid);
                    setState(() {});
                  },
                  child: Container(
                    height: height / 10,
                    width: width / 10,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldenGradientDir,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                        Icons.navigate_before,
                        color:AppColors.browntextprimary
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
                    GamehistoryTRX(gameid);
                    setState(() {});
                  },
                  child: Container(
                    height: height / 10,
                    width: width / 10,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldenGradientDir,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.navigate_next, color:AppColors.browntextprimary),
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
              itemBuilder: (context , index){
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
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
                                        color:  Colors.red,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: textWidget(
                                        text: 'Bet',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                  ),
                                ),
                                textWidget(text:  items[index].status=="0"?"Pending":items[index].status=="1"?"Win":"Loss",
                                    fontSize: width*0.05,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.methodblue

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
                                textWidget(text: "₹${items[index].amount}",
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

  int limitResult=10;
  int offsetResult=0;


  game_winPopup() async {
    UserModel user = await userProvider.getUser();
    String userid = user.id.toString();
    final response = await http.get(Uri.parse('${ApiUrl.game_win}$userid&gamesno=$period&gameid=$gameid'));

    var data = jsonDecode(response.body);
    if (kDebugMode) {
      print('${ApiUrl.game_win}$userid&gamesno=$period&gameid=$gameid');
      print('nbnbnbnbn');
    }
    if (data["status"] == "200") {
      var totalamount=data["totalamount"];
      var win=data["win"];
      var gamesno=data["gamesno"];
      var gameid=data["gameid"];
      if (kDebugMode) {
        print('rrrrrrrr');
      }
      // showPopup(context,totalamount,win,gamesno,gameid);
      // Future.delayed(const Duration(seconds: 5), () {
      //   Navigator.of(context).pop();
      // });
      ImageToastTRX.showwin(text: gamesno, subtext: totalamount, subtext1: win, subtext2:gameid,context: context,);

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
          children:
          List.generate(
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
                GamehistoryTRX(gameid);
                setState(() {});
              },
              child: Container(
                height: height / 10,
                width: width / 10,
                decoration: BoxDecoration(
                  gradient: AppColors.goldenGradientDir,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.navigate_before,
                  color: AppColors.browntextprimary,
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
                GamehistoryTRX(gameid);
                setState(() {});
              },
              child: Container(
                height: height / 10,
                width: width / 10,
                decoration: BoxDecoration(
                  gradient: AppColors.goldenGradientDir,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.navigate_next, color: AppColors.browntextprimary,),
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
      print('0 sec left');
    }else{

    }
  }

  ///tokentrx api (how to work jaha hai )
  final List<GameHistoryModel> _listdataResult=[];
  GamehistoryTRX(int gameid) async {
    // final gameid=widget.gameid;
    final response = await http.get(Uri.parse("${ApiUrl.colorresultTRX}limit=$limitResult&gameid=$gameid&offset=$offsetResult",
    ));
    if (kDebugMode) {
      print('pankaj');
      print("${ApiUrl.colorresultTRX}limit=$limitResult&gameid=$gameid&offset=$offsetResult");
      print(jsonDecode(response.body));
    }

    if (response.statusCode == 200) {
      _listdataResult.clear();
      if (kDebugMode) {
        print('hhhghgjt');
      }
      final jsonData = json.decode(response.body)['data'];
      for (var i = 0; i < jsonData.length; i++) {
        var period = jsonData[i]['gamesno'];
        var number = jsonData[i]['number'];
        var hash = jsonData[i]['hash'];
        var datetime = jsonData[i]['datetime'];
        var block = jsonData[i]['block'];
        if (kDebugMode) {
          print(period);
        }
        _listdataResult.add(GameHistoryModel(period:period.toString(), number: number.toString(), hash: hash, datetime: datetime,block: block));
      }
      setState(() {});
      // return jsonData.map((item) => partlyrecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }


  Widget Total(){

    return Column(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8.0,
          ),
          shrinkWrap: true,
          itemCount: totalitems.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  height:height*0.08,
                  width: width*0.15,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(totalitems[index].image),fit: BoxFit.fill)
                  ),
                  child: Center(
                    child: textWidget(text: totalitems[index].title,
                        fontSize: width*0.05,
                      fontWeight: FontWeight.bold,
                      color: totalitems[index].color
                    ),
                  ),
                ),
                textWidget(text: totalitems[index].Subtitle,
                fontSize: width*0.034,
                color: Colors.grey)
              ],
            );
          },
        ),
        SizedBox(height: height*0.02,),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              SizeTypelist.length,
                  (index) =>
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 40,
                      width: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: SizeTypelist[index].color,
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(text: SizeTypelist[index].type,fontSize: width*0.04,color: Colors.white),
                          textWidget(text: SizeTypelist[index].amount,fontSize: width*0.04,color: Colors.white),
                        ],
                      ),
                    ),
                  ),
            )
        ),
      ],
    );

  }

  Widget Same2(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height*0.03,),
        textWidget(text: "2 matching numbers:odds(13.83)",
            color: Colors.white,
            fontSize: width*0.04),
        SizedBox(height: height*0.03,),

        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              sametwoitemone.length,
                  (index) =>
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 40,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff784a9c),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: textWidget(text: sametwoitemone[index].toString(),fontSize: width*0.04,color: Colors.white),
                    ),
                  ),
            )
        ),
        SizedBox(height: height*0.03,),
        textWidget(
            text: "A pair of unique numbers: odds(69.12)",
        color: Colors.white,
          fontSize: width*0.04
        ),
        SizedBox(height: height*0.03,),

        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              sametwoitemtwo.length,
                  (index) =>
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 40,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xfffb9494),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: textWidget(text: sametwoitemtwo[index].toString(),fontSize: width*0.04,color: Colors.white),
                    ),
                  ),
            )
        ),
        SizedBox(height: height*0.02),

        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              sametwoitemthree.length,
                  (index) =>
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 40,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff3d7456),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: textWidget(text: sametwoitemthree[index].toString(),fontSize: width*0.04,color: Colors.white),
                    ),
                  ),
            )
        ),


      ],
    );
  }

  Widget Same3(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height*0.03,),
        textWidget(text: "3 of the same number:odds(207.36)",
            color: Colors.white,
            fontSize: width*0.04),
        SizedBox(height: height*0.03,),

        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              samethreeitemone.length,
                  (index) =>
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 40,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff784a9c),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: textWidget(text: samethreeitemone[index].toString(),fontSize: width*0.04,color: Colors.white),
                    ),
                  ),
            )
        ),
        SizedBox(height: height*0.03,),
        textWidget(
            text: "Any 3 of the same numbers: odds(34.56)",
            color: Colors.white,
            fontSize: width*0.04
        ),
        SizedBox(height: height*0.03,),
        Container(
          height: height*0.05,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:  Color(0xfffb9494)
          ),
          child: Center(
            child: textWidget(text: "Any 3 of the same number: odds ",
                fontSize: width*0.04,color: Colors.white),
          ),
        )


      ],
    );
  }

  Widget Different(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height*0.03,),
        textWidget(text: "3 different number:odds(207.36)",
            color: Colors.white,
            fontSize: width*0.04),
        SizedBox(height: height*0.03,),

        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              differentitemone.length,
                  (index) =>
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 40,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff784a9c),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: textWidget(text: differentitemone[index].toString(),fontSize: width*0.04,color: Colors.white),
                    ),
                  ),
            )
        ),
        SizedBox(height: height*0.03,),
        textWidget(
            text: " 3 continuous numbers: odds(34.56)",
            color: Colors.white,
            fontSize: width*0.04
        ),
        SizedBox(height: height*0.03,),
        Container(
          height: height*0.05,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:  Color(0xfffb9494)
          ),
          child: Center(
            child: textWidget(text: " 3 continuous numbers ",
                fontSize: width*0.04,color: Colors.white),
          ),
        ),
        SizedBox(height: height*0.03,),
        textWidget(
            text: " 2 different numbers: odds(34.56)",
            color: Colors.white,
            fontSize: width*0.04
        ),
        SizedBox(height: height*0.03,),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              differentitemone.length,
                  (index) =>
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 40,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff784a9c),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child: textWidget(text: differentitemone[index].toString(),fontSize: width*0.04,color: Colors.white),
                    ),
                  ),
            )
        ),


      ],
    );
  }




}




Widget buildTime1(int time) {
  Duration myDuration =  Duration(seconds: time);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = strDigits(myDuration.inMinutes.remainder(11));
  final seconds = strDigits(myDuration.inSeconds.remainder(60));
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    buildTimeCard(time: minutes[0].toString(), header: 'MINUTES'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: minutes[1].toString(), header: 'MINUTES'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: ':', header: 'MINUTES'),
    const SizedBox(
      width: 3,
    ),
    buildTimeCard(time: seconds[0].toString(), header: 'SECONDS'),
    const SizedBox(
      width: 3,
    ),
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
              color: AppColors.scaffolddark, borderRadius: BorderRadius.circular(10)),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.goldencolortwo,
                fontSize: 15),
          ),
        ),
      ],
    );

Widget buildTime5sec(int time) {
  Duration myDuration =  Duration(seconds: time);
  String strDigits(int n) => n.toString().padLeft(2, '0');
  final seconds = strDigits(myDuration.inSeconds.remainder(60));
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [

    buildTimeCard5sec(time: seconds[0].toString(), header: 'SECONDS'),
    const SizedBox(
      width: 15,
    ),
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

class Tokennumber {

  String photo;
  final Color colorone;
  final Color colortwo;
  String number;
  Tokennumber(this.photo, this.colorone,this.colortwo,this.number);

}

///howtoplay ke pass wala
class pertrecord {
  final String period;
  final String number;
  final String hashh;
  // final String datetime;
  // final String block;
  // final Color color;
  pertrecord(this.period,
      this.number,
      this.hashh,
      // this.datetime,
      // this.block
      );
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


///gamehistory model
class GameHistoryModel {
  final String period;
  final String number;
  final String hash;
  final String datetime;
  final String block;


  GameHistoryModel({
    required this.period,
    required this.number,
    required this.hash,
    required this.datetime,
    required this.block,
  });
}

class TotalWidget{
  String image;
  String title;
  String Subtitle;
  final Color color;
  TotalWidget(this.image,this.title,this.Subtitle,this.color);
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

Widget _rotate(){
  return Column(
    mainAxisSize: MainAxisSize.max,
    children:[
      DefaultTextStyle(
        style: const TextStyle(
            fontSize: 13,
            color: Colors.white
        ),
        child: AnimatedTextKit(
            repeatForever: true,
            isRepeatingAnimation: true,
            animatedTexts: [
              RotateAnimatedText('Please Fill In The Correct Bank Card Information.'),
              RotateAnimatedText('Been Approved By The Platform. The Bank'),
              RotateAnimatedText('Will Complete The Transfer Within 1-7 Working Days,'),
              RotateAnimatedText('But Delays May Occur, Especially During Holidays.But'),
              RotateAnimatedText('You Are Guaranteed To Receive Your Funds.'),
            ]),
      ),
    ],
  );


}


