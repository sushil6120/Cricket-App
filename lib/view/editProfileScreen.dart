import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:you_got_world/controllers/authController.dart';
import 'package:you_got_world/controllers/profileController.dart';
import 'package:you_got_world/model/userProfileModel.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'dart:io';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/widget/loadingWidget.dart';
import 'package:you_got_world/view/widget/redButton.dart';
import 'package:you_got_world/view/widget/textFormFields.dart';

import '../themes/colors.dart';

class ProfileEditScreen extends StatefulWidget {
  UserProfileModel? userProfileModel;
  ProfileEditScreen({super.key, this.userProfileModel});
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final ProfilController profilController = Get.put(ProfilController());

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var pinController = TextEditingController();
  var locationController = TextEditingController();
  var searchController = TextEditingController();
  var selectedPlayerRole = '';
  var selectedBattingStyle = '';
  var selectedBowlingStyle = '';
  var selectedLocationId = '';
  String selectedDob = 'DOB';
  Timer? _debounce;
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  String? selectedGender;
  String? selectedLocation;

  Future<void> _showImagePickerOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: primaryColor,
                ),
                title: Text('Gallery',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  color: primaryColor,
                ),
                title: Text(
                  'Camera',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Validation Methods
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  String? validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN is required';
    }
    if (value.length != 4) {
      return 'PIN must be 4 digits';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  bool validateForm() {
    if (_formKey.currentState?.validate() != true) {
      return false;
    }
    if (selectedDob == 'DOB') {
      Get.snackbar('Error', 'Please select your date of birth',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (selectedLocationId.isEmpty) {
      Get.snackbar('Error', 'Please select your location',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (selectedPlayerRole.isEmpty) {
      Get.snackbar('Error', 'Please select your player role',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (selectedBattingStyle.isEmpty) {
      Get.snackbar('Error', 'Please select your batting style',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (selectedBowlingStyle.isEmpty) {
      Get.snackbar('Error', 'Please select your bowling style',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (selectedGender == null) {
      Get.snackbar('Error', 'Please select your gender',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userProfileModel != null) {
      firstNameController.text =
      selectedDob = widget.userProfileModel!.data!.first.dob.toString();
      phoneNumberController.text =
          widget.userProfileModel!.data!.first.phone.toString();
      emailController.text =
          widget.userProfileModel!.data!.first.email.toString();
      // pinController.text = widget.userProfileModel!.data!.first.p.toString();
      locationController.text =
          widget.userProfileModel!.data!.first.location.toString();
      selectedPlayerRole =
          widget.userProfileModel!.data!.first.playingRole.toString();
      selectedBattingStyle =
          widget.userProfileModel!.data!.first.battingStyle.toString();
      selectedBowlingStyle =
          widget.userProfileModel!.data!.first.bowlingStyle.toString();
      selectedGender = widget.userProfileModel!.data!.first.gender.toString();
    }
    profilController.profileParameterApis();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    pinController.dispose();
    locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(
        () {
          if (profilController.isLoad.value == true ||
              profilController.profileParameterModel.value.data == null) {
            return LoadingWidget();
          } else {
            return Column(
              children: [
                Divider(),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: _image != null
                                        ? FileImage(_image!)
                                        : widget.userProfileModel!.data!.first!
                                                    .profileImage !=
                                                null
                                            ? NetworkImage(widget
                                                .userProfileModel!
                                                .data!
                                                .first!
                                                .profileImage
                                                .toString())
                                            : NetworkImage(
                                                'https://media.gettyimages.com/id/166080748/vector/cricket-player-strikes-the-ball-for-six.jpg?s=612x612&w=gi&k=20&c=V-kwBs62Vum3JsjZTDYTsXeyvA1Q0-ECKwuq8m39hTg='), // Replace with actual image URL
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        _showImagePickerOptions(context);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                  bottom: verticalSpaceSmall2),
                              child: TextFormFieldBig(
                                controller: firstNameController,
                                height: 50,
                                hintText: 'First Name',
                                maxLines: 1,
                                enabled: true,
                                fillColor: colorLight2,
                                isFill: true,
                                validator: validateName,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                  bottom: verticalSpaceSmall2),
                              child: TextFormFieldBig(
                                controller: lastNameController,
                                height: 50,
                                hintText: 'Last Name',
                                maxLines: 1,
                                enabled: true,
                                fillColor: colorLight2,
                                isFill: true,
                                validator: validateName,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 0,
                                right: 0,
                                bottom: verticalSpaceSmall2,
                              ),
                              child: GestureDetector(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  width: context.deviceWidth,
                                  height: context.deviceHeight * .05,
                                  decoration: BoxDecoration(
                                    color: colorLight2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 0),
                                          child: Text(
                                            selectedDob,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: selectedDob != "DOB"
                                                  ? colorDark1
                                                  : colorDark3,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                  bottom: verticalSpaceSmall2),
                              child: TextFormFieldBig(
                                controller: phoneNumberController,
                                formatters: [
                                  LengthLimitingTextInputFormatter(10)
                                ],
                                height: 50,
                                hintText: 'Phone Number',
                                maxLines: 1,
                                enabled: true,
                                fillColor: colorLight2,
                                isFill: true,
                                validator: validatePhone,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                  bottom: verticalSpaceSmall2),
                              child: TextFormFieldBig(
                                controller: emailController,
                                height: 50,
                                hintText: 'Email Address',
                                maxLines: 1,
                                enabled: true,
                                fillColor: colorLight2,
                                isFill: true,
                                validator: validateEmail,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                  bottom: verticalSpaceSmall2),
                              child: TextFormFieldBig(
                                controller: pinController,
                                formatters: [
                                  LengthLimitingTextInputFormatter(4)
                                ],
                                keyboard: TextInputType.phone,
                                height: 50,
                                hintText: 'Pin',
                                maxLines: 1,
                                enabled: true,
                                fillColor: colorLight2,
                                isFill: true,
                                validator: validatePin,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                  bottom: verticalSpaceSmall2),
                              child: GestureDetector(
                                onTap: () {
                                  _showAlertDialog(context);
                                },
                                child: TextFormFieldBig(
                                  controller: locationController,
                                  formatters: [
                                    LengthLimitingTextInputFormatter(4)
                                  ],
                                  keyboard: TextInputType.phone,
                                  height: 50,
                                  hintText: 'Location',
                                  maxLines: 1,
                                  enabled: false,
                                  fillColor: colorLight2,
                                  isFill: true,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 50,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  labelText: 'Player Role',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: colorDark3,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: colorLight2,
                                ),
                                items: profilController.profileParameterModel
                                    .value.data!.playingRole!
                                    .map((role) => DropdownMenuItem(
                                          value: role,
                                          child: Text(
                                            role.playRole.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedPlayerRole =
                                        value!.fldId.toString();
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 50,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  labelText: 'Batting Style',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: colorDark3,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: colorLight2,
                                ),
                                items: profilController.profileParameterModel
                                    .value.data!.battingStyle!
                                    .map((style) => DropdownMenuItem(
                                          value: style,
                                          child: Text(
                                            style.battingStyle.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBattingStyle =
                                        value!.fldId.toString();
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 50,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  labelText: 'Bowling Style',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: colorDark3,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: colorLight2,
                                ),
                                items: profilController.profileParameterModel
                                    .value.data!.bowlingStyle!
                                    .map((style) => DropdownMenuItem(
                                          value: style,
                                          child: Text(
                                            style.blwlingStyle.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBowlingStyle =
                                        value!.fldId.toString();
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            // Gender selection
                            Row(
                              children: [
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                ...List.generate(
                                  profilController.profileParameterModel.value
                                      .data!.userGender!.length,
                                  (index) {
                                    return Expanded(
                                      child: RadioListTile(
                                        activeColor: primaryColor,
                                        title: Text(
                                          profilController
                                              .profileParameterModel
                                              .value
                                              .data!
                                              .userGender![index]
                                              .gender
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        value: profilController
                                            .profileParameterModel
                                            .value
                                            .data!
                                            .userGender![index]
                                            .fldId
                                            .toString(),
                                        groupValue: selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value.toString();
                                            print(selectedGender);
                                          });
                                        },
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),

                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () {
                    return SizedBox(
                      width: context.deviceWidth * .95,
                      child: RedButton(
                          isLoading: authController.registerLoad.value,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authController
                                  .updateProfileApi(
                                      _image != null ? _image : null,
                                      selectedLocationId,
                                      selectedDob,
                                      emailController.text,
                                      "${firstNameController.text} ${lastNameController.text}",
                                      phoneNumberController.text,
                                      selectedPlayerRole,
                                      selectedBattingStyle,
                                      selectedBowlingStyle,
                                      selectedGender.toString(),
                                      pinController.text)
                                  .then((value) {
                                profilController.userProfileApi();
                              });
                            }
                          },
                          text: 'Save'),
                    );
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            height: context.deviceHeight * .48,
            width: context.deviceWidth * .95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                      bottom: verticalSpaceSmall2,
                      top: 10),
                  child: TextFormFieldBig(
                    controller: searchController,
                    height: 50,
                    hintText: 'Search location..',
                    maxLines: 1,
                    enabled: true,
                    fillColor: colorLight2,
                    isFill: true,
                    onChanged: (p0) {
                      setState(() {
                        if (_debounce?.isActive ?? false) {
                          _debounce!.cancel();
                        }

                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          profilController.locationLocalAreaData.clear();
                          profilController.locationLocalAreaApis(p0);
                        });
                      });
                    },
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () {
                          if (profilController.locationLoad.value == true) {
                            return LoadingWidget();
                          } else if (profilController
                              .locationLocalAreaData.isEmpty) {
                            return Center(
                              heightFactor: 6,
                              child: Text(
                                "Search your location,\nex:- Pincode,Name etc.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colorDark3,
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount:
                                  profilController.locationLocalAreaData.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    setState(() {
                                      selectedLocationId = profilController
                                          .locationLocalAreaData[index]
                                          .locationId
                                          .toString();
                                      locationController.text = profilController
                                          .locationLocalAreaData[index].location
                                          .toString();
                                    });
                                    Navigator.pop(context);
                                  },
                                  title: Text(
                                    profilController
                                        .locationLocalAreaData[index].location
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }

// -----------------------

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, Widget? child) {
        return Theme(
            data: ThemeData(
              primaryColor: primaryColor,
              colorScheme: ColorScheme.light(primary: primaryColor),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: Colors.black,
                hourMinuteTextColor: Colors.white,
                dayPeriodColor: primaryColor,
                hourMinuteColor: Colors.grey.shade800,
                dialBackgroundColor: Colors.grey.shade800,
                dialTextColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.black;
                  }
                  return Colors.white;
                }),
                entryModeIconColor: primaryColor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: primaryColor,
                ),
              ),
            ),
            child: child!);
      },
    );
    if (pickedDate != null) {
      setState(() {
        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
        selectedDob = formattedDate;
      });
    }
  }
}
