
import 'dart:convert';
import 'package:bbm/main.dart';
import 'package:bbm/model/extradepositmodel.dart';
import 'package:bbm/model/user_model.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/api_urls.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/provider/user_view_provider.dart';
import 'package:bbm/utils/utils.dart';
import 'package:bbm/view/wallet/depositweb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {

  @override
  void initState() {
    extraDeposit();
    // TODO: implement initState
    super.initState();
  }
  bool loading = false;

  int ?responseStatuscode;

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: AppColors.scaffolddark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: height*0.52,
        child: Column(
          children: [
            Container(
              height: height*0.06,
              width: width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: AppColors.goldenGradientDir),
              child: Row(
                children: [
                  const AppBackBtn(),
                  SizedBox(width: width*0.16),
                  Center(
                      child: textWidget(
                          text: "Offers",
                          fontSize: width*0.055,
                          color: Colors.white,
                        fontWeight: FontWeight.bold
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: height*0.01),
            Expanded(
              child: ListView.builder(
                itemCount: depositItems.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index){
                  return
                    depositItems[index].status=="1"?
                    Card(
                    color: const Color(0xFF3f3f3f),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.secondaryappbar,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text("First Deposit ",style: TextStyle(fontSize: 13,
                                    color: Colors.white),),
                                    Text("₹${depositItems[index].name}",
                                      style: const TextStyle(
                                          fontSize: 13,
                                    color: Colors.yellow
                                      ),),
                                  ],
                                ),
                                Text("Total: ₹${depositItems[index].totalamount}",style: const TextStyle(fontSize: 13,
                                    color: Colors.yellow),),
                              ],
                            ),
                            SizedBox(height: height*0.01),
                            Text("Deposit ₹${depositItems[index].name} for the first time in your  account and you can recieve bonus ₹${depositItems[index].addon}",
                                style: const TextStyle(fontSize: 13,
                                color: Colors.white)),
                            SizedBox(height: height*0.01),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: (){
                                  extraDepositPay(amount:depositItems[index].name.toString());
                                },
                                child: Container(
                                  height: height*0.04,
                                  width: width*0.28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.yellow
                                    )
                                  ),
                                  child: const Center(
                                    child: Text("Deposit",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.yellow
                                    ),),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ),
                    )):
                    Container(
                      decoration: BoxDecoration(
                          gradient: AppColors.secondaryappbar,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text("First Deposit ",style: TextStyle(fontSize: 13,
                                      color: Colors.white),),
                                  Text("₹${depositItems[index].name}",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey
                                    ),),
                                ],
                              ),
                              Text("Total: ₹${depositItems[index].totalamount}",style: const TextStyle(fontSize: 13,
                                  color: Colors.grey),),
                            ],
                          ),
                          SizedBox(height: height*0.01),
                          Text("Deposit ₹${depositItems[index].name} for the first time in your  account and you can recieve bonus ₹${depositItems[index].addon}",
                              style: const TextStyle(fontSize: 13,
                                  color: Colors.white)),
                          SizedBox(height: height*0.01),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: height*0.04,
                              width: width*0.28,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey
                                  )
                              ),
                              child: const Center(
                                child: Text("Claimed",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey
                                  ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    );

                  }),
            )


          ],
        ),
      ),
    );
  }

  UserViewProvider userProvider = UserViewProvider();


  extraDepositPay({required String amount})async {
    setState(() {
      loading=true;
    });
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print(ApiUrl.extradepositPayment);
      print("ApiUrl.extradepositPayment");

    }

    final response =  await http.get(Uri.parse("${ApiUrl.extradepositPayment}userid=$token&amount=$amount"),
      
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

      // var urlget =data['payment_link'].toString();
      var url =data['payment_link'].toString();

      // _launchURL(urlget);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>payment_Web(url: url,)));
      Utils.flushBarSuccessMessage(data["msg"],context, Colors.white);
    }
    else{
      setState(() {
        loading=false;
      });
      Utils.flushBarErrorMessage( data["msg"],context, Colors.white);
    }

  }



  List<ExtraDepositModel> depositItems = [];

  Future<void> extraDeposit() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse(ApiUrl.extradeposit+token),);
    if (kDebugMode) {
      print(ApiUrl.extradeposit+token);
      print('extradeposit');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        depositItems = responseData.map((item) => ExtraDepositModel.fromJson(item)).toList();
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

}
