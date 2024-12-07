import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadController extends GetxController {
  var selectedImages = <File>[].obs;
  var selectedVideos = <File>[].obs;

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      selectedImages.addAll(images.map((image) => File(image.path)));
    }
  }

  Future<void> pickVideos() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? videos = await picker.pickMultipleMedia(); // Use for multiple videos if needed
    if (videos != null) {
      selectedVideos.addAll(videos.map((video) => File(video.path)));
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void removeVideo(int index) {
    selectedVideos.removeAt(index);
  }
}