import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

import 'login_screen.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPassTEController = TextEditingController();
  final TextEditingController _confirmNewPasspasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  bool _isObscured2=true;
  bool _isObscured3=true;
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
                  Text("Set Password",
                      style: Theme.of(context).textTheme.titleLarge
                  ),
                  const SizedBox(height: 6,),
                  Text(
                      'Minimum length password 8 character with Latter and number combination',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    obscureText: _isObscured2,
                    controller: _newPassTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      suffix: IconButton(onPressed: (){
                        setState(() {
                          _isObscured2= !_isObscured2;
                        });
                      }, icon: Icon(_isObscured2 ? Icons.visibility_off :Icons.visibility))
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    obscureText: _isObscured3,
                    controller: _confirmNewPasspasswordTEController,
                    decoration: InputDecoration(
                      hintText: 'Confirm New Password',
                      suffix: IconButton(onPressed: (){
                        setState(() {
                          _isObscured3 = !_isObscured3;
                        });
                      }, icon: Icon(_isObscured3 ? Icons.visibility_off : Icons.visibility))
                    ),
                  ),
                  const SizedBox(height: 8,),
                  ElevatedButton(onPressed: _onTapSubmitButton, child: const Text('Confirm')),
                  const SizedBox(height: 64,),
                  Center(
                    child: Column(
                      children: [
                        RichText(text: TextSpan(
                            children: [
                              TextSpan(text: "Already have account? ",
                                  style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600,fontSize: 14)
                              ),
                              TextSpan(text: "Sign In", style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 14),
                                recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
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

  void _onTapSubmitButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()),(pre)=>false);
  }

  void _onTapSignInButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()),(pre)=>false);
  }
  @override
  void dispose() {
    _newPassTEController.dispose();
    _confirmNewPasspasswordTEController.dispose();
    super.dispose();
  }

}