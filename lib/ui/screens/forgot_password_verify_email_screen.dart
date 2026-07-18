import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'forgot_password_code_verification_screen.dart';


class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() => _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
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
                  Text("Your Email Address",
                      style: Theme.of(context).textTheme.titleLarge
                  ),
                  const SizedBox(height: 6,),
                  Text(
                    'A 6 digit verification code will send to your email address',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 8,),
                  ElevatedButton(onPressed: onTapSubmitButton, child: const Icon(Icons.arrow_circle_right_outlined)),
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
  void onTapSubmitButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPasswordCodeVerificationScreen()));
  }
  void _onTapSignInButton(){
    Navigator.pop(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEController.dispose();
    super.dispose();
  }
}