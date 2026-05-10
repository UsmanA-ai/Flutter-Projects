import 'package:condition_report/common_widgets/field_heading.dart';
import 'package:condition_report/common_widgets/submit_button.dart';
import 'package:condition_report/models/property_details_model.dart';
import 'package:condition_report/provider/assessment_provider.dart';
import 'package:condition_report/services/firestore_services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PropertyDetails extends StatefulWidget {
  final Map<String, dynamic>? initialData; // Accepts initial data for editing
  final String? updateId;

  const PropertyDetails({super.key, this.initialData, this.updateId});

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  String? elementName1;
  final TextEditingController _propertyContstraintController =
      TextEditingController();
  String? elementName2;
  final TextEditingController _buildingOrientationController =
      TextEditingController();
  bool isAdded = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? selectedPropertyDetachment;
  final List<String> items = ['Semi-Detachment', 'Detachment', 'Item 3'];
  String? selectedExposureZone;
  final List<String> items2 = ['Item 1', 'Item 2', 'Item 3'];
  bool _isLoading = true; // Added for loading state

  List<int> selectedTags = [];
  List<String> options = [
    "Conventional",
    "Traditional",
    "System-build",
    "High rise - cavity wall",
    "High rise - solid wall",
    "Protected - cavity wall",
    "Protected - solid wall"
  ];
  bool showErrorMessages = false; // Flag to control validation message display
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    if (widget.initialData != null) {
      setState(() {
        _propertyContstraintController.text =
            widget.initialData?['propertyConstraint']?.toString() ?? '';
        _buildingOrientationController.text =
            widget.initialData?['buildingOrientation']?.toString() ?? '';
        selectedPropertyDetachment =
            widget.initialData?['propertyDetachment']?.toString();
        selectedExposureZone = widget.initialData?['exposureZone']?.toString();

        // Initialize selectedTags list
        selectedTags.clear();

        if (widget.initialData?['propertyConstruction'] != null) {
          List<String> initialSelections = List<String>.from(
              widget.initialData?['propertyConstruction'] ?? []);

          for (var item in initialSelections) {
            int index = options.indexOf(item);
            if (index != -1) {
              selectedTags.add(index);
            } else {
              // Add new options if they don't exist
              options.add(item);
              selectedTags.add(options.length - 1);
            }
          }
        }

        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _propertyContstraintController.dispose();
    _buildingOrientationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        title: const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 12),
          child: Text(
            "Property Details",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              color: Color.fromRGBO(57, 55, 56, 1),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SubmitButton(
        text: "Submit",
        onPressed: () async {
          // Check if form is valid
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();

            // showDialog(
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (context) => const LoadingDialog(),
            // );

            try {
              // Upload property details to Firebase
              await FireStoreServices().addPropertyDetails(
                currentId!,
                PropertyDetailsModel(
                  buildingOrientation:
                      _buildingOrientationController.text.trim(),
                  exposureZone: selectedExposureZone ?? "",
                  propertyConstraint:
                      _propertyContstraintController.text.trim(),
                  propertyConstruction:
                      selectedTags.map((index) => options[index]).toList(),
                  propertyDetachment: selectedPropertyDetachment ?? "",
                  isAdded: true,
                ),
              );

              // Show success message
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text("Operation Successful!"),
              //     backgroundColor: Colors.green,
              //   ),
              // );
              Navigator.pop(context); // Close loading dialog
            } catch (e) {
              // Show error message if something goes wrong
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Error: $e",
                    style: const TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
            } finally {
              // Navigator.pop(context);

              // // Close the loading dialog
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ConditionReport(),
              //     ));
            }

            // Update the button state to reflect success
            setState(() {
              isAdded = true;
            });
            setState(() {
              showErrorMessages =
                  true; // Show validation messages when submitting
            });
          } else {
            // If form has errors, keep the "Add" button unchanged
            setState(() {
              isAdded = false;
            });
          }

          // Show validation error messages if needed
          setState(() {
            showErrorMessages = true;
          });
        },
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            )) // Show loading spinner
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 1),
                    color: const Color.fromRGBO(204, 204, 204, 0.5),
                    child: Container(
                      height: 926,
                      width: double.infinity,
                      color: const Color.fromRGBO(253, 253, 253, 1),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 32,
                          right: 32,
                          top: 20,
                        ),
                        child: SizedBox(
                          width: 364,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FieldHeading(heading: "Property Constraints"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    // Validator for form field
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Reference Number'; // Return error message
                                    }
                                    return null; // Return null if input is valid
                                  },
                                  controller: _propertyContstraintController,
                                  onChanged: (String value) {
                                    // Track the input value
                                    setState(() {
                                      elementName1 = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter the Property Constraints",
                                  ),
                                ),
                                const SizedBox(height: 16),
                                FieldHeading(heading: "Property Construction"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  readOnly: true,
                                  textAlign: TextAlign.start,
                                  validator: (String? value) {
                                    if (selectedTags.isEmpty) {
                                      return 'Please select at least one option';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: selectedTags.isEmpty
                                        ? "No option selected"
                                        : selectedTags
                                            .map((index) => options[index])
                                            .join(", "),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Wrap(
                                  spacing: 6,
                                  children: List<Widget>.generate(
                                    options.length,
                                    (int index) {
                                      return ChoiceChip(
                                        label: Text(options[index]),
                                        showCheckmark: false,
                                        selected: selectedTags.contains(index),
                                        onSelected: (bool value) {
                                          setState(() {
                                            if (value) {
                                              selectedTags.add(index);
                                            } else {
                                              selectedTags.remove(index);
                                            }
                                          });
                                        },
                                        backgroundColor: const Color.fromRGBO(
                                            98, 98, 98, 0.05),
                                        selectedColor: const Color.fromRGBO(
                                            37, 144, 240, 0.1),
                                        labelStyle: TextStyle(
                                          color: selectedTags.contains(index)
                                              ? const Color.fromRGBO(
                                                  37, 144, 240, 1)
                                              : const Color.fromRGBO(
                                                  57, 55, 56, 0.5),
                                          fontFamily: 'Mundial',
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          side: BorderSide(
                                            color: selectedTags.contains(index)
                                                ? const Color.fromRGBO(
                                                    37, 144, 240, 1)
                                                : const Color.fromRGBO(
                                                    57, 55, 56, 0.1),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                                const SizedBox(height: 16),
                                FieldHeading(heading: "Property Detachment"),
                                const SizedBox(height: 5),
                                Center(
                                  child: DropdownButtonFormField2(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (String? value) {
                                      if (value == null) {
                                        return 'Please select the Option';
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                    isDense: true,
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    value: selectedPropertyDetachment,
                                    hint: const Text(
                                      "Select the Property Detachment",
                                      textAlign: TextAlign.center,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: SvgPicture.asset(
                                        "assets/images/IconV.svg",
                                        height: 24,
                                        width: 24,
                                        color: const Color.fromRGBO(
                                            57, 55, 56, 0.5),
                                      ),
                                    ),
                                    items: items.map((item) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.centerLeft,
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPropertyDetachment = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                FieldHeading(heading: "Building Orientation"),
                                const SizedBox(height: 5),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (String? value) {
                                    // Validator for form field
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Building Orientation'; // Return error message
                                    }
                                    return null; // Return null if input is valid
                                  },
                                  controller: _buildingOrientationController,
                                  onChanged: (String value) {
                                    // Track the input value
                                    setState(() {
                                      elementName2 = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter the Building Orientation",
                                  ),
                                ),
                                const SizedBox(height: 16),
                                FieldHeading(heading: "Exposure Zone"),
                                const SizedBox(height: 5),
                                Center(
                                  child: DropdownButtonFormField2(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (String? value) {
                                      if (value == null) {
                                        return 'Please select the Option';
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                    isDense: true,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(57, 55, 56, 1),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    hint: const Text(
                                      "Select the Exposure Zone",
                                      textAlign: TextAlign.center,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: SvgPicture.asset(
                                        "assets/images/IconV.svg",
                                        height: 24,
                                        width: 24,
                                        color: const Color.fromRGBO(
                                            57, 55, 56, 0.5),
                                      ),
                                    ),
                                    value: selectedExposureZone,
                                    items: items2.map((item) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.centerLeft,
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedExposureZone = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
