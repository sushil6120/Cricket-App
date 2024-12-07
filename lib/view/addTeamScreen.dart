import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:you_got_world/controllers/tabController.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/utilsFunction.dart';
import 'package:you_got_world/view/widget/redButton.dart';
import 'package:you_got_world/view/widget/textFormFields.dart';

import '../controllers/profileController.dart';
import '../controllers/startMatchController.dart';
import '../themes/colors.dart';
import '../utils/valueConstants.dart';

class AddTeamScreen extends StatefulWidget {
  @override
  State<AddTeamScreen> createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<AddTeamScreen> {
  TextEditingController nameController = TextEditingController();
  final StartMatchController controller = Get.put(StartMatchController());
  final ProfilController profilController = Get.put(ProfilController());
  final TabSwitchController tabSwitchController =
      Get.put(TabSwitchController());
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profilController.locationLocalAreaApis('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 14,
                ),

                // Team Logo
                Obx(() => GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: colorLight2,
                            ),
                            shape: BoxShape.circle),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: controller.imageFile.value != null
                              ? FileImage(controller.imageFile.value!)
                              : null,
                          child: controller.imageFile.value == null
                              ? Icon(Icons.person,
                                  size: 60, color: primaryColor)
                              : null,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 14,
                ),
                Text(
                  'TEAM LOGO',
                  style: TextStyle(
                      fontSize: context.deviceHeight * .018,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.only(top: verticalSpaceSmall),
                  child: TextFormFieldBig(
                    // controller: emailController,
                    height: 50,
                    hintText: 'Team Name',
                    maxLines: 1,
                    enabled: true,
                    fillColor: colorLight2,
                    isFill: true,
                    onChanged: (value) => controller.teamName.value = value,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Team name is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: verticalSpaceSmall,
                ),
                Obx(() => Column(
                      children: [
                        GestureDetector(
                          onTap: () => controller.isDropdownOpen.value =
                              !controller.isDropdownOpen.value,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.selectedCity.value ??
                                      'Select City/Town',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: colorDark1,
                                      ),
                                ),
                                Icon(
                                  controller.isDropdownOpen.value
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (controller.isDropdownOpen.value)
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Search TextField
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search city...',
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (_debounce?.isActive ?? false)
                                      _debounce!.cancel();
                                    _debounce = Timer(
                                        const Duration(milliseconds: 500), () {
                                      controller.searchQuery.value = value;
                                      profilController
                                          .locationLocalAreaApis(value);
                                    });
                                  },
                                ),
                                SizedBox(height: 8),
                                // Cities List
                                Container(
                                  constraints: BoxConstraints(maxHeight: 200),
                                  child: Obx(() => ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: profilController
                                            .locationLocalAreaData.value.length,
                                        itemBuilder: (context, index) {
                                          final city = profilController
                                              .locationLocalAreaData
                                              .value[index];
                                          return ListTile(
                                              title: Text(
                                                city.location.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              onTap: () {
                                                controller.selectCity(
                                                    city.location.toString());
                                                controller.selectCityId(
                                                    city.locationId.toString());
                                                controller.isDropdownOpen
                                                    .value = false;
                                              });
                                        },
                                      )),
                                ),
                              ],
                            ),
                          ),
                      ],
                    )),

                Padding(
                  padding: const EdgeInsets.only(top: verticalSpaceSmall),
                  child: SizedBox(
                    height: 70,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: colorDark1,
                            fontWeight: FontWeight.w400,
                          ),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                            color: errorColor,
                            fontSize: 12,
                            height: 1.2), // Ensure consistent height
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Team captain/Coordinator number',
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: colorDark3,
                                ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        prefixText: '+91 ',
                        prefixStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChanged: (value) =>
                          controller.captainNumber.value = value,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Phone number is required';
                        }
                        if (value!.length != 10) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: verticalSpaceSmall2),
                  child: TextFormFieldBig(
                    controller: nameController,
                    height: 50,
                    hintText: 'Team Captain Name(Optional)',
                    maxLines: 1,
                    enabled: true,
                    fillColor: colorLight2,
                    isFill: true,
                  ),
                ),

                SizedBox(height: 16),

                // Checkbox
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.isInTeam.value,
                          onChanged: (value) =>
                              controller.isInTeam.value = value!,
                        )),
                    Text(
                      'Add myself in team',
                      style: TextStyle(
                        fontSize: context.deviceHeight * .015,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          height: context.deviceHeight * .08,
          color: Colors.white,
          child: Obx(
            () {
              return RedButton(
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    // controller.submitForm(nameController.text);
                    if (controller.validateForm()) {
                      if (controller.selectedCityId.value == null) {
                        Utils.toastMessage('Please Select City/town');
                      } else {
                        if (tabSwitchController.screen.value ==
                            'OpponentsScreen') {
                          controller
                              .createOpponentTeamApi(
                            controller.imageFile.value,
                            controller.teamName.value,
                            controller.selectedCityId.value!,
                            controller.captainNumber.value,
                            nameController.text,
                          )
                              .then((value) {
                            nameController.clear();
                            controller.teamName.value = '';
                            controller.captainName.value = '';
                            controller.captainNumber.value = '';
                            controller.cityTown.value = '';
                            controller.imageFile.value = null;
                          });
                        } else {
                          controller
                              .createTeamApi(
                                  controller.imageFile.value,
                                  controller.teamName.value,
                                  controller.selectedCityId.value!,
                                  controller.captainNumber.value,
                                  nameController.text,
                                  controller.isInTeam.value == true ? '1' : '2')
                              .then((value) {
                            nameController.clear();
                            controller.teamName.value = '';
                            controller.captainName.value = '';
                            controller.captainNumber.value = '';
                            controller.cityTown.value = '';
                            controller.imageFile.value = null;
                          });
                        }
                      }
                    }

                    nameController.clear();
                  },
                  text: 'Add Team');
            },
          )),
    );
  }
}
