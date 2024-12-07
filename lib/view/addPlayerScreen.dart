import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/controllers/squadController.dart'; // Import contacts service
import 'package:permission_handler/permission_handler.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/widget/startMatch/selectTeamWidget/addPlayerByNamePhone.dart';
import 'package:you_got_world/view/widget/startMatch/selectTeamWidget/addplayerFromYourContact.dart';

class AddPlayerScreen extends StatelessWidget {
   String teamid;
   String teamName;
   String ? screen;
   AddPlayerScreen({super.key,required this.teamid, required this.teamName,this.screen});
  final SquadController teamController = Get.put(SquadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: colorLightWhite,
        title:  Text(
         teamName,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        centerTitle: true,
        elevation: .5,
        shadowColor: colorLight2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildOptionCard(
                context: context,
                icon: Icons.link,
                title: "Team Link",
                description:
                    "Easiest way to add players.\n\nShare this link with captain and left add their respective players directly to team.",
                actions: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,

                      foregroundColor: Colors.white,
                      backgroundColor:
                          primaryColor, // Set the text color to white
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: primaryColor)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.ios_share_sharp,
                          color: colorLightWhite,
                          size: 20,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Share',
                          style: const TextStyle(
                              color: colorLightWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,

                      foregroundColor: Colors.white,
                      backgroundColor:
                          colorLightWhite, // Set the text color to white
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: primaryColor)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/img/whatsApp.png',
                          width: 18,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Whatsapp',
                          style: const TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                  // _buildActionButton("Share", teamController.shareLink),
                  // _buildActionButton("Whatsapp", teamController.shareViaWhatsApp),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                   Get.to(AddPlayerByNamePhoneScreen(
                    teamId:teamid ,
                    screen: screen,
                    teamName:teamName ,
                   ),transition: Transition.rightToLeft);
                },
                child: _buildOptionCard(
                  context: context,
                  icon: Icons.phone,
                  title: "Add via Phone Number",
                  description: "Best for adding 1 or 2 players quickly",
                  actions: [],
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  // _selectContact(context)
                  Get.to(AddPlayersFromYourContact(
                    teamName:teamName ,
                    screen: screen,
                    teamid: teamid,),
                      transition: Transition.rightToLeft);
                },
                child: _buildOptionCard(
                  context: context,
                  icon: Icons.contacts,
                  title: "Add from Contacts",
                  description: "Best if players are already in your contact",
                  actions: [],
                ),
              ),
              const SizedBox(height: 16),
              _buildOptionCard(
                context: context,
                icon: Icons.qr_code,
                title: "Team QR Code",
                description: "Scan and add players directly via QR code",
                actions: [],
              ),
            ],
          ),
        ),
      ),
    );
  }



  // Method to build each option card with title, description, and actions
  Widget _buildOptionCard(
      {required IconData icon,
      required String title,
      required String description,
      required List<Widget> actions,
      required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey[300],
                child: Icon(icon, color: Colors.black),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.deviceHeight * .018,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: context.deviceHeight * .016,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: actions,
          ),
        ],
      ),
    );
  }

}
