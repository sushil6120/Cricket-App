import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/view/widget/profileWidget/profileHeaderWidget.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(
              subtitle: "New Delhi",
            ),
            Image.asset('assets/img/qrCode.png')
          ],
        ),
      ),
    );
  }
}
