import 'package:condition_report/common_widgets/field_heading.dart';
import 'package:condition_report/common_widgets/submit_button.dart';
import 'package:condition_report/models/occupancy_model.dart';
import 'package:condition_report/provider/assessment_provider.dart';
import 'package:condition_report/services/firestore_services.dart';
import 'package:flutter/material.dart';

class Occupancy extends StatefulWidget {
  final Map<String, dynamic>? initialData; // Accepts initial data for editing

  const Occupancy({super.key, this.initialData});

  @override
  State<Occupancy> createState() => _OccupancyState();
}

class _OccupancyState extends State<Occupancy> {
  final TextEditingController _totalOccupantsController =
      TextEditingController();
  final TextEditingController _childrenUnder18Controller =
      TextEditingController();
  final TextEditingController _pensionableMemberController =
      TextEditingController();
  final TextEditingController _specialConsiderationController =
      TextEditingController();
  final TextEditingController _disableMemberController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isLoading = true; // Added for loading state

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    if (widget.initialData != null) {}

    setState(() {
      _totalOccupantsController.text =
          widget.initialData?['totalOccupants']?.toString() ?? '';
      _childrenUnder18Controller.text =
          widget.initialData?['childrenUnder18']?.toString() ?? '';
      _pensionableMemberController.text =
          widget.initialData?['pensionableMembers']?.toString() ?? '';
      _specialConsiderationController.text =
          widget.initialData?['specialConsideration']?.toString() ?? '';
      _disableMemberController.text =
          widget.initialData?['disabledMembers']?.toString() ?? '';
      _isLoading = false; // Data loading completed
    });
  }

  @override
  void dispose() {
    // Dispose controllers
    _totalOccupantsController.dispose();
    _childrenUnder18Controller.dispose();
    _pensionableMemberController.dispose();
    _specialConsiderationController.dispose();
    _disableMemberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        title: const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 12),
          child: Text(
            "Occupancy",
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
        text: "Submit", // Change text based on mode
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();

            // showDialog(
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (context) => const LoadingDialog(),
            // );

            try {
              // Add or update occupancy details
              await FireStoreServices().addOccupancyDetails(
                currentId!, // Use updateId for edit, otherwise a new ID
                OccupancyModel(
                  childrenUnder18: _childrenUnder18Controller.text.trim(),
                  disabledMembers: _disableMemberController.text.trim(),
                  pensionableMembers: _pensionableMemberController.text.trim(),
                  totalOccupants: _totalOccupantsController.text.trim(),
                  specialConsideration:
                      _specialConsiderationController.text.trim(),
                  isAdded: true,
                ),
              );

              // Show success Snackbar
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text("Operation Successful!"),
              //     backgroundColor: Colors.green,
              //   ),
              // );
              Navigator.pop(context); // Close loading dialog
            } catch (e) {
              // Show error Snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error: $e"),
                  backgroundColor: Colors.red,
                ),
              );
            } finally {
              // Navigator.pop(context);
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ConditionReport(),
              //     ));
            }
          }
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
                    color: const Color.fromRGBO(204, 204, 204, 1),
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
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldHeading(
                                  heading: "Total Number of Occupants?"),
                              const SizedBox(height: 5),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Reference Number';
                                  }
                                  return null;
                                },
                                controller: _totalOccupantsController,
                                decoration: InputDecoration(
                                  hintText: "Enter the Total Occupants",
                                ),
                              ),
                              const SizedBox(height: 16),
                              FieldHeading(
                                heading:
                                    "How many children are under the age of 18?",
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Reference Number';
                                  }
                                  return null;
                                },
                                controller: _childrenUnder18Controller,
                                decoration: InputDecoration(
                                  hintText: "Enter the Total Children under 18",
                                ),
                              ),
                              const SizedBox(height: 16),
                              FieldHeading(
                                  heading: "How many of a pensionable age?"),
                              const SizedBox(height: 5),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Reference Number';
                                  }
                                  return null;
                                },
                                controller: _pensionableMemberController,
                                decoration: InputDecoration(
                                  hintText:
                                      "Enter the Total Pensionable Members",
                                ),
                              ),
                              const SizedBox(height: 16),
                              FieldHeading(
                                  heading: "How many with disabilities?"),
                              const SizedBox(height: 5),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Reference Number';
                                  }
                                  return null;
                                },
                                controller: _disableMemberController,
                                decoration: InputDecoration(
                                    hintText:
                                        "Enter the Total Disabled Members"),
                              ),
                              const SizedBox(height: 16),
                              FieldHeading(
                                heading: "Special Considerations (Optional)",
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                maxLines: 3,
                                controller: _specialConsiderationController,
                                decoration: InputDecoration(
                                  hintText: "If any",
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
            ),
    );
  }
}
