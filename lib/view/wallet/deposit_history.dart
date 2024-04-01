
import 'dart:convert';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/model/UsdtDepositHistoryModel.dart';
import 'package:bbm/model/user_model.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/api_urls.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../model/deposit_model.dart';

class DepositIconModel {
  final String title;
  final String? image;
  DepositIconModel({required this.title, this.image});
}

class History {
  String method;
  String balance;
  String type;
  String orderno;
  History(this.method, this.balance, this.type, this.orderno);
}

class DepositHistory extends StatefulWidget {
  const DepositHistory({super.key});

  @override
  State<DepositHistory> createState() => _DepositHistoryState();
}

class _DepositHistoryState extends State<DepositHistory> with  SingleTickerProviderStateMixin {

  @override
  void initState() {
    depositHistory();
    usdtDepositHistory();
    super.initState();
    selectedCatIndex = 0;

  }

  int ?responseStatuscode;

  List<DepositIconModel> depositIconList = [
    DepositIconModel(title: 'Indian Pay', image: Assets.imagesUpiImage),
    DepositIconModel(title: 'USDT', image: Assets.imagesUsdtIcon),
    
  ];
  late int selectedCatIndex;

  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
          title: textWidget(
              text: 'Deposit History',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 70,
              width: width * 0.93,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: depositIconList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCatIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        height: 40,
                        width: 115,
                        decoration: BoxDecoration(
                          gradient: selectedCatIndex == index
                              ? AppColors.goldenGradientDir
                              : AppColors.secondaryappbar,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 0.1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.2,
                              blurRadius: 2,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('${depositIconList[index].image}'),
                              height: 25,

                            ),
                            textWidget(
                              text: depositIconList[index].title,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selectedCatIndex == index
                                  ? AppColors.browntextprimary
                                  : AppColors.goldencolorthree,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: height*0.02),
            selectedCatIndex==0?
            responseStatuscode== 400 ?
            const Notfounddata(): depositItems.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                      itemCount: depositItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          color: const Color(0xFF3f3f3f),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: width * 0.30,
                                      decoration: BoxDecoration(
                                          color: depositItems[index].status=="0"?Colors.orange: depositItems[index].status=="1"?AppColors.DepositButton:Colors.red,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: textWidget(
                                          text: depositItems[index].status=="0"?"Pending":depositItems[index].status=="1"?"Complete":"Failed",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryTextColor
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Balance",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    textWidget(
                                        text: "₹${depositItems[index].amount}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:  const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Type",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    Image.asset(depositItems[index].type=="2"?Assets.imagesUsdtIcon:Assets.imagesFastpayImage, height: height*0.05,)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Time",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    textWidget(
                                        text: DateFormat("dd-MMM-yyyy, hh:mm a").format(DateTime.parse(depositItems[index].created_at.toString())),                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryTextColor

                                        ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Order number",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                    Row(
                                      children: [
                                        textWidget(
                                            text: depositItems[index].orderid.toString(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.primaryTextColor),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        Image.asset(Assets.iconsCopy, color: Colors.grey,height: height * 0.03)                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      })

            ):
            responseStatuscode== 400 ?
            const Notfounddata(): usdtitem.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: usdtitem.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        color: const Color(0xFF3f3f3f),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: width * 0.30,
                                    decoration: BoxDecoration(
                                        color: usdtitem[index].status=="0"?Colors.orange: usdtitem[index].status=="1"?AppColors.DepositButton:Colors.red,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: textWidget(
                                        text: usdtitem[index].status=="0"?"Pending":usdtitem[index].status=="1"?"Success":"Reject",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Amount",
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryTextColor),
                                  textWidget(
                                      text: "₹${usdtitem[index].amount}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryTextColor),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "USDT amount",
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryTextColor),
                                  textWidget(
                                      text: "₹${usdtitem[index].actual_amount}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryTextColor),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      text: "Time",
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryTextColor),
                                  textWidget(
                                      text: DateFormat("dd-MMM-yyyy, hh:mm a").format(DateTime.parse(usdtitem[index].created_at.toString())),                                        fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryTextColor
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    })

            )


          ],
        ),
      ),

    );
  }

  UserViewProvider userProvider = UserViewProvider();

  List<DepositModel> depositItems = [];

  Future<void> depositHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.depositHistory+token),);
    if (kDebugMode) {
      print(ApiUrl.depositHistory+token);
      print('depositHistory');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        depositItems = responseData.map((item) => DepositModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        depositItems = [];
      });
      throw Exception('Failed to load data');
    }
  }


  List<USDTDepositModel> usdtitem = [];

  Future<void> usdtDepositHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse("${ApiUrl.usdtdepositHistory}userid=$token"),);
    if (kDebugMode) {
      print("${ApiUrl.usdtdepositHistory}userid=$token");
      print('usdtdepositHistory');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      if (kDebugMode) {
        print(responseData);
        print("responseData");
      }


      setState(() {
        usdtitem = responseData.map((item) => USDTDepositModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        usdtitem = [];
      });
      throw Exception('Failed to load data');
    }
  }


}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
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
        const Text("Data not found",)
      ],
    );
  }

}



