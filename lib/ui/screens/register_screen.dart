import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/data/service/network_clint.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';

import '../../data/utils/urls.dart';
import '../widgets/center_circular_process_indicator.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscured1 = true;
  bool _registrationInProgress=false;

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
                  Text("Join With Us",
                      style: Theme.of(context).textTheme.titleLarge
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String ? value){
                      String email =value?.trim() ?? '';
                      if(EmailValidator.validate(email)==false){
                        return 'Enter a valid email';
                      }
                      return null;
                  },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    controller: _firstNameTEController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                    ),
                    validator: (String ? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    controller: _lastNameTEController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                     keyboardType: TextInputType.phone,
                    controller: _mobileTEController,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                    validator: (String? value) {
                      String phone =value?.trim() ?? '';
                      RegExp regex = RegExp(r'^(?:(?:\+|00)88)?01[3-9]\d{8}$');
                      if (!regex.hasMatch(phone)) {
                        return 'Enter a valid mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: _isObscured1,
                    controller: _passwordTEController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffix: IconButton(onPressed: (){
                       setState(() {
                         _isObscured1 = !_isObscured1;
                       });
                      }, icon: Icon(_isObscured1 ? Icons.visibility_off : Icons.visibility))
                    ),
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                        return 'Enter a password with at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  Visibility(
                    visible: _registrationInProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(onPressed: _onTapSubmitButton,
                      child: const Icon(Icons.arrow_circle_right_outlined))),
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
    if(_formKey.currentState!.validate()){
      _registerUser();
    }
  }
  Future<void> _registerUser()async {
    _registrationInProgress =true;
    setState(() {

    });
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    NetworkResponse response = await NetworkClient.postRequest(url: Urls.registerUrl, body: requestBody);
    _registrationInProgress =false;
    setState(() {

    });
    if(response.isSuccess){
      _clearTextField();
      showSnackBarMessage(context,'Registration successful');
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextField(){
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignInButton(){
    Navigator.pop(context);
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}