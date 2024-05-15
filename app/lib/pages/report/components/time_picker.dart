import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isFirstTime = true;
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
                isFirstTime = false;
                selectedTime = timeOfDay;
              });
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5833),
              minimumSize: const Size(50, 35)),
          child: Text(
            isFirstTime ? 'Select Time' : selectedTime.format(context),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
