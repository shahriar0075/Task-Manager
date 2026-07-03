import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management/data/models/user_model.dart';
import 'package:task_management/ui/controllers/auth_controller.dart';
import 'package:task_management/ui/screens/main_bottom_nave_screen.dart';
import 'package:task_management/ui/widgets/center_circular_process_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/tm_app_bar.dart';

import '../../data/service/network_clint.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey();
  bool _isObscured1 = true;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;
  bool _updateProfileInProgress=false;

  @override
  void initState() {
    super.initState();
    UserModel userModel = AuthController.userModel!;
    _emailTEController.text = userModel.email;
    _firstNameTEController.text = userModel.firstName;
    _lastNameTEController.text = userModel.lastName;
    _mobileTEController.text = userModel.mobile;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromProfileScreen: true),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: _fromKey,
              child: Column(
                children: [
                  const SizedBox(height: 150),
                  Text("Update Profile", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  _buildPhotoPickerWidget(),
                  SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    enabled: false,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _firstNameTEController,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String ? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (String ? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                    controller: _mobileTEController,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    validator: (String ? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    obscureText: _isObscured1,
                    controller: _passwordTEController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _isObscured1 = !_isObscured1;
                        },
                        icon: Icon(
                          _isObscured1 ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapUpdateButton,
                      child: const Text('Update')
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildPhotoPickerWidget() {
    return GestureDetector(
              onTap: _onTapImagePicker,
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: const Center(
                          child: Text(
                            'Photo',
                            style: TextStyle(color: Colors.white),)),
                    ),
                    const SizedBox(width: 12),
                    Text(_pickedImage?.name ?? "Select Profile Picture"),
                  ],
                ),
              ),
            );
  }

  void _onTapUpdateButton() {
    if(_fromKey.currentState!.validate()){
      _updateProfile();
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainBottomNaveScreen()),
      (route) => false,
    );
  }

  Future<void> _updateProfile()async {
    _updateProfileInProgress =true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };
    if(_passwordTEController.text.isEmpty){
      requestBody["password"]= _passwordTEController.text;
    }

    if(_pickedImage!=null){
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      String encodedImage = base64Encode(imageBytes);
      requestBody['photo'] = encodedImage;
    }

    NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.updateProfileUrl,
        body: requestBody);
    _updateProfileInProgress =false;
    setState(() {});
    if(response.isSuccess){
      if(response.data !=null && response.data!['data'] != null){
        UserModel updateUser = UserModel.fromJson((response.data!['data']));
        await AuthController.savedUserInformation(AuthController.token ?? '', updateUser);
      }

      if(context.mounted) return;
      showSnackBarMessage(context, 'Profile Updated Successfully');
      _passwordTEController.clear();
    }
    else{
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  Future<void> _onTapImagePicker() async {
    XFile? image= await _imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      _pickedImage =image;
      setState(() {
      });
    }
  }
}