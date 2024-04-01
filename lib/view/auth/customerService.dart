// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:bbm/res/helper/api_helper.dart';
import 'package:bbm/res/provider/profile_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';



class CustomerService extends StatefulWidget {
  const CustomerService({super.key});


  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}
class _CustomerServiceState extends State<CustomerService> {

  @override
  void initState() {
    fetchData(context);
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ProfileProvider>(context).userData;

    return SafeArea(
      child: Scaffold(
        body: () {
          if (kIsWeb) {
            _launchURL(
              'https://tawk.to/chat/65deea499131ed19d972b7e5/1hnnc6csu',
              userData!.username==null?"MEMBERNGKC":userData.username.toString(),
              userData.email==null?"":userData.email.toString(),
            );
          } else {
            return userData != null ?
            Tawk(
              directChatLink: 'https://tawk.to/chat/65deea499131ed19d972b7e5/1hnnc6csu',
              visitor: TawkVisitor(
                name: userData.username==null?"MEMBERNGKC":userData.username.toString(),
                email: userData.email==null?"":userData.email.toString(),
              ),
            ) :
            const CircularProgressIndicator();
          }
        }(),


      ),
    );

  }
  _launchURL(String directChatLink, String name, String email) async {
    var url = '$directChatLink?name=$name&email=$email';
    if (kDebugMode) {
      print(url);
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
}