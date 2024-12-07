import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/controllers/uploadController.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/widget/redButton.dart';

import '../../themes/colors.dart';

class UploadBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UploadController uploadController = Get.put(UploadController());

    return Stack(
      children: [
        // Blur Background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        // Bottom Sheet
        DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.7,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 30,
                          ))),
                  Center(
                    child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                      title: 'Upload Academy Photos',
                      onAddPressed: uploadController.pickImages,
                      selectedFiles: uploadController.selectedImages,
                      onRemovePressed: uploadController.removeImage,
                      isImage: true,
                      context: context,
                      subtitle: 'Add Photo'),
                  const SizedBox(height: 16),
                  _buildSection(
                      title: 'Upload Academy Videos',
                      onAddPressed: uploadController.pickVideos,
                      selectedFiles: uploadController.selectedVideos,
                      onRemovePressed: uploadController.removeVideo,
                      isImage: false,
                      context: context,
                      subtitle: 'Add Video'),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: context.deviceWidth * .9,
                    child: RedButton(
                      // isLoading: authController.loginLoad.value,
                      onPressed: () {},
                      text: 'Upload & Continue',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget titleWidget(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: context.deviceHeight * .018,
                fontWeight: FontWeight.w600,
              )),
          Container(
            margin: const EdgeInsets.only(top: 1),
            width: context.deviceWidth * .5,
            height: context.deviceHeight * .004,
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          )
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required VoidCallback onAddPressed,
    required RxList<File> selectedFiles,
    required Function(int) onRemovePressed,
    required bool isImage,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(title, context),
        const SizedBox(height: 16),
        Obx(() {
          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onAddPressed,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedFiles.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                selectedFiles[index],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => onRemovePressed(index),
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
