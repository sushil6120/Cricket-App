import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:you_got_world/controllers/communityController.dart';
import 'package:you_got_world/controllers/profileController.dart';
import 'package:you_got_world/model/locationLocalAreaModel.dart';
import 'package:you_got_world/model/preCompleteGroundModel.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/community/widget/moreDetailsWidget.dart';
import 'package:you_got_world/view/widget/loadingWidget.dart';
import 'package:you_got_world/view/widget/textFormFields.dart';

import '../../utils/utilsFunction.dart';

class GroundRegistrationScreen extends StatefulWidget {
  @override
  State<GroundRegistrationScreen> createState() =>
      _GroundRegistrationScreenState();
}

class _GroundRegistrationScreenState extends State<GroundRegistrationScreen> {
  final CommunityController controller = Get.put(CommunityController());
  final ProfilController profilController = Get.put(ProfilController());

  final TextEditingController groundNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController primaryContactController =
      TextEditingController();
  final TextEditingController secondaryContactController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController shortestLengthController =
      TextEditingController();
  final TextEditingController longestLengthController = TextEditingController();
  final TextEditingController minFeesController = TextEditingController();
  final TextEditingController maxFeesController = TextEditingController();
  final TextEditingController groundDescriptionController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.preGroundDataApi();
    profilController.locationLocalAreaApis('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorLightWhite,
        appBar: AppBar(
          centerTitle: false,
          iconTheme: IconThemeData(color: colorLightWhite),
          title: Text(
            'Register your Ground',
            style: TextStyle(
                color: colorLightWhite, fontSize: context.deviceHeight * .022),
          ),
          backgroundColor: primaryColor,
        ),
        body: Obx(
          () {
            if (controller.isDataLoad.value == true) {
              return LoadingWidget();
            } else {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'Ground Name',
                      controller: groundNameController,
                      required: true,
                    ),
                    _buildTextField(
                      label: 'Address',
                      controller: addressController,
                      required: true,
                    ),
                    _buildCityAutocomplete(),
                    _buildTextField(
                      formatters: [LengthLimitingTextInputFormatter(10)],
                      label: 'Contact Person Name',
                      controller: contactPersonController,
                      required: true,
                    ),
                    _buildTextField(
                      formatters: [LengthLimitingTextInputFormatter(10)],
                      label: 'Primary Contact Number',
                      controller: primaryContactController,
                      keyboardType: TextInputType.phone,
                      required: true,
                    ),
                    _buildTextField(
                      formatters: [LengthLimitingTextInputFormatter(10)],
                      label: 'Secondary Contact Number',
                      controller: secondaryContactController,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildTextField(
                      label: 'Email address',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildBoundaryLengthFields(),
                    _buildPitchTypesSection(controller.pitchType),
                    _buildFacilitiesSection(controller.groundFacilities),
                    _buildFeesSection(),
                    _buildButtons(),
                  ],
                ),
              );
            }
          },
        ));
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      TextInputType? keyboardType,
      bool required = false,
      List<TextInputFormatter>? formatters}) {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: TextFormFieldBig(
            controller: controller,
            isFill: true,
            formatters: formatters,
            fillColor: colorLight1,
            hintText: label + (required ? ' *' : ''),
            maxLines: 1));
  }

  Widget _buildCityAutocomplete() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Autocomplete<Location>(
            optionsBuilder: (TextEditingValue textEditingValue) async {
              if (textEditingValue.text.length < 2) {
                return const Iterable<Location>.empty();
              }

              await profilController
                  .locationLocalAreaApis(textEditingValue.text);
              return profilController.locationLocalAreaData;
            },
            displayStringForOption: (Location option) => option.location ?? '',
            onSelected: (Location selection) {
              controller.selectedCity.value =
                  selection.locationId.toString() ?? '';
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: colorDark1,
                      fontWeight: FontWeight.w400,
                    ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorLight1,
         
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: colorDark3,
                      ),
                               hintText: 'City *',
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
                  suffixIcon: Obx(() => profilController.locationLoad.value
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(colorDark1),
                            ),
                          ),
                        )
                      : SizedBox.shrink()),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a city';
                  }
                  return null;
                },
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width -
                        32, // Adjust based on your padding
                    constraints: BoxConstraints(maxHeight: 200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final option = options.elementAt(index);
                        return InkWell(
                          onTap: () {
                            onSelected(option);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Text(
                              option.location ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: colorDark1,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBoundaryLengthFields() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            label: 'Shortest Length*',
            controller: shortestLengthController,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildTextField(
            label: 'Longest Length*',
            controller: longestLengthController,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildPitchTypesSection(List<PitchType>? pitchType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Pitch Type(s) *',
            style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500)),
        Wrap(
            spacing: 16,
            children: pitchType!
                .map(
                  (pitch) => _buildCheckbox(pitch.typeName.toString(),
                      'pitch_type', pitch.typeId.toString()),
                )
                .toList()),
      ],
    );
  }

  Widget _buildFacilitiesSection(List<GroundFacilities>? facelities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Facilities *',
            style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        Wrap(
            spacing: 16,
            children: facelities!
                .map(
                  (items) => _buildCheckbox(items.facilityName.toString(),
                      'facility', items.facilityId.toString()),
                )
                .toList()),
        controller.showOtherFacilityInput.value == true
            ? TextFormField(
                controller: groundDescriptionController,
                maxLines: 5,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: colorDark1,
                      fontWeight: FontWeight.w400,
                    ),
                onTap: () {
                  // Get.to(TextEditorScreen());
                },
                decoration: InputDecoration(
                    hintText:
                        'Describe your Ground also about timings,amenities,etc...',
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: colorDark3),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: colorDark3, width: .5)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: colorDark3, width: .5))),
              )
            : SizedBox.shrink(),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget _buildCheckbox(String label, String type, String id) {
    return Obx(() {
      // Check if item is selected
      final isSelected = type == 'pitch_type'
          ? controller.selectedPitchTypes.contains(id)
          : controller.selectedFacilities.contains(id);

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            activeColor: primaryColor,
            value: isSelected,
            onChanged: (bool? value) {
              if (type == 'pitch_type') {
                controller.togglePitchType(id, value!);
              } else {
                controller.toggleFacility(id, value!);
                controller.onFacilityChanged(value, label);
              }
              if (kDebugMode) {
                print("Selected Pitch Types: ${controller.selectedPitchTypes}");
                print("Selected Facilities: ${controller.selectedFacilities}");
              }
            },
          ),
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      );
    });
  }

  Widget _buildFeesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fees Range (INR) *',
            style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: TextFormFieldBig(
                    isFill: true,
                    hintText: 'Min Fees*',
                    keyboard: TextInputType.number,
                    controller: minFeesController,
                    fillColor: colorLight1,
                    onChanged: (value) => controller.minFees.value = value,
                    maxLines: 1)),
            SizedBox(width: 16),
            Expanded(
                child: TextFormFieldBig(
                    isFill: true,
                    hintText: 'Max Fees*',
                    keyboard: TextInputType.number,
                    controller: maxFeesController,
                    fillColor: colorLight1,
                    onChanged: (value) => controller.maxFees.value = value,
                    maxLines: 1)),
          ],
        ),
      ],
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
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'CANCEL',
                style: const TextStyle(
                    fontSize: 18,
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
                child: controller.isLoading == true
                    ? LoadingWidget()
                    : Text(
                        'NEXT',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,

                  foregroundColor: Colors.white,
                  backgroundColor: primaryColor, // Set the text color to white
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: controller.validateFees()
                    ? () {
                        controller.setFacilieties(
                            controller.selectedFacilities.value);
                        controller.setPitchType(controller.selectedPitchTypes);
                        if (groundNameController.text.isEmpty ||
                            addressController.text.isEmpty ||
                            contactPersonController.text.isEmpty ||
                            primaryContactController.text.isEmpty ||
                            shortestLengthController.text.isEmpty ||
                            longestLengthController.text.isEmpty ||
                            controller.groundFacilietiesText.value.isEmpty ||
                            controller.pitchTypeText.value.isEmpty ||
                            maxFeesController.text.isEmpty ||
                            minFeesController.text.isEmpty) {
                          print(addressController.text +
                              contactPersonController.text +
                              primaryContactController.text +
                              shortestLengthController.text +
                              longestLengthController.text +
                              controller.groundFacilietiesText.value +
                              controller.pitchTypeText.value +
                              maxFeesController.text +
                              minFeesController.text);
                          Utils.snackBar(
                              "Please fill all required fields !", context);
                        } else {
                          controller
                              .addFullGroundApi(
                                  groundNameController.text,
                                  addressController.text,
                                  contactPersonController.text,
                                  primaryContactController.text,
                                  secondaryContactController.text,
                                  emailController.text,
                                  shortestLengthController.text,
                                  longestLengthController.text,
                                  controller.showOtherFacilityInput.value ==
                                          true
                                      ? "${groundDescriptionController.text} , ${controller.groundFacilietiesText.value}"
                                      : controller.groundFacilietiesText.value,
                                  controller.pitchTypeText.value,
                                  minFeesController.text,
                                  maxFeesController.text)
                              .then((value) {
                            groundNameController.clear();
                            addressController.clear();
                            contactPersonController.clear();
                            primaryContactController.clear();
                            secondaryContactController.clear();
                            emailController.clear();
                            shortestLengthController.clear();
                            longestLengthController.clear();

                            minFeesController.clear();
                            maxFeesController.clear();
                            controller.resetFields();

                            Navigator.pop(context);
                          });
                        }
                        print('Form submitted');
                      }
                    : null,
              );
            }),
          ),
        ],
      ),
    );
  }
}
