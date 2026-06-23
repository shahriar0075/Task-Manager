import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/main_bottom_nave_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/tm_app_bar.dart';
import 'package:task_management/ui/widgets/upload_photo.dart';

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
  bool _isObscured1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromProfileScreen: true),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                const SizedBox(height: 150),
                Text("Update Profile", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                UploadPhoto(),
                SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _firstNameTEController,
                  decoration: InputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _lastNameTEController,
                  decoration: InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  controller: _mobileTEController,
                  decoration: InputDecoration(hintText: 'Mobile'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: _isObscured1,
                  controller: _passwordTEController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffix: IconButton(
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
                ElevatedButton(
                  onPressed: _onTapUpdateButton,
                  child: const Text('Update')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapUpdateButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainBottomNaveScreen()),
    );
  }
}
