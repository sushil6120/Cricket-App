import 'package:flutter/material.dart';
import 'package:you_got_world/utils/responsive.dart';

class TournaMentWidget extends StatelessWidget {
  const TournaMentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          width: context.deviceWidth,
          margin: EdgeInsets.only(bottom: 20, left: 14, right: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.17),
                blurRadius: 35,
                spreadRadius: 0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://fancyodds.com/wp-content/uploads/2021/12/Neerja-Modi-School.jpg', // Replace with your image URL
                  height: context.deviceHeight * .27,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // 'PAST' Label
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'PAST',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: context.deviceHeight * .014,
                    ),
                  ),
                ),
              ),
              // Bottom Text Section
              Positioned(
                bottom: -2,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 0,
                        offset: Offset(0, -20),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pankaj Cricket Club T-25 Series',
                        style: TextStyle(
                          fontSize: context.deviceHeight * .018,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'New Delhi',
                        style: TextStyle(
                          fontSize: context.deviceHeight * .015,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
