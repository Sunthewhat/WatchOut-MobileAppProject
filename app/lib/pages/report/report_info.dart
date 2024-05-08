import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ReportInfoPage extends StatefulWidget {
  const ReportInfoPage({super.key});

  @override
  State<ReportInfoPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportInfoPage> {
  // final TextEditingController _topicController = TextEditingController();
  final TextEditingController _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB5432A),
      appBar: AppBar(
        title: const Text(
          'Report Information',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB5432A),
        toolbarHeight: 60.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Define the action when the back button is pressed
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
            topLeft:
                Radius.circular(20.0), 
            topRight: 
                Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AddPictureBox(),
              const SizedBox(height: 5.0),
              const Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Text(
                  'Space Dragon Fire',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const ButtonType(),
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
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: SlideAction(
              //       borderRadius: 30,
              //       elevation: 0,
              //       innerColor: const Color(0xFFFF5833),
              //       outerColor: const Color(0xFFFFA590),
              //       sliderButtonIcon: const Icon(Icons.arrow_forward, color: Color(0xFFFF5833)),
              //       text: 'Slide to submit',
              //       textStyle: const TextStyle(
              //         color: Color(0xFFFFA590),
              //         fontSize: 20.0,
              //       ),
              //       onSubmit: () {
              //         // print('Submitted');
              //         return null;
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class AddPictureBox extends StatelessWidget {
  const AddPictureBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 331.0,
      height: 195.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.black,
        ),
      ),
    );
  }
}

class ButtonType extends StatelessWidget {
  const ButtonType({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor:
                const Color(0xFFFF5833), 
          ),
          child: const Text(
            'Fire🔥',
            style: TextStyle(
              color: Colors.white, 
            ),
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {},
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Color(0xFF2960AE),
        //   ),
        //   child: Text(
        //     'Car Crash 🚗',
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        // ElevatedButton(
        //   onPressed: () {},
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Color(0xFF35A5F6),
        //   ),
        //   child: Text(
        //     'Flood🌊',
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
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
    this.height = 200,
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: const Color(0xFFFF5833), width: 2.0),
        ),
        child: Text(
          controller.text,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}



// void main() {
//   runApp(const MaterialApp(
//     home: ReportInfoPage(),
//   ));
// }
