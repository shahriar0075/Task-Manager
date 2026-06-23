import 'package:flutter/material.dart';

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
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shahriar Rahman',style: textTheme.titleMedium?.copyWith(color: Colors.white),),
                  Text('shakib@gmail.com',style: textTheme.bodySmall?.copyWith(color: Colors.white))
                ],
              ),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
  void _onTapProfile(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
  }
  @override
  Size get preferredSize =>Size.fromHeight(kToolbarHeight);
}