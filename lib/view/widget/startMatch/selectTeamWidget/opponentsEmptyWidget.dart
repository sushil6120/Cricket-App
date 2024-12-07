import 'package:flutter/material.dart';
import 'package:you_got_world/utils/responsive.dart';

import '../../../../themes/colors.dart';
import '../../redButton.dart';

class OpponentsEmptyWidget extends StatelessWidget {
  const OpponentsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/img/opp.png',
            height: context.deviceHeight * .2,
            width: context.deviceWidth * .42,
            fit: BoxFit.cover,
          )),
          SizedBox(
            height: 10,
          ),
          Text(
            "No tasks",
            style: TextStyle(
                fontSize: context.deviceHeight * .018,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "There are no tasks assigned to you.\nCheck back later.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: context.deviceHeight * .017,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: context.deviceWidth * .9,
            child: RedButton(onPressed: () {}, text: 'Create your team'),
          ),
          SizedBox(height: 10,),
          SizedBox(
             width: context.deviceWidth * .9,
            child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
            
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent, 
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: primaryColor
                      ),
            borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child:  Text(
                "Need Help?",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: primaryColor),
              ),
                ),
          )
        ],
      );
  }
}