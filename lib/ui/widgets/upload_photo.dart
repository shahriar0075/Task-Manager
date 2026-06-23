import 'package:flutter/material.dart';

class UploadPhoto extends StatelessWidget {
  const UploadPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapPhotoButton,
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
            const Text("Select Profile Picture"),
          ],
        ),
      ),
    );
  }

  void _onTapPhotoButton() {

  }
}
