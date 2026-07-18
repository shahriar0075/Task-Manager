import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/data/models/login_model.dart';
import 'package:task_management/data/service/network_clint.dart';
import 'package:task_management/ui/controllers/auth_controller.dart';
import 'package:task_management/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_management/ui/screens/main_bottom_nave_screen.dart';
import 'package:task_management/ui/screens/register_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/widgets/center_circular_process_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  bool _logInProgress = false;
  bool _isObscured=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150,),
                Text("Get Started With",
                style: Theme.of(context).textTheme.titleLarge
                  ),
                const SizedBox(height: 16,),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (String ? value){
                    String email = value?.trim() ?? '';
                    if(EmailValidator.validate(email)==false){
                      return 'Please enter a register email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  obscureText: _isObscured,
                  controller: _passwordTEController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffix: IconButton(icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                      onPressed: () { setState(() { _isObscured = !_isObscured; }); },)
                  ),
                  validator: (String ? value){
                    if((value?.isEmpty??true) || (value!.length<6)){
                      return 'Your Password is incorrect';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),
                Visibility(
                  visible: !_logInProgress,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(onPressed: onTapSignInButton, child: const Text('Log In')),
                ),
                const SizedBox(height: 64,),
                Center(
                  child: Column(
                    children: [
                      TextButton(onPressed: _onTapForgotPasswordButton, child: Text('Forgot Password?')),
                      RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Don't have an account? ",
                            style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 14)
                          ),
                          TextSpan(text: "Sign Up", style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 14),
                            recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton,
                          )
                        ]
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ))
    );
  }

  void onTapSignInButton(){
    if(_formKey.currentState!.validate()){
      _login();
    }
    else{
      showSnackBarMessage(context, 'Please fill all the fields', true);
    }
  }

  Future<void> _login() async{
    _logInProgress=true;
    setState(() {});
    Map<String, dynamic> requester = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.logInUrl,
      body: requester
    );
    _logInProgress =false;
    setState(() {});
    if(response.isSuccess){
      LoginModel loginModel = LoginModel.fromJson(response.data!);
      //TODO: save token to local
      AuthController.savedUserInformation(loginModel.token, loginModel.userModel);
      //TODO: local database set up
      //TODO: Logged in or not


      showSnackBarMessage(context, 'Log In Successful');
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute( builder: (context)=> const MainBottomNaveScreen()),
              (pre)=>false);
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }


  void _onTapForgotPasswordButton(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordVerifyEmailScreen()),
    );
  }
  void _onTapSignUpButton(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}