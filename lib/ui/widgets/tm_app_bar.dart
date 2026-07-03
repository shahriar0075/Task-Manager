import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_management/ui/controllers/auth_controller.dart';
import '../screens/login_screen.dart';
import '../screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key, this.fromProfileScreen,
  });
  final bool? fromProfileScreen;

  @override
  Widget build(BuildContext context) {
    late TextTheme textTheme =Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green.shade500,
      title: GestureDetector(
        onTap: (){
          if(fromProfileScreen ?? false){
            return;
          }
        _onTapProfile(context);},
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: _shouldShowImage(AuthController.userModel?.photo) ? MemoryImage(
                  base64Decode(AuthController.userModel?.photo ?? ''),
              ): null,
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AuthController.userModel?.fullName ?? '',style: textTheme.titleMedium?.copyWith(color: Colors.white),),
                  Text(AuthController.userModel?.email ?? 'Unknown' ,style: textTheme.bodySmall?.copyWith(color: Colors.white))
                ],
              ),
            ),
            IconButton(onPressed: ()=>_onTapLogOutButton(context), icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }

  bool _shouldShowImage(String? photo){
    return photo != null && photo.isNotEmpty;
  }

  void _onTapProfile(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
  }

  Future <void> _onTapLogOutButton(BuildContext context) async{
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=> const LoginScreen()),
        (predicate)=>false);
  }

  @override
  Size get preferredSize =>Size.fromHeight(kToolbarHeight);
}