import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchValue = true;

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
              "Settings",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                fontStyle: FontStyle.normal,
                color: Color.fromRGBO(57, 55, 56, 1),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 24,
              ),
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                color: const Color.fromRGBO(57, 55, 56, 1),
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/Filters (1).png",
                  scale: 1.0,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 1),
                color: const Color.fromRGBO(204, 204, 204, 1),
                child: Container(
                  height: 926,
                  width: double.maxFinite,
                  color: const Color.fromRGBO(253, 253, 253, 1),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 32,
                      right: 32,
                      top: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Automatic removal of photo evidance",
                                style: TextStyle(
                                  color: Color.fromRGBO(98, 98, 98, 1),
                                  fontSize: 16,
                                  fontFamily: 'Mundial',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              // const SizedBox(width: 20),
                              SizedBox(
                                width: 51,
                                height: 31,
                                child: CupertinoSwitch(
                                  value: switchValue,
                                  onChanged: (value) {
                                    setState(() {
                                      switchValue = value;
                                    });
                                  },
                                  activeTrackColor:
                                      const Color.fromRGBO(52, 199, 89, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "When an assessment is deleted all photo evidence with that assessment will also be deleted from the device.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0X7F626262),
                            fontSize: 10,
                            fontFamily: 'Mundial',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
