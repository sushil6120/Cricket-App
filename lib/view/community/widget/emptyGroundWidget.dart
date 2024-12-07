import 'package:flutter/material.dart';
import 'package:you_got_world/utils/responsive.dart';

import '../../../themes/colors.dart';

class EmptyGroundWidget extends StatelessWidget {
  const EmptyGroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image,
                  size: 64,
                  color: Colors.grey.shade300,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: 120,
                  height: 8,
                  color: Colors.grey.shade200,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 80,
                  height: 8,
                  color: Colors.grey.shade200,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Sorry, we don't have details of any Cricket Ground in",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          const Text(
            'your city. Please reset filters to view all.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              'RESET FILTERS',
              style: TextStyle(fontSize: context.deviceHeight * .018),
            ),
          ),
        ],
      ),
    );
  }
}
