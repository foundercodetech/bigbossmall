import 'dart:convert';
import 'package:bbm/generated/assets.dart';
import 'package:bbm/main.dart';
import 'package:bbm/model/attendence_model.dart';
import 'package:bbm/model/user_model.dart';
import 'package:bbm/res/aap_colors.dart';
import 'package:bbm/res/api_urls.dart';
import 'package:bbm/res/components/app_bar.dart';
import 'package:bbm/res/components/app_btn.dart';
import 'package:bbm/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../res/components/text_widget.dart';
import 'package:http/http.dart' as http;


class AttendenceHistory extends StatefulWidget {
  const AttendenceHistory({super.key});

  @override
  State<AttendenceHistory> createState() => _AttendenceHistoryState();
}

class _AttendenceHistoryState extends State<AttendenceHistory> {


  @override
  void initState() {
    attendenceHistory();
    // TODO: implement initState
    super.initState();
  }

  int ?responseStatuscode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Attendence History',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body: ListView(
        children: [
          responseStatuscode== 400 ?
          const Notfounddata(): attendenceItems.isEmpty? const Center(child: CircularProgressIndicator()):
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: attendenceItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: textWidget(
                            text: "₹${attendenceItems[index].amount}",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                        ),
                        title: Image.asset(Assets.imagesCoingifts, height: 45,),
                        trailing: textWidget(
                            text: DateFormat.EEEE().format(
                                DateTime.parse(attendenceItems[index].datetime.toString())),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryTextColor
                        ),
                      )

                    );
                  })

          ),

        ],
      ),
    );
  }
  UserViewProvider userProvider = UserViewProvider();

  List<AttendenceModel> attendenceItems = [];

  Future<void> attendenceHistory() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse(ApiUrl.attendenceHistory+token),);
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

}
class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height*0.05,),
        Image.asset(Assets.imagesNoDataAvailable,height: height*0.21,),
        // Image(
        //   image: const AssetImage(Assets.imagesNoDataAvailable),
        //   height: heights / 3,
        //   width: widths / 2,
        // ),
        const Text("No data (:",style: TextStyle(color: Colors.white),)
      ],
    );
  }

}
