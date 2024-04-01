
import 'dart:convert';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/model/attendence_model.dart';
import 'package:bbm/model/user_model.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/api_urls.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/components/text_widget.dart';
import 'package:bbm/res/provider/user_view_provider.dart';
import 'package:bbm/view/activity/attendence_history.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class AttendenceBonus extends StatefulWidget {
  const AttendenceBonus({super.key});

  @override
  State<AttendenceBonus> createState() => _AttendenceBonusState();
}

class _AttendenceBonusState extends State<AttendenceBonus> {

  @override
  void initState() {
    attendenceList();
    attendenceDays();
    // TODO: implement initState
    super.initState();

  }

  int ?responseStatuscode;

  @override
  Widget build(BuildContext context) {

    String? lastDay = attendenceItems.isNotEmpty?attendenceItems.last.datetime.toString():"No data";
    String lastAmount = attendenceItems.isNotEmpty?attendenceItems.last.amount.toString():"No data";
    String lastid = attendenceItems.isNotEmpty?attendenceItems.last.id.toString():"No data";
    String laststatus = attendenceItems.isNotEmpty?attendenceItems.last.status.toString():"No data";



    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Attendance bonus',
              fontSize: width*0.05,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
        body: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(gradient: AppColors.secondaryappbar,image: DecorationImage(image: AssetImage(Assets.imagesBggifts),fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                        text: "Attendence Bonus",
                        fontSize: width*0.047,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTextColor
                    ),
                    SizedBox(height: height*0.01,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                            text: "Get your rewards based on consecutive \n login days.",
                            fontSize: width*0.034,
                            color: AppColors.primaryTextColor
                        ),
                        SizedBox(height: height*0.01),
                        textWidget(
                            text: "* Tap to claim the daily rewards",
                            fontSize: width*0.04,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryTextColor

                        ),
                      ],
                    ),
                    SizedBox(height: height*0.01),
                    Container(
                      height: height*0.10,
                      width: width*0.45,
                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesBookmark),fit: BoxFit.fill)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.01,),
                          textWidget(
                              text: "Attended consecutively",
                              fontSize: width*0.035,
                              color: Colors.red,
                              fontWeight: FontWeight.bold

                          ),
                          SizedBox(height: height*0.01,),
                          textWidget(
                              text: days==null?"0 Days":"$days Days",
                              fontSize: width*0.045,
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.01),
                    textWidget(
                        text: "Accumulated",
                        fontSize: width*0.045,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTextColor
                    ),
                    Row(
                      children: [
                        textWidget(
                          text: amount==null?"₹0.0":"₹ $amount",
                          fontSize:  width*0.05,
                          color: Colors.red,
                        ),
                        InkWell(
                            onTap: (){
                              attendenceList();
                              attendenceDays();
                            },
                            child: Image.asset(Assets.iconsTotalBal,color: AppColors.browntextprimary,height: height*0.03,)),
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AttendenceHistory()));
                      },
                      child: Center(
                        child: Container(
                          height: height*0.045,
                          width: width*0.40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                  colors: [Color(0xffff9b3e),Color(0xffffab3f)])),
                          child: Center(
                            child: textWidget(
                              text: "Attendence History",
                              fontSize:  width*0.035,
                              color: AppColors.primaryTextColor,
                            ),
                          ) ,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: height*0.02,),

            responseStatuscode== 400 ?
            const Notfounddata(): attendenceItems.isEmpty? const Center(child: CircularProgressIndicator()):

            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: attendenceItems.length>6?6:attendenceItems.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  attendenceItems[index].status=='1'?
                  InkWell(
                    onTap: (){
                      attendenceGet(ids:attendenceItems[index].id.toString());
                    },
                    child: Card(
                    elevation:  3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          gradient: AppColors.secondaryappbar,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textWidget(
                              text: "₹${attendenceItems[index].amount}",
                              fontSize: 13,
                              color: Colors.white
                            ),
                            Image.asset(Assets.imagesCoingifts, height: 45,),
                            textWidget(
                                text: DateFormat.EEEE().format(
                                    DateTime.parse(attendenceItems[index].datetime.toString())),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryTextColor
                            ),
                          ],
                        ))),
                  )
                      :attendenceItems[index].status=='2'?
                  Card(
                      elevation:  1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textWidget(
                                text: "₹${attendenceItems[index].amount}",
                                fontSize: 13,
                              ),
                              textWidget(
                                  text: 'Redeemed',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                              ),
                              textWidget(
                                  text: DateFormat.EEEE().format(
                                      DateTime.parse(attendenceItems[index].datetime.toString())),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryTextColor
                              ),

                            ],
                          ))):
                  Card(
                      elevation:  1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textWidget(
                                text: "₹${attendenceItems[index].amount}",
                                fontSize: 13,
                              ),
                              textWidget(
                                  text: 'Expired',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                              ),
                              textWidget(
                                  text: DateFormat.EEEE().format(
                                      DateTime.parse(attendenceItems[index].datetime.toString())),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryTextColor
                              ),
                            ],
                          )));
              },
            ),



            if (laststatus=="1") InkWell(
              onTap: (){
                attendenceGet(ids:lastid);
                if (kDebugMode) {
                  print(lastid);
                  print("lastid");
                }},
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: height*0.20,
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesGiftsbelow),fit: BoxFit.fill)),
                  child: SizedBox(
                    width: width*0.0,
                    child: Padding(
                      padding: EdgeInsets.only(left: width*0.30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(
                              text: "₹$lastAmount",
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),
                          lastDay==''?Container():
                          textWidget(
                              text: DateFormat.EEEE().format(
                                  DateTime.parse(lastDay.toString())),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryTextColor
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ) else laststatus=="2"?
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                    height: height*0.20,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Assets.imagesGiftsbelow),fit: BoxFit.fill)),
                    child: Padding(
                      padding: EdgeInsets.only(left: width*0.30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          textWidget(
                            text:"₹$lastAmount",
                            fontSize: 13,
                          ),
                          textWidget(
                            text: 'Redeemed',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          lastDay==''?Container():
                          textWidget(
                              text: DateFormat.EEEE().format(
                                  DateTime.parse(lastDay.toString())),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryTextColor
                          ),

                        ],
                      ),
                    ))):
            Card(
                elevation:  1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: height*0.20,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration( color: Colors.grey.shade100,image: const DecorationImage(image: AssetImage(Assets.imagesGiftsbelow),fit: BoxFit.fill)),
                    child: Padding(
                      padding: EdgeInsets.only(left: width*0.30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(
                            text: "₹$lastAmount",
                            fontSize: 13,
                          ),
                          textWidget(
                            text: 'Expired',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,

                          ),
                          lastDay=='No data'?Container():
                          textWidget(
                              text: DateFormat.EEEE().format(
                                  DateTime.parse(lastDay.toString())),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryTextColor
                          ),
                        ],
                      ),
                    )))
          ],
        )
    );
  }
  UserViewProvider userProvider = UserViewProvider();

  List<AttendenceModel> attendenceItems = [];

  Future<void> attendenceList() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse(ApiUrl.AttendenceList+token),);
    if (kDebugMode) {
      print(ApiUrl.AttendenceList+token);
      print('AttendenceList');
    }
    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        attendenceItems = responseData.map((item) => AttendenceModel.fromJson(item)).toList();
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
        attendenceItems = [];
      });
      throw Exception('Failed to load data');
    }
  }



///claim api



  attendenceGet( {String? ids}) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

   final response = await http.get(Uri.parse("${ApiUrl.AttendenceGet}userid=$token&tableid=$ids"));

   if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response);
        print("response attendence get");
      }
      final Map<String, dynamic> responseData = jsonDecode(response.body);


       if (kDebugMode) {
        print(responseData);
        print("responseData");
      }
      attendenceList();
      return Fluttertoast.showToast(msg: responseData['msg']);
    } else {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      return Fluttertoast.showToast(msg: responseData['msg']);
    }
  }



  ///container red

  dynamic amount;
  dynamic days;


  Future<void> attendenceDays() async {
    UserViewProvider userProvider = UserViewProvider();

    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print("ffffffffggfhff");
    }

    final url = Uri.parse(ApiUrl.attendenceDays+token);
    final response = await http.get(url,);
    if (kDebugMode) {
      print("fggggggghgggg");
      print(ApiUrl.attendenceDays+token);
      print("ApiUrl.attendenceDays+token");
    }
    if(response.statusCode==200){
      if (kDebugMode) {
        print(response.statusCode);
        print("guyguggggu");
      }
      final responseData = json.decode(response.body);
      amount = responseData["amount"]==null?"":responseData["amount"].toString();
      days = responseData["days"]==null?"":responseData["days"].toString();

    }else{
      throw Exception("load to display");
    }
  }




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

