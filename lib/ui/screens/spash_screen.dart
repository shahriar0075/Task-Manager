import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management/ui/controllers/auth_controller.dart';
import 'package:task_management/ui/screens/login_screen.dart';
import 'package:task_management/ui/screens/main_bottom_nave_screen.dart';
import 'package:task_management/ui/utils/assets_path.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void>_moveToNextScreen() async{
    await Future.delayed(const Duration(seconds: 2));
    final bool isLoggedIn = await AuthController.checkUserLoggedIn();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>isLoggedIn? const MainBottomNaveScreen() :const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Center(
          child: SvgPicture.asset(AssetsPath.logoSvg,width: 180,)))
    );
  }
}
