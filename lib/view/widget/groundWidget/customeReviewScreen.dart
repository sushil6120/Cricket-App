import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';

class CustomerReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 16, right: 16, top: verticalSpaceSmall),
          child: Text(
            'Customer reviews',
            style: TextStyle(
                fontSize: context.deviceWidth * .04,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Row(
            children: [
              Icon(Icons.star,
                  color: Colors.amber, size: context.deviceWidth * .044),
              Icon(Icons.star,
                  color: Colors.amber, size: context.deviceWidth * .044),
              Icon(Icons.star,
                  color: Colors.amber, size: context.deviceWidth * .044),
              Icon(Icons.star,
                  color: Colors.amber, size: context.deviceWidth * .044),
              Icon(Icons.star,
                  color: Colors.amber, size: context.deviceWidth * .044),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Text(
            '273 Reviews',
            style: TextStyle(
                fontSize: context.deviceWidth * .034, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: _buildRatingBar(context),
        ),
        const SizedBox(
          height: 4,
        ),
        const Divider(
          color: colorLight2,
        ),
        const SizedBox(height: 4),
        ...List.generate(
          4,
          (index) {
            return Column(
              children: [
                _buildReviewCard(context),
                const Divider(
                  color: colorLight2,
                ),
              ],
            );
          },
        )
      ],
    );
  }

  Widget _buildRatingBar(BuildContext context) {
    return Column(
      children: [
        _buildRatingRow(5, 0.7, '5', context),
        _buildRatingRow(5, 0.5, '4', context),
        _buildRatingRow(5, 0.3, '3', context),
        _buildRatingRow(5, 0.1, '2', context),
        _buildRatingRow(5, 0.05, '1', context),
      ],
    );
  }

  Widget _buildRatingRow(
      int stars, double widthFactor, String count, BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(
            stars,
            (index) => Icon(Icons.star,
                color: Colors.amber, size: context.deviceWidth * .038),
          ),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            SizedBox(
              width: context.deviceWidth * .4,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(0),
                value: widthFactor,
                backgroundColor: Colors.grey[300],
                color: Colors.amber,
                minHeight: context.deviceHeight * .007,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "($count)",
              style: TextStyle(
                  color: colorDark3.withOpacity(.6),
                  fontSize: context.deviceWidth * .03),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildReviewCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 0,
        color: colorLightWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/premium-vector/female-user-profile-avatar-is-woman-character-screen-saver-with-emotions_505620-617.jpg'), // Replace with the actual image URL
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kristin Watson',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Nov 09, 2022',
                        style: GoogleFonts.roboto(
                            fontSize: context.deviceWidth * .028,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: context.deviceWidth * .16),
                child: Text(
                  'This is 💯 one hundred percent the best lip mask duo ever !!! '
                  'The scent is delicious and it’s so smooth from',
                  style: TextStyle(
                      fontSize: context.deviceWidth * .03,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
