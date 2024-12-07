import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:you_got_world/controllers/communityController.dart';
import 'dart:io';

import 'package:you_got_world/controllers/profileController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/shimmerContainer.dart';
import 'package:you_got_world/view/widget/loadingWidget.dart';

class AddScorerScreen extends StatefulWidget {
  @override
  _AddScorerScreenState createState() => _AddScorerScreenState();
}

class _AddScorerScreenState extends State<AddScorerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _feesPerMatchController = TextEditingController();
  final TextEditingController _feesPerDayController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  final ProfilController locationController = Get.put(ProfilController());
  final CommunityController communityController =
      Get.put(CommunityController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Scorer',
          style: TextStyle(
              color: Colors.white, fontSize: context.deviceHeight * .022),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () {
                  return communityController.isDataLoad.value == false
                      ? GestureDetector(
                          onTap: () {
                            communityController.showImagePickerModal(context);
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: communityController.imageFile.value != null
                                ? ClipOval(
                                    child: Image.file(
                                      communityController.imageFile.value!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 40,
                                        color: colorLightWhite,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Add Photo',
                                        style: TextStyle(
                                          color: colorLightWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        )
                      : SizedBox.shrink();
                },
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorLight1,
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: colorDark3,
                      ),
                  hintText: 'Scorer Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  suffixText: '*',
                  suffixStyle: TextStyle(color: Colors.red),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.transparent),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.transparent),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter scorer name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorLight1,
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: colorDark3,
                      ),
                  hintText: 'Scorer Contact Number',
                  labelStyle: TextStyle(color: Colors.grey),
                  suffixText: '*',
                  suffixStyle: TextStyle(color: Colors.red),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.transparent),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.transparent),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter contact number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorLight1,
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: colorDark3,
                              ),
                      hintText: 'City',
                      labelStyle: TextStyle(color: Colors.grey),
                      suffixText: '*',
                      suffixStyle: TextStyle(color: Colors.red),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1, color: Colors.red),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1, color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 1, color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(width: 1, color: Colors.transparent),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(width: 1, color: Colors.transparent),
                      ),
                    ),
                    onChanged: (value) {
                      locationController
                          .locationLocalAreaApis(_cityController.text);
                    },
                  ),
                  Obx(() => locationController.locationLoad.value
                      ? Center(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox()),
                        )
                      : locationController.locationLocalAreaData.isNotEmpty
                          ? Container(
                              constraints: BoxConstraints(maxHeight: 200),
                              margin: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: locationController
                                    .locationLocalAreaData.length,
                                itemBuilder: (context, index) {
                                  final location = locationController
                                      .locationLocalAreaData[index];
                                  return ListTile(
                                    dense: true,
                                    title: Text(location.location ?? ''),
                                    onTap: () {
                                      _cityController.text =
                                          location.location.toString() ?? '';
                                      communityController.selectedCity.value =
                                          location.locationId.toString();
                                      locationController.locationLocalAreaData
                                          .clear();
                                    },
                                  );
                                },
                              ),
                            )
                          : SizedBox()),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _feesPerMatchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colorLight1,
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: colorDark3,
                                ),
                        hintText: 'Fees',
                        labelStyle: TextStyle(color: Colors.grey),
                        suffixText: '*',
                        suffixStyle: TextStyle(color: Colors.red),
                        helperText: 'per match (20 Ov.)',
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 1, color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _feesPerDayController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colorLight1,
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: colorDark3,
                                ),
                        hintText: 'Fees',
                        labelStyle: TextStyle(color: Colors.grey),
                        suffixText: '*',
                        suffixStyle: TextStyle(color: Colors.red),
                        helperText: 'per day',
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 1, color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1, color: Colors.transparent),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _experienceController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorLight1,
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: colorDark3,
                      ),
                  hintText: 'Total Scoring experience (approx)',
                  labelStyle: TextStyle(color: Colors.grey),
                  suffixText: 'yrs',
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.transparent),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.transparent),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24),
              _buildButtons()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,

                foregroundColor: Colors.white,
                backgroundColor: colorLight2, // Set the text color to white
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'CANCEL',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colorDark1),
              ),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Obx(() {
              return ElevatedButton(
                child: communityController.isLoading == true
                    ? LoadingWidget()
                    : Text(
                        'Review & Publish',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,

                  foregroundColor: Colors.white,
                  backgroundColor: primaryColor, // Set the text color to white
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    communityController.addScorerApi(
                        communityController.imageFile.value,
                        _contactController.text,
                        _feesPerMatchController.text,
                        _feesPerDayController.text,
                        _nameController.text,
                        _experienceController.text,
                        communityController.selectedCity.value);
                    print(
                        "Selected City : ${communityController.selectedCity}");
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
