import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management/ui/screens/login_screen.dart';
import 'package:task_management/ui/screens/reset_password_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';


class ForgotPasswordCodeVerificationScreen extends StatefulWidget {
  const ForgotPasswordCodeVerificationScreen({super.key});

  @override
  State<ForgotPasswordCodeVerificationScreen> createState() => _ForgotPasswordCodeVerificationScreenState();
}

class _ForgotPasswordCodeVerificationScreenState extends State<ForgotPasswordCodeVerificationScreen> {
  final PinInputController _pinCodeTEController = PinInputController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 150,),
                Text("Code Verification",
                    style: Theme.of(context).textTheme.titleLarge
                ),
                const SizedBox(height: 6,),
                Text(
                    'A 6 digit verification code has been sent to your email adress',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)
                ),
                const SizedBox(height: 16,),
                MaterialPinField(
                  pinController: _pinCodeTEController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  onCompleted: (pin) => print('PIN: $pin'),
                  onChanged: (value) => print('Changed: $value'),
                  theme: MaterialPinTheme(
                    shape: MaterialPinShape.outlined,
                    cellSize: Size(46, 54),
                    borderRadius: BorderRadius.circular(12),
                    completeFillColor: Colors.white,
                    completeBorderColor: Colors.green.shade50,
                  ),
                ),
                const SizedBox(height: 8,),
                ElevatedButton(onPressed: onTapSubmitButton, child: const Text('Verify')),
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
        ))
    );
  }
  void onTapSubmitButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResetPasswordScreen()));
  }
  void _onTapSignInButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()),(pre)=>false);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _pinCodeTEController.dispose();
    super.dispose();
  }

}
