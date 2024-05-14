import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _reportController = TextEditingController();
  XFile? _imageFile;

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

  @override
  Widget build(BuildContext context) {
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
              children: [
                AddPictureButton(
                  imageFile: _imageFile,
                  onImageSelected: (source) {
                    _getImage(source);
                  },
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
                const SizedBox(height: 1.0),
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
                const ButtonType(),
                const SizedBox(height: 5.0),
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
                const SizedBox(
                  height: 40.0,
                  child: TimePicker(),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const MapBox(),
                const SizedBox(height: 5.0),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                DescriptionTextField(controller: _reportController),
                const SizedBox(height: 0.0),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SlideAction(
                      height: 70,
                      borderRadius: 30,
                      elevation: 0,
                      innerColor: const Color(0xFFFF5833),
                      outerColor: const Color(0xFFFFA590),
                      sliderButtonIcon: const Icon(Icons.arrow_forward,
                          color: Color(0xFFFF5833)),
                      text: 'Slide to submit',
                      textStyle: const TextStyle(
                        color: Color(0xFFFFA590),
                        fontSize: 20.0,
                      ),
                      onSubmit: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Report submitted successfully'),
                          ),
                        );
                        return null;
                      },
                    ),
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

class AddPictureButton extends StatelessWidget {
  final XFile? imageFile;
  final Function(ImageSource) onImageSelected;

  const AddPictureButton({
    super.key,
    required this.imageFile,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImageSource(context);
      },
      child: Container(
        width: 331.0,
        height: 164.0,
        decoration: BoxDecoration(
          color: const Color(0xFFFF5833),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: imageFile == null
            ? const Icon(Icons.add, color: Colors.white, size: 100.0)
            : ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.file(
                  File(imageFile!.path),
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }

  void _showImageSource(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a picture'),
                onTap: () {
                  Navigator.of(context).pop();
                  onImageSelected(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  onImageSelected(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ButtonType extends StatelessWidget {
  const ButtonType({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5833),
              minimumSize: const Size(50, 35),
            ),
            child: const Text(
              'Fire🔥',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2960AE),
              minimumSize: const Size(50, 35),
            ),
            child: const Text(
              'Car Crash 🚗',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF35A5F6),
              minimumSize: const Size(50, 35),
            ),
            child: const Text(
              'Flood🌊',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ElevatedButton(
          onPressed: () async {
            final TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
              initialTime: selectedTime,
              initialEntryMode: TimePickerEntryMode.dial,
            );
            if (timeOfDay != null) {
              setState(() {
                selectedTime = timeOfDay;
              });
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5833),
              minimumSize: const Size(50, 35)),
          child: const Text(
            'Select Time',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0), // Add left margin
          child: Text(
            selectedTime.format(context),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class MapBox extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const MapBox({
    super.key,
    this.width = 200,
    this.height = 165,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 200.0,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: const Color(0xFFFF5833), width: 2.0),
        ),
        child: TextField(
          controller: controller,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
