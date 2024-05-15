import 'package:app/pages/maptest.dart';
import 'package:app/pages/report/components/add_picture.dart';
import 'package:app/pages/report/components/button_type.dart';
import 'package:app/pages/report/components/description_text_field.dart';
import 'package:app/pages/report/components/time_picker.dart';
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
                const SizedBox(height: 1.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            'Type',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        ButtonType(),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
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
                        SizedBox(
                          width: 10,
                          height: 5,
                        ),
                        SizedBox(
                          height: 40.0,
                          child: TimePicker(),
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
                const SizedBox(
                  height: 230.0,
                  child: MapDisplay(),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: constraints.maxWidth,
                          child: DescriptionTextField(
                            controller: _reportController,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: constraints.maxWidth,
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
                            onSubmit: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Report submitted successfully'),
                                ),
                              );
                              return null;
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
