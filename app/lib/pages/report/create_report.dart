import 'dart:io';

import 'package:app/pages/home/home.dart';
import 'package:app/pages/report/components/add_picture.dart';
import 'package:app/pages/report/components/button_type.dart';
import 'package:app/pages/report/components/description_text_field.dart';
import 'package:app/pages/report/components/map_report_create.dart';
import 'package:app/pages/report/components/time_picker.dart';
import 'package:app/services/report/report.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _imageFile;
  String? _selectedType;
  int _selectedTime = 0;
  LatLng? _location;

  void _onTypeSelected(String type) {
    setState(() {
      _selectedType = type;
    });
  }

  void _onTimeSelected(int time) {
    setState(() {
      _selectedTime = time;
    });
  }

  void _onLocationChange(LatLng loc) {
    setState(() {
      _location = loc;
    });
  }

  String _createDateString(int minutesAgo) {
    final now = DateTime.now();
    final date =
        minutesAgo == 0 ? now : now.subtract(Duration(minutes: minutesAgo));
    // 2024-05-15T15:56:32.037Z
    return '${date.year}-${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day}T${date.hour < 10 ? '0${date.hour}' : date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute}:${date.second < 10 ? '0${date.second}' : date.second}.000Z';
  }

  Future<bool> createReport() async {
    var res = await ReportService.createReport(
        File(_imageFile!.path),
        _topicController.text,
        _descriptionController.text,
        _selectedType!,
        _location!.latitude,
        _location!.longitude,
        _createDateString(_selectedTime));
    return res.success;
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      _imageFile = pickedFile;
    });

    if (pickedFile == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  void handleHome() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    _topicController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
        String s) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(s),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFB5432A),
      appBar: AppBar(
        title: const Text(
          'Report',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB5432A),
        toolbarHeight: 60.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFE2DB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Added a Container to set the height of AddPictureButton equal to MapDisplay
                SizedBox(
                  height: 230.0,
                  child: AddPictureButton(
                    imageFile: _imageFile,
                    onImageSelected: (source) {
                      _getImage(source);
                    },
                  ),
                ),
                const SizedBox(height: 5.0),
                const Padding(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    'Topic Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                TextField(
                  controller: _topicController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color(0xFFFF5833), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color(0xFFFF5833), width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            'Type',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        ButtonType(onSelected: _onTypeSelected),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                          child: Row(
                            children: [
                              Text(
                                'Time',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                          height: 5,
                        ),
                        SizedBox(
                          height: 40.0,
                          child: TimePicker(onTimeSelected: _onTimeSelected),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 5.0),
                const Text(
                  'Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                Stack(children: [
                  MapDisplayCreateReport(
                      point: _location, onLocationChange: _onLocationChange),
                ]),
                const SizedBox(height: 8.0),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  height: 100.0,
                  child: DescriptionTextField(
                    controller: _descriptionController,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 70,
                  child: SlideAction(
                    height: 70,
                    borderRadius: 30,
                    innerColor: const Color(0xFFFF5833),
                    outerColor: const Color(0xFFFFA590),
                    sliderButtonIcon: const Icon(Icons.arrow_forward,
                        color: Color(0xFFFF5833)),
                    text: 'Slide to submit',
                    textStyle: const TextStyle(
                      color: Color.fromARGB(143, 255, 255, 255),
                      fontSize: 20.0,
                    ),
                    onSubmit: () async {
                      if (_imageFile == null) {
                        showSnackBar('Please select an image');
                        return null;
                      }
                      if (_selectedType == null) {
                        showSnackBar('Please select a type');
                        return null;
                      }
                      if (_location == null) {
                        showSnackBar('Please select a location');
                        return null;
                      }
                      if (_topicController.text.isEmpty) {
                        showSnackBar('Please enter a topic name');
                        return null;
                      }
                      if (_descriptionController.text.isEmpty) {
                        showSnackBar('Please enter a description');
                        return null;
                      }
                      var res = await createReport();
                      if (res) {
                        showSnackBar('Report created successfully');
                        handleHome();
                      } else {
                        showSnackBar('Failed to create report');
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
