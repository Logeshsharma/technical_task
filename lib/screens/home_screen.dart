import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'home_getx.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController panTextController = TextEditingController();
  TextEditingController dobTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  final HomeGetXController homeGetXController = Get.put(HomeGetXController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "S.",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "First of the few steps to set you up with a Bank Account",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "PAN NUMBER",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: panTextController,
                  onChanged: (value) {
                    homeGetXController.updatePanNumberTextController(value);
                  },
                  maxLength: 10,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                  ],
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUI',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.2),
                  decoration: InputDecoration(
                    counterText: '',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter the Pan number",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Colors.black54, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Colors.black54, width: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "BIRTH DATE",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onTap: () {
                    _selectDate(context);
                  },
                  controller: dobTextController,
                  readOnly: true,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUI',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.2),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: "Enter the date of birth",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Colors.black54, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                          const BorderSide(color: Colors.black54, width: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 200),
                Align(alignment: Alignment.bottomCenter, child: bottomWidget())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    "Providing PAN & Date of Birth will help us find and fetch your KYC from central registry by the Government of India.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              TextSpan(
                text: ' Learn more',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Obx(
            () {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: (homeGetXController
                                .panTextController.value.isNotEmpty &&
                            homeGetXController.panTextController.value.length ==
                                10 &&
                            homeGetXController
                                .dobTextController.value.isNotEmpty)
                        ? Colors.deepPurpleAccent
                        : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 160),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                onPressed: (homeGetXController
                            .panTextController.value.isNotEmpty &&
                        homeGetXController.panTextController.value.length ==
                            10 &&
                        homeGetXController.dobTextController.value.isNotEmpty)
                    ? () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  content: const Text(
                                      "Details submitted successfully"),
                                  actions: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.deepPurpleAccent,
                                        ),
                                        onPressed: () {
                                          exit(0);
                                        },
                                        child: Text("Ok"))
                                  ],
                                ));
                      }
                    : null,
                child: const Text('NEXT'),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            exit(0);
          },
          child: const Center(
            child: Text(
              "I don't have a PAN",
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null && picked != selectedDate) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(selectedDate);
      dobTextController.text = formatted;
      homeGetXController.updateDOBTextController(formatted);
    }
  }
}
