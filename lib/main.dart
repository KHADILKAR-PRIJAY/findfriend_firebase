import 'package:find_friend/screens/Chat_pages/database.dart';
import 'package:find_friend/screens/VIP_screen/vip_member.dart';
import 'package:find_friend/screens/abouts_us.dart';
import 'package:find_friend/screens/coins_screen/add_coins.dart';
import 'package:find_friend/screens/User_Profile_pages/edit_profile.dart';
import 'package:find_friend/screens/demo_screen/demop.dart';
import 'package:find_friend/screens/search_result_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens/filter/filter_page.dart';
import 'package:find_friend/screens/User_Profile_pages/followers.dart';
import 'package:find_friend/screens/Chat_pages/conversation_screen.dart';
import 'package:find_friend/screens/others_profile_page.dart';
import 'package:find_friend/screens/privacy_policy.dart';
import 'package:find_friend/screens/search_page.dart';
import 'package:find_friend/screens/subscription.dart';
import 'package:flutter/material.dart';
import 'package:find_friend/screens/sign_up.dart';
import 'package:find_friend/screens/OTP_pages/generate_otp.dart';
import 'package:find_friend/screens/OTP_pages/enter_otp.dart';
import 'package:find_friend/screens/log_in.dart';
import 'package:find_friend/screens/general_page.dart';
import 'package:find_friend/screens/splash_screen.dart';
import 'package:find_friend/screens/coins_screen/coins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black54),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),

      debugShowCheckedModeBanner: false,
      //home: Demop(),
      initialRoute: SplashScreen.id,
      routes: {
        SignUp.id: (context) => SignUp(),
        GenerateOtp.id: (context) => GenerateOtp(),
        //EnterOtp.id: (context) => EnterOtp(),
        LogIn.id: (context) => LogIn(),
        //GeneralPage.id: (context) => GeneralPage(),
        SplashScreen.id: (context) => SplashScreen(),
        //HomePage.id: (context) => HomePage(),
        //Coins.id: (context) => Coins(),
        //AddCoins.id: (context) => AddCoins(),
        //Subscription.id: (context) => Subscription(),
        AboutUs.id: (context) => AboutUs(),
        PrivacyPolicy.id: (context) => PrivacyPolicy(),
        //VipMember.id: (context) => VipMember(),
        //EditProfile.id: (context) => EditProfile(),
        //SearchPage.id: (context) => SearchPage(),
        //Followers.id: (context) => Followers(),
        //MessagePage.id: (context) => MessagePage(),
        //OthersProfilePage.id: (context) => OthersProfilePage(),
        FilterPage.id: (context) => FilterPage(),
        //Verification.id: (context) => Verification(),
        // VIPMemberDetail.id: (context) => VIPMemberDetail(),
        //SearchResultProfile.id: (context) => SearchResultProfile(),
      },
    );
  }
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

//data_connection_checker package along with the connectivity package.
// Future<bool> isInternet() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.mobile) {
//     // I am connected to a mobile network, make sure there is actually a net connection.
//     if (await DataConnectionChecker().hasConnection) {
//       // Mobile data detected & internet connection confirmed.
//       return true;
//     } else {
//       // Mobile data detected but no internet connection found.
//       return false;
//     }
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     // I am connected to a WIFI network, make sure there is actually a net connection.
//     if (await DataConnectionChecker().hasConnection) {
//       // Wifi detected & internet connection confirmed.
//       return true;
//     } else {
//       // Wifi detected but no internet connection found.
//       return false;
//     }
//   } else {
//     // Neither mobile data or WIFI detected, not internet connection found.
//     return false;
//   }
// }
