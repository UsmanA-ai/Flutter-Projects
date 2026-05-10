import 'dart:developer';
import 'dart:io';

import 'package:condition_report/common_widgets/field_heading.dart';
import 'package:condition_report/common_widgets/submit_button.dart';
import 'package:condition_report/models/general_details_model.dart';
import 'package:condition_report/models/image_detail.dart';
import 'package:condition_report/provider/assessment_provider.dart';
import 'package:condition_report/services/firestore_services.dart';
import 'package:condition_report/services/supabase_services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class GeneralDetails extends StatefulWidget {
  final Map<String, dynamic>? initialData; // Accepts initial data for editing

  const GeneralDetails({super.key, this.initialData});

  @override
  State<GeneralDetails> createState() => _GeneralDetailsState();
}

class _GeneralDetailsState extends State<GeneralDetails> {
  final TextEditingController _refNoController = TextEditingController();
  final TextEditingController _myRefController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _houseNoController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _localiityController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _assessmentDateController =
      TextEditingController();
  String? selectedRegion; // Holds the currently selected value
  String? selectedProperty; // Holds the currently selected value
  bool isAdded = false; // State to track if "Add" button is pressed
  String? button1;
  final List<String> items = ['Yes', 'No'];
  final List<String> region = [
    'England',
    'Wales',
    'Scotland',
    'Northern Ireland'
  ];
  String? selectedRiskAssessment;
  final List<String> items2 = ['Item 1', 'Item 2', 'Item 3'];
  final formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  List<String> imagePaths = [];
  List<DateTime> imageDates = [];
  int imgCount = 0;
  String? selectedImagePath;
  bool isLoading = false; // Track loading state for editing

  fetchGD() async {
    final img = await FireStoreServices().fetchGDImages();
    imgCount = img.length;

    img.isEmpty
        ? []
        : imagePaths = img.map((i) => i['path'] as String).toList();
    // log(imagePaths.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // fetchGD();

    if (widget.initialData != null) {
      setState(() {
        isLoading = true;
      });

      // Assign values to controllers and dropdown
      _refNoController.text = widget.initialData?['refNo'] ?? '';
      _myRefController.text = widget.initialData?['myRef'] ?? '';
      _houseNameController.text = widget.initialData?['houseName'] ?? '';
      _houseNoController.text = widget.initialData?['houseNo'] ?? '';
      _streetController.text = widget.initialData?['street'] ?? '';
      _localiityController.text = widget.initialData?['locality'] ?? '';
      _townController.text = widget.initialData?['town'] ?? '';
      _countryController.text = widget.initialData?['country'] ?? '';
      _postCodeController.text = widget.initialData?['postCode'] ?? '';
      _assessmentDateController.text = widget.initialData?['date'] ?? '';

      // Set selected values
      selectedRegion = widget.initialData?['region'];
      selectedProperty = widget.initialData?['property'];
      selectedRiskAssessment =
          widget.initialData?['riskAssessment']; // Add this line

      setState(() {
        isLoading = false; // Data loading completed
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _refNoController.dispose();
    _myRefController.dispose();
    _houseNameController.dispose();
    _houseNoController.dispose();
    _streetController.dispose();
    _localiityController.dispose();
    _townController.dispose();
    _countryController.dispose();
    _postCodeController.dispose();
    _assessmentDateController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? photo = await _picker.pickImage(source: source);
      if (photo == null) return; // User canceled image picking

      // Capture the current date and time when the image is picked
      DateTime imageDateTime = DateTime.now();

      // Add the image path to the list
      setState(() {
        imagePaths.add(photo.path);
        imageDates.add(imageDateTime);
      });

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OutstandingPhotos(imagePaths: imagePaths),
      //   ),
      // );

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => PhotoStreamScreen(
      //       imagePaths: imagePaths,
      //       imageDates: imageDates,
      //     ),
      //   ),
      // );
    } catch (e) {
      print('Error picking or processing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        title: const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 12),
          child: Text(
            "General Details",
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
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            // Show the loading dialog
            // showDialog(
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (context) => const LoadingDialog(),
            // );
            try {
              // Upload General Details to Firestore
              await FireStoreServices().addGeneralDetails(
                currentId!, // Use updateId for edit, otherwise a new ID
                GeneralDetailsModel(
                  riskAssessment: selectedRiskAssessment ?? "",
                  property: selectedProperty ?? "",
                  refNo: _refNoController.text.trim(),
                  myRef: _myRefController.text.trim(),
                  region: selectedRegion ?? "",
                  houseName: _houseNameController.text.trim(),
                  houseNo: _houseNoController.text.trim(),
                  street: _streetController.text.trim(),
                  locality: _localiityController.text.trim(),
                  country: _countryController.text.trim(),
                  town: _townController.text.trim(),
                  postCode: _postCodeController.text.trim(),
                  date: _assessmentDateController.text.trim(),
                  isAdded: true,
                ),
              );

              if (imagePaths.isNotEmpty) {
                try {
                  // Use Future.wait for concurrent uploads
                  await Future.wait(
                    imagePaths.map((imagePath) async {
                      String? url = await SupabaseServices()
                          .uploadImageToSupabase(context, imagePath);

                      if (url != null) {
                        await FireStoreServices().addImage(
                          currentId!,
                          ImageDetail(
                            id: "gd",
                            location: "General Details",
                            path: url,
                            subSelection: "Sub Selection",
                          ),
                        );
                      } else {
                        log('Image upload failed for: $imagePath');
                      }
                    }),
                  );
                } catch (e) {
                  log('Error during upload or save: $e');
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text("An error occurred: $e")),
                  // );
                }
              }

              // Show success Snackbar
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text("Operation Successful!"),
              //     backgroundColor: Colors.green,
              //   ),
              // );
              Navigator.pop(context);
            } catch (e) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error adding data: $e"),
                  backgroundColor: Colors.red,
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

            // Update the button state to reflect the success
            setState(() {
              isAdded = true;
            });
          } else {
            // If form has errors, keep the "Add" button unchanged
            setState(() {
              isAdded = false;
            });
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 1),
              color: const Color.fromRGBO(204, 204, 204, 1),
              child: Container(
                height: 1800,
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
                          FieldHeading(
                            heading: "Reference",
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Reference Number';
                              }
                              return null;
                            },
                            controller: _refNoController,
                            onChanged: (String value) {},
                            decoration: InputDecoration(
                              hintText: "Enter Reference Number",
                              suffixIcon: IconButton(
                                style: const ButtonStyle(
                                    splashFactory: NoSplash.splashFactory),
                                onPressed: () {
                                  // log("Image Dates[] : $imageDates");
                                  // log("Image Path[] : $imagePaths");
                                  // log("SelectedImagePath : $selectedImagePath");
                                  _showImageSourceSelection();
                                },
                                icon: SvgPicture.asset(
                                  "assets/images/camera (1).svg",
                                  color: const Color.fromRGBO(57, 55, 56, 0.5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  spacing: 5,
                                  runSpacing: 5,
                                  children:
                                      List.generate(imagePaths.length, (index) {
                                    log(imagePaths.length.toString());
                                    return SizedBox(
                                      height: 36,
                                      width: 36,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            height: 36,
                                            width: 36,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.2),
                                              image: DecorationImage(
                                                image: FileImage(
                                                    File(imagePaths[index])),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                imagePaths.removeAt(index);
                                              });
                                            },
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      2.65),
                                                  child: SvgPicture.asset(
                                                    "assets/images/Ellipse 270.svg",
                                                    height: 10,
                                                    width: 10,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      1.39),
                                                  child: SvgPicture.asset(
                                                    "assets/images/Group 1353 (1).svg",
                                                    height: 6.25,
                                                    width: 6.25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "My Reference"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _myRefController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please enter Reference Number'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            // onChanged: (String value) {
                            //   // Track the input value
                            //   setState(() {
                            //     elementName = value;
                            //   });
                            // },
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(57, 55, 56, 1),
                            ),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                hintText: 'Enter the Reference Number'),
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "Regs Region"),
                          const SizedBox(height: 5),
                          DropdownButtonFormField2<String>(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please select the Option'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0X19626262),
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                                borderSide: const BorderSide(
                                  color: Color(0X19626262),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                                borderSide: const BorderSide(
                                  color: Color(0X19626262),
                                  width: 2,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                                borderSide: const BorderSide(
                                  color: Color(0X19626262),
                                  width: 2,
                                ),
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 0, right: 16, top: 18, bottom: 18),
                            ),
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
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),

                            value: selectedRegion,
                            // isExpanded: true,
                            // isDense: true,
                            hint: Text("Select a region"), // Placeholder text
                            items: region
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e, // Set value for each item
                                    child: Text(e),
                                  ),
                                )
                                .toList(),

                            onChanged: (value) {
                              setState(() {
                                selectedRegion =
                                    value; // Update the selected value
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _houseNameController.clear();
                                    _houseNoController.clear();
                                    _streetController.clear();
                                    _localiityController.clear();
                                    _townController.clear();
                                    _countryController.clear();
                                    _postCodeController.clear();
                                    _assessmentDateController.clear();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color.fromRGBO(
                                            255, 59, 48, 0.2),
                                      ),
                                      color: const Color.fromRGBO(
                                          255, 59, 48, 0.1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/Clear.svg",
                                            height: 24,
                                            width: 24,
                                            color: const Color.fromRGBO(
                                              255,
                                              59,
                                              48,
                                              1,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "Clear Address",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Mundial',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w300,
                                              color: Color.fromRGBO(
                                                  255, 59, 48, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color.fromRGBO(
                                            52, 199, 89, 0.2),
                                      ),
                                      color: const Color.fromRGBO(
                                          52, 199, 89, 0.1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/search.svg",
                                            height: 24,
                                            width: 24,
                                            color: const Color.fromRGBO(
                                              52,
                                              199,
                                              89,
                                              1,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "Find Address",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Mundial',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w300,
                                              color: Color.fromRGBO(
                                                  52, 199, 89, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(
                              heading:
                                  "Is the property of traditional construction?"),
                          const SizedBox(height: 5),
                          DropdownButtonFormField2(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please select the Option'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            isExpanded: true,
                            isDense: true,
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            value: selectedProperty,
                            hint: const Text(
                              "Select the Property construction",
                              textAlign: TextAlign.center,
                            ),
                            iconStyleData: IconStyleData(
                              icon: SvgPicture.asset(
                                "assets/images/IconV.svg",
                                height: 24,
                                width: 24,
                                color: const Color.fromRGBO(57, 55, 56, 0.5),
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
                                selectedProperty = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "House Name"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _houseNameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please enter House Name'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            // onChanged: (String value) {
                            //   // Track the input value
                            //   // setState(() {
                            //   //   elementName = value;
                            //   // });
                            // },

                            decoration: InputDecoration(
                                hintText: 'Enter the House Name'),
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "House Number"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _houseNoController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please enter House Name'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            // onChanged: (String value) {
                            //   // Track the input value
                            //   setState(() {
                            //     elementName = value;
                            //   });
                            // },
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(57, 55, 56, 1),
                            ),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                hintText: 'Enter the House Number'),
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "Street"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _streetController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Street'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            // onChanged: (String value) {
                            //   // Track the input value
                            //   setState(() {
                            //     elementName = value;
                            //   });
                            // },
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(57, 55, 56, 1),
                            ),
                            textAlign: TextAlign.start,
                            decoration:
                                InputDecoration(hintText: 'Enter the Street'),
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "Locality"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _localiityController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Locality'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            // onChanged: (String value) {
                            //   // Track the input value
                            //   setState(() {
                            //     elementName = value;
                            //   });
                            // },
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(57, 55, 56, 1),
                            ),
                            textAlign: TextAlign.start,
                            decoration:
                                InputDecoration(hintText: "Enter the Locality"),
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "Town"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _townController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Town'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            // onChanged: (String value) {
                            //   // Track the input value
                            //   setState(() {
                            //     elementName = value;
                            //   });
                            // },
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(57, 55, 56, 1),
                            ),
                            textAlign: TextAlign.start,
                            decoration:
                                InputDecoration(hintText: "Enter the Town"),
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "Country"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _countryController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Country'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            // onChanged: (String value) {
                            //   // Track the input value
                            //   setState(() {
                            //     elementName = value;
                            //   });
                            // },
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(57, 55, 56, 1),
                            ),
                            textAlign: TextAlign.start,
                            decoration:
                                InputDecoration(hintText: "Enter the Country"),
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "Postcode"),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _postCodeController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please enter your PostCode'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            // onChanged: (String value) {
                            //   // Track the input value
                            //   setState(() {
                            //     elementName = value;
                            //   });
                            // },
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(57, 55, 56, 1),
                            ),
                            textAlign: TextAlign.start,
                            decoration:
                                InputDecoration(hintText: "Enter the Postcode"),
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "Risk Assessment path"),
                          const SizedBox(height: 5),
                          DropdownButtonFormField2(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              // Validator for form field
                              if (value == null || value.isEmpty) {
                                return 'Please select the Option'; // Return error message
                              }
                              return null; // Return null if input is valid
                            },
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            value: selectedRiskAssessment,
                            hint: const Text(
                              "Select the Assessment Path",
                              textAlign: TextAlign.center,
                            ),
                            iconStyleData: IconStyleData(
                              icon: SvgPicture.asset(
                                "assets/images/IconV.svg",
                                height: 24,
                                width: 24,
                                color: const Color.fromRGBO(57, 55, 56, 0.5),
                              ),
                            ),
                            items: items2.map((item) {
                              return DropdownMenuItem<String>(
                                alignment: Alignment.centerLeft,
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedRiskAssessment = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          FieldHeading(heading: "Assessment Date"),
                          const SizedBox(height: 5),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select the Date';
                              }
                              return null;
                            },
                            controller:
                                _assessmentDateController, // Correct controller
                            onTap: () {
                              selectdate();
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Select the Assessment Date",
                              suffixIcon: IconButton(
                                style: const ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                onPressed: () {
                                  // Optional action for suffix icon
                                },
                                icon: SvgPicture.asset(
                                  "assets/images/IconD.svg",
                                  color: const Color.fromRGBO(57, 55, 56, 0.5),
                                ),
                              ),
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

  Future<void> selectdate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        // Update the correct controller
        _assessmentDateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  void _showImageSourceSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Pick from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }
}
