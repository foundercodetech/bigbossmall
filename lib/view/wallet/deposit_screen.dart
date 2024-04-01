// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/model/addaccount_view_model.dart';
import 'package:bbm/model/deposit_model_new.dart';
import 'package:bbm/model/user_model.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/audio.dart';
import 'package:bbm/res/components/text_field.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/helper/api_helper.dart';
import 'package:bbm/res/provider/profile_provider.dart';
import 'package:bbm/res/provider/user_view_provider.dart';
import 'package:bbm/res/provider/wallet_provider.dart';
import 'package:bbm/utils/utils.dart';
import 'package:bbm/view/wallet/depositweb.dart';
import 'package:bbm/view/wallet/uploadss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../res/api_urls.dart';
import 'package:http/http.dart' as http;

class GridChange{
  String title;
  String images;
  GridChange(this.title,this.images);
}

class DepositScreen extends StatefulWidget {
  final AddacountViewModel? account;
  const DepositScreen({super.key, this.account});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {

 bool loading = false;


  @override
  void initState() {
    Audio.depositmusic();
    getwaySelect();
    walletfetch(context);
    fetchData(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Audio.audioPlayers;
    // TODO: implement dispose
    super.dispose();
  }


  int selectedIndex = 0;
  int result = 0;
  String resultt = "";

  TextEditingController depositCon = TextEditingController();
  TextEditingController usdtCon = TextEditingController();
  String selectedDeposit = '';
  String selectedusdt = '';
  List<DepositModel> depositList = [
    DepositModel(value: '100', title: '100'),
    DepositModel(value: '500', title: '500'),
    DepositModel(value: '1000', title: '1K'),
    DepositModel(value: '10000', title: '10K'),
    DepositModel(value: '50000', title: '50K'),
    DepositModel(value: '100000', title: '100K'),
  ];

  List<GridChange> list = [
    // GridChange("Local UPI Bonus",Assets.imagesUpiImage),
    GridChange("Fast Pay",Assets.imagesFastpayImage),
    GridChange("USDT",Assets.imagesUsdtIcon),

  ];




  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    int ?responseStatuscode;
    
    final walletdetails = Provider.of<WalletProvider>(context).walletlist;
    
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: GestureDetector(
                onTap: () {
                  Audio.audioPlayers.stop();
                  Navigator.pop(context);
                },
                child: Image.asset(Assets.iconsArrowBack)),
          ),
          title: textWidget(
              text: 'Deposit', fontSize: 25, color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body:
      walletdetails!= null?
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: height * 0.21,
                width: width,
                padding: const EdgeInsets.all(15),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage(Assets.imagesCardImage),
                        fit: BoxFit.fill
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(Assets.iconsDepoWallet, height: 30),
                            const SizedBox(width: 15),
                            textWidget(
                                text: 'Balance',
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 15),
                            const Icon(Icons.currency_rupee,
                            ),
                            textWidget(
                              text: walletdetails.wallet.toString(),
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                            const SizedBox(width: 15),
                            InkWell(
                                onTap: (){
                                  paymentstatus(userstatus,context);
                                  walletfetch(context);
                                },
                                child: Image.asset(Assets.iconsTotalBal, height: 30, )),
                          ],
                        ),
                      ],
                    ),
                    Image.asset(Assets.iconsChip),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              responseStatuscode== 400 ?
              const Notfounddata(): items.isEmpty? Container():
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final currentId = int.parse(items[index].id.toString());

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = currentId;
                        if (kDebugMode) {
                          print(selectedIndex);
                          print('rrrrrrrrrrrrrrrrr');
                        }


                      });
                      Audio.audioPlayers.play();

                    },
                    child: Card(
                      elevation: selectedIndex == currentId ? 2 : 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: selectedIndex == currentId
                              ? AppColors.goldenGradientDir
                              : AppColors.secondaryappbar,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            items[index].image != null
                                ? Image.network(items[index].image.toString(), height: 45,)
                                : const Placeholder(
                              fallbackHeight: 45,
                            ),
                            textWidget(
                                text: items[index].name.toString(),
                                fontSize: 13,
                                color: selectedIndex == currentId
                                    ? AppColors.browntextprimary
                                    : AppColors.browntextprimary,
                                fontWeight: FontWeight.w900
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20,),


              const SizedBox(height: 20),

              selectedIndex == 0?
              Container():
              selectedIndex == 1?
              Container(
                height: height * 0.20,
                width: width,
                padding:  const EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    gradient: AppColors.secondaryappbar,
                    borderRadius: BorderRadiusDirectional.circular(15)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(Assets.iconsSaveWallet,height: height*0.05,),
                        const SizedBox(width: 15),
                        textWidget(
                            text: 'Deposit amount',
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.goldencolorthree
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      fillColor: AppColors.scaffolddark,
                      hintText: 'Please enter the amount',
                      fieldRadius: BorderRadius.circular(30),
                      textColor: Colors.white,
                      keyboardType: TextInputType.number,
                      fontWeight: FontWeight.w600,
                      controller: depositCon,
                      onChanged: (value) {
                      },
                      prefixIcon: SizedBox(
                        width: 70,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Icon(Icons.currency_rupee,
                                color: AppColors.goldencolorthree),
                            const SizedBox(width: 10),
                            Container(height: 30, color: Colors.white, width: 2)
                          ],
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            depositCon.clear();
                            selectedDeposit = '';
                          });
                        },
                        icon: const Icon(Icons.cancel_outlined,
                            color: AppColors.iconColor),
                      ),
                    ),
                  ],
                ),
              ) :
              // selectedIndex == 2?
              // Container(
              //   width: width,
              //   padding:  const EdgeInsets.only(top: 15, left: 15, right: 15),
              //   decoration: BoxDecoration(
              //       gradient: AppColors.secondaryappbar,
              //       borderRadius: BorderRadiusDirectional.circular(15)),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         children: [
              //           Image.asset(Assets.imagesUsdtIcon,height: height*0.05,),
              //           const SizedBox(width: 15),
              //           textWidget(
              //               text: 'USDT amount',
              //               fontSize: 20,
              //               fontWeight: FontWeight.w900,
              //               color: AppColors.goldencolorthree
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 10),
              //       CustomTextField(
              //         fillColor: AppColors.scaffolddark,
              //         hintText: 'Please usdt amount',
              //         fieldRadius: BorderRadius.circular(30),
              //         textColor: Colors.white,
              //         keyboardType: TextInputType.number,
              //         fontWeight: FontWeight.w600,
              //         controller: usdtCon,
              //         onChanged: (value) {
              //           setState(() {
              //             double amount = double.tryParse(value) ?? 0;
              //             resultt = (amount * 91).toStringAsFixed(2);
              //
              //           });
              //
              //         },
              //         prefixIcon: SizedBox(
              //           width: 70,
              //           child: Row(
              //             children: [
              //               const SizedBox(width: 10),
              //               Image.asset(Assets.imagesUsdtIcon,height: height*0.03,),
              //               const SizedBox(width: 10),
              //               Container(height: 30, color: Colors.white, width: 2)
              //             ],
              //           ),
              //         ),
              //         suffixIcon: IconButton(
              //           onPressed: () {
              //             setState(() {
              //               usdtCon.clear();
              //               selectedusdt = '';
              //               resultt="";
              //             });
              //           },
              //           icon: const Icon(Icons.cancel_outlined,
              //               color: AppColors.iconColor),
              //         ),
              //       ),
              //       SizedBox(height: height*0.01),
              //       Text(
              //         'Total amount in Rupees: ${resultt.isNotEmpty ? resultt + " Rs" : "0 Rs"}',
              //         style: TextStyle(
              //             fontSize: 20,
              //             fontWeight: FontWeight.w900,
              //             color: AppColors.goldencolorthree),
              //       ),
              //       SizedBox(height: height*0.02),
              //
              //       // if(resultt.isNotEmpty)
              //       //   Column(
              //       //     crossAxisAlignment: CrossAxisAlignment.start,
              //       //     children: [
              //       //       AppBtn(
              //       //         onTap: () {
              //       //
              //       //           // _settingModalBottomSheet(context);
              //       //           Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadScreenshots()));
              //       //         },
              //       //         hideBorder: true,
              //       //         title: 'Add Screenshot',
              //       //         gradient: AppColors.ssbutton,
              //       //       ),
              //       //       SizedBox(height: height*0.02),
              //       //
              //       //       // CircleAvatar(
              //       //       //   radius: 20,
              //       //       //   backgroundColor: Colors.transparent,
              //       //       //   backgroundImage:
              //       //       //   myData != '0'
              //       //       //       ?
              //       //       //   Image.memory(base64Decode(myData)).image:
              //       //       //   NetworkImage(ApiUrl.uploadimage+userData!.photo.toString()),
              //       //       // ),
              //       //       // SizedBox(height: height*0.02),
              //       //
              //       //     ],
              //       //   )
              //     ],
              //   ),
              // ):
              Container(
                width: width,
                padding:  const EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    gradient: AppColors.secondaryappbar,
                    borderRadius: BorderRadiusDirectional.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(Assets.imagesUsdtIcon,height: height*0.05,),
                        const SizedBox(width: 15),
                        textWidget(
                            text: 'USDT amount',
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.goldencolorthree
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      fillColor: AppColors.scaffolddark,
                      hintText: 'Please usdt amount',
                      fieldRadius: BorderRadius.circular(30),
                      textColor: Colors.white,
                      keyboardType: TextInputType.number,
                      fontWeight: FontWeight.w600,
                      controller: usdtCon,
                      onChanged: (value) {
                        setState(() {
                          double amount = double.tryParse(value) ?? 0;
                          resultt = (amount * 91).toStringAsFixed(2);

                        });

                      },
                      prefixIcon: SizedBox(
                        width: 70,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Image.asset(Assets.imagesUsdtIcon,height: height*0.03,),
                            const SizedBox(width: 10),
                            Container(height: 30, color: Colors.white, width: 2)
                          ],
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            usdtCon.clear();
                            selectedusdt = '';
                            resultt="";
                          });
                        },
                        icon: const Icon(Icons.cancel_outlined,
                            color: AppColors.iconColor),
                      ),
                    ),
                    SizedBox(height: height*0.01),
                    Text(
                      'Total amount in Rupees: ${resultt.isNotEmpty ? "$resultt Rs" : "0 Rs"}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.goldencolorthree),
                    ),
                    SizedBox(height: height*0.02),

                    // if(resultt.isNotEmpty)
                    //   Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       AppBtn(
                    //         onTap: () {
                    //
                    //           // _settingModalBottomSheet(context);
                    //           Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadScreenshots()));
                    //         },
                    //         hideBorder: true,
                    //         title: 'Add Screenshot',
                    //         gradient: AppColors.ssbutton,
                    //       ),
                    //       SizedBox(height: height*0.02),
                    //
                    //       // CircleAvatar(
                    //       //   radius: 20,
                    //       //   backgroundColor: Colors.transparent,
                    //       //   backgroundImage:
                    //       //   myData != '0'
                    //       //       ?
                    //       //   Image.memory(base64Decode(myData)).image:
                    //       //   NetworkImage(ApiUrl.uploadimage+userData!.photo.toString()),
                    //       // ),
                    //       // SizedBox(height: height*0.02),
                    //
                    //     ],
                    //   )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              ///button
              selectedIndex == 0 && depositCon.text.isEmpty
                  ? Container() :
              loading==false && selectedIndex == 1?
              AppBtn(
                onTap: () {
                  //_launchURL1();
                  addmony(depositCon.text,context);
                },
                hideBorder: true,
                title: 'Deposit',
                gradient: AppColors.containerGradient,
              ):
              loading==false && selectedIndex == 2?
              AppBtn(
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadScreenshots(amount:resultt,cont:usdtCon.text)));
                },
                hideBorder: true,
                title: 'USDT Deposit',
                gradient: AppColors.containerGradient,
              ):
              // loading==false && selectedIndex == 3?
              // AppBtn(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadScreenshots(amount:resultt,cont:usdtCon.text)));
              //   },
              //   hideBorder: true,
              //   title: 'USDT Deposit',
              //   gradient: AppColors.containerGradient,
              // ):
              Center(
                child: Container(
                  height: 45,
                  width: 43,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.gradientFirstColor,
                          AppColors.gradientSecondColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: const EdgeInsets.all(12),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4,
                  ),
                ),
              ),



              const SizedBox(height: 20),
              Container(
                width: width,
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: BoxDecoration(
                    gradient: AppColors.goldenGradientDir,
                    borderRadius: BorderRadiusDirectional.circular(15)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(Assets.iconsRecIns),
                        const SizedBox(width: 15),
                        textWidget(
                            text: 'Recharge instructions',
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ],
                    ),
                    instruction('If the transfer time is up, please fill out the deposit form again.'),
                    instruction('The transfer amount must match the order you created, otherwise the money cannot be credited successfully.'),
                    instruction('If you transfer the wrong amount, our company will not be responsible for the lost amount!'),
                    instruction('Note: do not cancel the deposit order after the money has been transferred.'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      )
          :Container(),
    );
  }

 Future<void> fetchData(context) async {
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

 Future<void> walletfetch(context) async {
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


int minimumamount=100;
  ///getway api
  List<GetwayModel> items = [];

  Future<void> getwaySelect() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.getwayList+token),);
    if (kDebugMode) {
      print(ApiUrl.getwayList+token);
      print('getwayList+token');
    }



    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {
        minimumamount=json.decode(response.body)['minimum'];
        items = responseData.map((item) => GetwayModel.fromJson(item)).toList();
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
        items = [];
      });
      throw Exception('Failed to load data');
    }
  }



  UserViewProvider userProvider = UserViewProvider();


  String userstatus="";

  addmony(String depositCon,context)async {
    setState(() {
      loading=true;
    });
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print(ApiUrl.deposit);
      print("ApiUrl.deposit");
    }


    final response =  await http.post(Uri.parse(ApiUrl.deposit),

      headers:<String ,String>{
        "Content-Type":"application/json; charset=UTF-8",
      },
      body: jsonEncode(<String ,String>{
        "userid":token,
        "amount": depositCon,
        "type":selectedIndex.toString()
      }),
    );
    final data = jsonDecode(response.body);
    if (kDebugMode) {
      print(data);
      print("jdguywfud");
    }

    if(data["status"]=='SUCCESS'){
      setState(() {
        loading=false;
      });

      var url =data['payment_link'].toString();

      if(kIsWeb){
        _launchURL(url);
      }else{
        Navigator.push(context,MaterialPageRoute(builder: (context)=>payment_Web(url: url,)));
      }
      Utils.flushBarSuccessMessage(data["msg"],context, Colors.white);
    }
    else{
      setState(() {
        loading=false;
      });
      Utils.flushBarErrorMessage( data["msg"],context, Colors.white);
    }
  }


  _launchURL(String urlget) async {
    var url = urlget;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


 paymentstatus(String userstatus,context)async {

   if (kDebugMode) {
     print(ApiUrl.paymentCheckStatus+userstatus);
     print("ApiUrl.paymentCheckStatus+userstatus");
   }

   final response =  await http.get(Uri.parse(ApiUrl.paymentCheckStatus+userstatus),

   );
   final data = jsonDecode(response.body);
   if(data["status"]=="200"){
     Utils.flushBarSuccessMessage( data["msg"],context, Colors.white);
   }
   else{
     Utils.flushBarErrorMessage( data["msg"],context, Colors.white);
   }
 }



 ///qr india
 // addqrindia(String depositCon)async {
 //   setState(() {
 //     loading=true;
 //   });
 //   UserModel user = await userProvider.getUser();
 //   String token = user.id.toString();
 //   print(ApiUrl.deposit);
 //   print("ApiUrl.deposit");
 //
 //   final response =  await http.post(Uri.parse(ApiUrl.deposit),
 //
 //     headers:<String ,String>{
 //       "Content-Type":"application/json; charset=UTF-8",
 //     },
 //     body: jsonEncode(<String ,String>{
 //       "userid":token,
 //       "amount": depositCon,
 //       "type":selectedIndex.toString()
 //     }),
 //   );
 //   final data = jsonDecode(response.body);
 //   print(data);
 //   print("jdguywfud");
 //   if(data["status"]=='SUCCESS'){
 //     setState(() {
 //       loading=false;
 //     });
 //
 //     // var urlget =data['payment_link'].toString();
 //     var url =data['payment_link'].toString();
 //
 //     // _launchURL(urlget);
 //     Navigator.push(context,MaterialPageRoute(builder: (context)=>payment_Web(url: url,)));
 //     Utils.flushBarSuccessMessage(data["msg"],context, Colors.white);
 //   }
 //   else{
 //     setState(() {
 //       loading=false;
 //     });
 //     Utils.flushBarErrorMessage( data["msg"],context, Colors.white);
 //   }
 //
 // }

}






class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height*0.07),
        const Text("Data not found",)
      ],
    );
  }

}

Widget instruction(String title){
  return ListTile(
    leading: Transform.rotate(
      angle: 45 * 3.1415927 / 180,
      child: Container(
        height: 10,
        width: 10,
        color: AppColors.gradientFirstColor,
      ),
    ),
    title: textWidget(
      text:
      title,
      fontSize: 14,

    ),
  );
}

class DepositModel {
  final String value;
  final String title;

  DepositModel({
    required this.value,
    required this.title,
  });
}
