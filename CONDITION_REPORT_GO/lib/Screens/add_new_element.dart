import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:condition_report/Screens/outstanding_photos.dart';
import 'package:condition_report/Screens/photo_stream.dart';
import 'package:condition_report/common_widgets/submit_button.dart';
import 'package:condition_report/models/image_detail.dart';
import 'package:condition_report/models/new_element_model.dart';
import 'package:condition_report/provider/assessment_provider.dart';
import 'package:condition_report/services/firestore_services.dart';
import 'package:condition_report/services/supabase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class AddNewElement extends StatefulWidget {
  final Map<String, dynamic>? map;
  const AddNewElement({super.key, this.map});

  @override
  State<AddNewElement> createState() => _AddNewElementState();
}

class _AddNewElementState extends State<AddNewElement> {
  final TextEditingController elementNameController = TextEditingController();
  final TextEditingController conditionSummaryController =
      TextEditingController();
  final TextEditingController addNotesController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? selectedElementType;
  String? selectedElement;
  String? isWindow;
  String? isUnderCut;
  String? isTrickleEvent;
  String? isFluedHeating;
  String? isGapInUnderCut;
  String? isFanFitted;
  String? isExistingVentilation;
  String? isDamp;
  List<String>? conditionSummaryImage;
  List<String>? trickleEventImage;
  List<String>? internalDoorImage;
  String barTitle = "New Element";
  @override
  void initState() {
    super.initState();
    elementNameController.addListener(() => setState(() => barTitle =
        elementNameController.text.isEmpty
            ? "New Element"
            : elementNameController.text));

    if (widget.map != null) {
      elementNameController.text = widget.map!['elementName']; // Adjusted name
      conditionSummaryController.text = widget.map!['conditionSummaryText']
          .toString(); // Adjusted for image list
      addNotesController.text =
          widget.map!['additionalNotes'] ?? ''; // Added null check

      selectedElementType = widget.map!['selectedElementType'];
      selectedElement = widget.map!['selectedElement'];
      isWindow = widget.map!['isWindow'];
      isUnderCut = widget.map!['isUnderCut'];
      isTrickleEvent = widget.map!['isTrickleEvent'];
      isFluedHeating = widget.map!['isFluedHeating'];
      isGapInUnderCut = widget.map!['isGapInUnderCut'];
      isFanFitted = widget.map!['isFanFitted'];
      isExistingVentilation = widget.map!['isExistingVentilation'];
      isDamp = widget.map!['isDamp'];
      conditionSummaryImage =
          (widget.map!['conditionSummaryImage'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList();
      trickleEventImage = (widget.map!['trickleEventImage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();
      internalDoorImage = (widget.map!['internalDoorImage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList();

      // button1 = selectedElement;
      // button2 = selectedElementType;
    }
  }

  @override
  void dispose() {
    elementNameController.dispose();
    super.dispose();
  }

  String? selectedImagePath;
  // DateTime _imageDateTime = DateTime.now();

  List<String> camera1Images = [];
  List<String> camera2Images = [];
  List<String> camera3Images = [];

  List<DateTime> camera1ImageDates = [];
  List<DateTime> camera2ImageDates = [];
  List<DateTime> camera3ImageDates = [];

  Future<void> _requestPermissions() async {
    await Permission.storage.request();
    await Permission.camera.request();
    await Permission.photos.request();
  }

  Future<void> _pickImage(ImageSource source, int cameraIndex) async {
    try {
      final PermissionStatus storageStatus = await Permission.storage.status;
      final PermissionStatus cameraStatus = await Permission.camera.status;
      final PermissionStatus photosStatus = await Permission.photos.status;

      if (storageStatus.isDenied ||
          cameraStatus.isDenied ||
          photosStatus.isDenied) {
        await _requestPermissions();
      }
      final XFile? photo = await _picker.pickImage(source: source);
      if (photo == null) return; // User canceled image picking

      // Capture the current date and time when the image is picked
      DateTime imageDateTime = DateTime.now();

      setState(() {
        if (cameraIndex == 1) {
          camera1Images.add(photo.path);
          camera1ImageDates.add(imageDateTime);
        } else if (cameraIndex == 2) {
          camera2Images.add(photo.path);
          camera2ImageDates.add(imageDateTime);
        } else if (cameraIndex == 3) {
          camera3Images.add(photo.path);
          camera3ImageDates.add(imageDateTime);
        }
      });

      // Upload the image to Firebase Storage
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference ref = storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(File(photo.path));

      // Get the download URL of the uploaded image
      final String downloadUrl = await ref.getDownloadURL();

      // Add the image path to the list
      setState(() {
        if (cameraIndex == 1) {
          camera1Images[camera1Images.length - 1] = downloadUrl;
        } else if (cameraIndex == 2) {
          camera2Images[camera2Images.length - 1] = downloadUrl;
        } else if (cameraIndex == 3) {
          camera3Images[camera3Images.length - 1] = downloadUrl;
        }
      });
      // Navigate to Outstanding Photos and PhotoStream screens
      List<String> imagePaths;
      if (cameraIndex == 1) {
        imagePaths = camera1Images;
      } else if (cameraIndex == 2) {
        imagePaths = camera2Images;
      } else {
        imagePaths = camera3Images;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutstandingPhotos(imagePaths: imagePaths),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoStreamScreen(
              // imagePaths: imagePaths,
              // imageDates: imageDates,
              ),
        ),
      );
      setState(() {});
    } catch (e) {
      if (e is FirebaseException) {
        print('Firebase error: ${e.code}');
      } else {
        print('Error picking or processing image: $e');
      }
    }
  }

  String? button1;
  String? button2;
  final Map<String, List<String>> items = {
    'Internal': [
      'Add own element',
      'Bathroom',
      'Bedroom 1',
      'Bedroom 2',
      'Bedroom 3',
      'Bedroom 4',
      'Bedroom 5',
      'Cloakroom',
      'Conservatory',
      'Dining room',
      'Dressing room',
      'Ensuite',
      'Hall',
      'Kitchen',
      'Kitchen dinner',
      'Landing',
      'Living room',
      'Lounge',
      'Lounge dinner',
      'Playroom',
      'Sitting room',
      'Study',
      'Utility room',
    ],
    'External': [
      'Add own element',
      'Basement',
      'External Elevation',
      'Integrated Garage',
      'Loft',
    ],
  };
  String? button3;
  final List<String> items3 = ['Yes', 'No'];
  String? button4;
  final List<String> items4 = ['Yes', 'No'];
  String? button5;
  final List<String> items5 = ['Yes', 'No'];
  String? button6;
  final List<String> items6 = ['Yes', 'No'];
  String? button7;
  final List<String> items7 = ['Yes', 'No'];
  String? button8;
  final List<String> items8 = ['Yes', 'No'];
  String? button9;
  final List<String> items9 = ['Yes', 'No'];
  String? button10;
  final List<String> items10 = ['Yes', 'No'];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        title: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 12),
          child: Text(
            // "Bedroom 1",
            barTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              color: Color.fromRGBO(57, 55, 56, 1),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SubmitButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // showDialog(
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (context) => const LoadingDialog(),
            // );

            try {
              FireStoreServices().createNewElement(
                elementNameController.text.trim(),
                NewElementModel(
                  conditionSummaryText: conditionSummaryController.text.trim(),
                  elementName: elementNameController.text.trim(),
                  isDamp: isDamp ?? "",
                  isExistingVentilation: isExistingVentilation ?? "",
                  isFanFitted: isFanFitted ?? "",
                  isFluedHeating: isFluedHeating ?? "",
                  isGapInUnderCut: isGapInUnderCut ?? "",
                  isTrickleEvent: isTrickleEvent ?? "",
                  isUnderCut: isUnderCut ?? "",
                  isWindow: isWindow ?? "",
                  selectedElement: selectedElement ?? "",
                  selectedElementType: selectedElementType ?? "",
                  additionalNotes: addNotesController.text.trim(),
                  conditionSummaryImage: conditionSummaryImage ?? [],
                  internalDoorImage: internalDoorImage ?? [],
                  trickleEventImage: trickleEventImage ?? [],
                ),
              );

              if (camera1Images.isNotEmpty) {
                await Future.wait(
                  camera1Images.map((imagePath) async {
                    String? url = await SupabaseServices()
                        .uploadImageToSupabase(context, imagePath);

                    if (url != null) {
                      await FireStoreServices().addImage(
                        currentId!,
                        ImageDetail(
                          id: "${elementNameController.text.trim()}1",
                          location: elementNameController.text.trim(),
                          path: url,
                          subSelection: "Sub Selection",
                        ),
                      );
                    } else {
                      log('Image upload failed for: $imagePath');
                    }
                  }).toList(), // ✅ Convert iterable to List<Future>
                );
              }
              if (camera2Images.isNotEmpty) {
                await Future.wait(
                  camera2Images.map((imagePath) async {
                    String? url = await SupabaseServices()
                        .uploadImageToSupabase(context, imagePath);

                    if (url != null) {
                      await FireStoreServices().addImage(
                        currentId!,
                        ImageDetail(
                          id: "${elementNameController.text.trim()}2",
                          location: elementNameController.text.trim(),
                          path: url,
                          subSelection: "Sub Selection",
                        ),
                      );
                    } else {
                      log('Image upload failed for: $imagePath');
                    }
                  }).toList(), // ✅ Convert iterable to List<Future>
                );
              }
              if (camera3Images.isNotEmpty) {
                await Future.wait(
                  camera3Images.map((imagePath) async {
                    String? url = await SupabaseServices()
                        .uploadImageToSupabase(context, imagePath);

                    if (url != null) {
                      await FireStoreServices().addImage(
                        currentId!,
                        ImageDetail(
                          id: "${elementNameController.text.trim()}3",
                          location: elementNameController.text.trim(),
                          path: url,
                          subSelection: "Sub Selection",
                        ),
                      );
                    } else {
                      log('Image upload failed for: $imagePath');
                    }
                  }).toList(), // ✅ Convert iterable to List<Future>
                );
              }

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
              Navigator.pop(context);
            }
          }
        },
        text: "Submit",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 1),
              color: const Color.fromRGBO(204, 204, 204, 1),
              child: Container(
                height: 1900,
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
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: SizedBox(
                                  height: 24,
                                  width: 330,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      "Is this element internal or external?",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(98, 98, 98, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 364,
                                child: Center(
                                  child: DropdownButtonFormField2(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
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
                                          left: 0,
                                          right: 16,
                                          top: 18,
                                          bottom: 18),
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
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    value: selectedElementType,
                                    hint: const Text("Select the Element"),
                                    items: items.keys.map((String key) {
                                      return DropdownMenuItem<String>(
                                        value: key,
                                        child: Text(key),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedElementType = value;
                                        // Reset selectedElement if the type changes
                                        selectedElement = null;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select element';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: SizedBox(
                                      height: 24,
                                      width: 330,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Text(
                                          "Please select your element",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(98, 98, 98, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 364,
                                    child: Center(
                                      child: DropdownButtonFormField2(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
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
                                              left: 0,
                                              right: 16,
                                              top: 18,
                                              bottom: 18),
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
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        value: selectedElement,
                                        hint: const Text("Select the Element"),
                                        items:
                                            (items[selectedElementType] ?? [])
                                                .map((item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedElement = value;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select the element';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: SizedBox(
                                  height: 24,
                                  width: 330,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Text("Element Name",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromRGBO(98, 98, 98, 1),
                                        )),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 364,
                                child: Center(
                                  child: TextFormField(
                                    controller: elementNameController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Element Name';
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(57, 55, 56, 1),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Enter the Element Name",
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(57, 55, 56, 0.5),
                                      ),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: SizedBox(
                                  height: 24,
                                  width: 330,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Text("Condition Summary",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromRGBO(98, 98, 98, 1),
                                        )),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 364,
                                child: Center(
                                  child: TextFormField(
                                    controller: conditionSummaryController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Condition Summary';
                                      }
                                      return null;
                                    },
                                    onTap: () {},
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(57, 55, 56, 1),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Enter Condition Summary",
                                      hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(57, 55, 56, 0.5),
                                      ),
                                      suffixIcon: IconButton(
                                        style: const ButtonStyle(
                                            splashFactory:
                                                NoSplash.splashFactory),
                                        onPressed: () =>
                                            _showImageSourceSelection(1),
                                        icon: SvgPicture.asset(
                                          "assets/images/camera (1).svg",
                                          color: const Color.fromRGBO(
                                              57, 55, 56, 0.5),
                                        ),
                                      ),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 18),
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
                                      children: List.generate(
                                          camera1Images.length, (index) {
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
                                                      BorderRadius.circular(
                                                          6.2),
                                                  image: DecorationImage(
                                                    image: camera1Images[index]
                                                            .startsWith('http')
                                                        ? NetworkImage(
                                                            camera1Images[
                                                                index])
                                                        : FileImage(File(
                                                            camera1Images[
                                                                index])),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    camera1Images
                                                        .removeAt(index);
                                                  });
                                                },
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.65),
                                                      child: SvgPicture.asset(
                                                        "assets/images/Ellipse 270.svg",
                                                        height: 10,
                                                        width: 10,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
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
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (selectedElementType == "Internal")
                            Column(
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: SizedBox(
                                        height: 28,
                                        width: 330,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Text("Ventilation",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromRGBO(
                                                    28, 28, 28, 1),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: SizedBox(
                                        height: 24,
                                        width: 330,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Text(
                                              "Does the room have any windows?",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromRGBO(
                                                    98, 98, 98, 1),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 364,
                                      child: Center(
                                        child: DropdownButtonFormField2(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 0,
                                                    right: 16,
                                                    top: 18,
                                                    bottom: 18),
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(57, 55, 56, 1),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          value: isWindow,
                                          hint: const Text(
                                            "Select the Option",
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
                                          items: items3.map((options1) {
                                            return DropdownMenuItem<String>(
                                              alignment: Alignment.centerLeft,
                                              value: options1,
                                              child: Text(options1),
                                            );
                                          }).toList(),
                                          validator: (String? value) {
                                            if (value == null) {
                                              return 'Please select the option';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              isWindow = value;
                                              // button3 = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: SizedBox(
                                        // height: 24,
                                        width: 330,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Text(
                                              "Are the undercuts on all the internal doors?",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromRGBO(
                                                    98, 98, 98, 1),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      // height: 82,
                                      width: 364,
                                      child: Center(
                                        child: DropdownButtonFormField2(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            // helperText: "",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    right: 16,
                                                    top: 18,
                                                    bottom: 18),
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(57, 55, 56, 1),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          value: isUnderCut,
                                          hint: const Text(
                                            "Select the Option",
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
                                          items: items4.map((option2) {
                                            return DropdownMenuItem<String>(
                                              alignment: Alignment.centerLeft,
                                              value: option2,
                                              child: Text(option2),
                                            );
                                          }).toList(),
                                          validator: (String? value) {
                                            if (value == null) {
                                              return 'Please select the option';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              isUnderCut = value;
                                              // button4 = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: SizedBox(
                                        height: 24,
                                        width: 330,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child:
                                              Text("Do they have trickle vents",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w300,
                                                    color: Color.fromRGBO(
                                                        98, 98, 98, 1),
                                                  )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      // height: 82,
                                      width: 364,
                                      child: Center(
                                        child: DropdownButtonFormField2(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            // helperText: "",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    right: 16,
                                                    top: 18,
                                                    bottom: 18),
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(57, 55, 56, 1),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          value: isTrickleEvent,
                                          hint: const Text(
                                            "Enter Condition Summary",
                                            textAlign: TextAlign.center,
                                          ),
                                          iconStyleData: IconStyleData(
                                            icon: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/IconV.svg",
                                                  height: 24,
                                                  width: 24,
                                                  color: const Color.fromRGBO(
                                                      57, 55, 56, 0.5),
                                                ),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () =>
                                                      _showImageSourceSelection(
                                                          2),
                                                  child: SvgPicture.asset(
                                                    "assets/images/camera (1).svg",
                                                    color: const Color.fromRGBO(
                                                        57, 55, 56, 0.5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          items: items5.map((option3) {
                                            return DropdownMenuItem<String>(
                                              alignment: Alignment.centerLeft,
                                              value: option3,
                                              child: Text(option3),
                                            );
                                          }).toList(),
                                          validator: (String? value) {
                                            if (value == null) {
                                              return 'Please enter Condition Summary';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              isTrickleEvent = value;
                                              // button5 = value;
                                            });
                                          },
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
                                            children: List.generate(
                                                camera2Images.length, (index) {
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
                                                            BorderRadius
                                                                .circular(6.2),
                                                        image: DecorationImage(
                                                          // image: FileImage(File(
                                                          //     camera2Images[index])),
                                                          image: NetworkImage(
                                                              camera1Images[
                                                                  index]),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          camera2Images
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.65),
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/images/Ellipse 270.svg",
                                                              height: 10,
                                                              width: 10,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1.39),
                                                            child: SvgPicture
                                                                .asset(
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
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: SizedBox(
                                        // height: 24,
                                        width: 330,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Text(
                                              "Is there any open-flued heating appliance within this room?",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromRGBO(
                                                    98, 98, 98, 1),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      // height: 82,
                                      width: 364,
                                      child: Center(
                                        child: DropdownButtonFormField2(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            // helperText: "",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    right: 16,
                                                    top: 18,
                                                    bottom: 18),
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(57, 55, 56, 1),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          value: isFluedHeating,
                                          hint: const Text(
                                            "Select the Option",
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
                                          items: items6.map((option4) {
                                            return DropdownMenuItem<String>(
                                              alignment: Alignment.centerLeft,
                                              value: option4,
                                              child: Text(option4),
                                            );
                                          }).toList(),
                                          validator: (String? value) {
                                            if (value == null) {
                                              return 'Please select the option';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              isFluedHeating = value;
                                              // button6 = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: SizedBox(
                                        // height: 24,
                                        width: 330,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Text(
                                              "Are the undercuts on all the internal doors (7.6mm gap on a one meter door)?",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromRGBO(
                                                    98, 98, 98, 1),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      // height: 82,
                                      width: 364,
                                      child: Center(
                                        child: DropdownButtonFormField2(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    right: 16,
                                                    top: 18,
                                                    bottom: 18),
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(57, 55, 56, 1),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          value: isGapInUnderCut,
                                          hint: const Text(
                                            "Enter Condition Summary",
                                            textAlign: TextAlign.center,
                                          ),
                                          iconStyleData: IconStyleData(
                                            icon: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/IconV.svg",
                                                  height: 24,
                                                  width: 24,
                                                  color: const Color.fromRGBO(
                                                      57, 55, 56, 0.5),
                                                ),
                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () =>
                                                      _showImageSourceSelection(
                                                          3),
                                                  child: SvgPicture.asset(
                                                    "assets/images/camera (1).svg",
                                                    color: const Color.fromRGBO(
                                                        57, 55, 56, 0.5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          items: items7.map((options5) {
                                            return DropdownMenuItem<String>(
                                              alignment: Alignment.centerLeft,
                                              value: options5,
                                              child: Text(options5),
                                            );
                                          }).toList(),
                                          validator: (String? value) {
                                            if (value == null) {
                                              return 'Please enter Condition Summary';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              isGapInUnderCut = value;
                                              // button7 = value;
                                            });
                                          },
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
                                            children: List.generate(
                                                camera3Images.length, (index) {
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
                                                            BorderRadius
                                                                .circular(6.2),
                                                        image: DecorationImage(
                                                          // image: FileImage(File(
                                                          //     camera3Images[index])),
                                                          image: NetworkImage(
                                                              camera1Images[
                                                                  index]),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          camera3Images
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.65),
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/images/Ellipse 270.svg",
                                                              height: 10,
                                                              width: 10,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1.39),
                                                            child: SvgPicture
                                                                .asset(
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
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: SizedBox(
                                        // height: 24,
                                        width: 330,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Text(
                                              "Does the room have intermittent extract fans fitted?",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromRGBO(
                                                    98, 98, 98, 1),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      // height: 82,
                                      width: 364,
                                      child: Center(
                                        child: DropdownButtonFormField2(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            // helperText: "",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    right: 16,
                                                    top: 18,
                                                    bottom: 18),
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(57, 55, 56, 1),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          value: isFanFitted,
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
                                          items: items8.map((options6) {
                                            return DropdownMenuItem<String>(
                                              alignment: Alignment.centerLeft,
                                              value: options6,
                                              child: Text(options6),
                                            );
                                          }).toList(),
                                          validator: (String? value) {
                                            if (value == null) {
                                              return 'Please select the option';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              isFanFitted = value;
                                              // button8 = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: SizedBox(
                                        // height: 24,
                                        width: 330,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Text(
                                              "Are there any other existing ventilation systems present in this room?",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromRGBO(
                                                    98, 98, 98, 1),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      // height: 82,
                                      width: 364,
                                      child: Center(
                                        child: DropdownButtonFormField2(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            // helperText: "",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    right: 16,
                                                    top: 18,
                                                    bottom: 18),
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(57, 55, 56, 1),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          value: isExistingVentilation,
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
                                          items: items9.map((options7) {
                                            return DropdownMenuItem<String>(
                                              alignment: Alignment.centerLeft,
                                              value: options7,
                                              child: Text(options7),
                                            );
                                          }).toList(),
                                          validator: (String? value) {
                                            if (value == null) {
                                              return 'Please select the option';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              isExistingVentilation = value;
                                              // button9 = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: SizedBox(
                                        // height: 24,
                                        width: 330,
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Text(
                                              "Is there any evidence of condensation, damp or mould growth in this room?",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Color.fromRGBO(
                                                    98, 98, 98, 1),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      // height: 82,
                                      width: 364,
                                      child: Center(
                                        child: DropdownButtonFormField2(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            // helperText: "",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                16,
                                              ),
                                              borderSide: const BorderSide(
                                                color: Color(0X19626262),
                                                width: 2,
                                              ),
                                            ),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    right: 16,
                                                    top: 18,
                                                    bottom: 18),
                                          ),
                                          isExpanded: true,
                                          isDense: true,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(57, 55, 56, 1),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          value: isDamp,
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
                                          items: items10.map((options8) {
                                            return DropdownMenuItem<String>(
                                              alignment: Alignment.centerLeft,
                                              value: options8,
                                              child: Text(options8),
                                            );
                                          }).toList(),
                                          validator: (String? value) {
                                            if (value == null) {
                                              return 'Please select the option';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              isDamp = value;
                                              // button10 = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: SizedBox(
                                  height: 24,
                                  width: 330,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Text("Additional notes",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color: Color.fromRGBO(98, 98, 98, 1),
                                        )),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                constraints: const BoxConstraints(
                                  minHeight:
                                      100, // Default height of the container
                                ),
                                width: 364,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color:
                                        const Color.fromRGBO(98, 98, 98, 0.1),
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 19),
                                  child: CupertinoTextFormFieldRow(
                                    controller: addNotesController,
                                    textAlign: TextAlign.start,
                                    maxLines: null, // Allows for multiple lines
                                    keyboardType: TextInputType
                                        .multiline, // Keyboard suited for multiline
                                    placeholder: "If any! (optional)",
                                    placeholderStyle: const TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(57, 55, 56, 0.5),
                                    ),
                                    padding: EdgeInsets.zero,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(57, 55, 56, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

  void _showImageSourceSelection(int cameraIndex) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera, cameraIndex);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('Pick from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery, cameraIndex);
              },
            ),
          ],
        );
      },
    );
  }
}
