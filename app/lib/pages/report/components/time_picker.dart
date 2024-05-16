import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final Function(int) onTimeSelected;
  const TimePicker({super.key, required this.onTimeSelected});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  int selectedTime = 0;
  int index = 0;
  List<int> times = [0, 5, 10, 20, 30, 45, 60];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: const Center(child: Text('Select Time')),
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (index > 0) {
                                    setState(() {
                                      index--;
                                      selectedTime = times[index];
                                    });
                                    widget.onTimeSelected(selectedTime);
                                  }
                                },
                                child: const Icon(
                                    Icons.arrow_back_ios_new_rounded),
                              ),
                              SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    index == 0
                                        ? 'Just now'
                                        : '${times[index]} minutes ago',
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (index < times.length - 1) {
                                    setState(() {
                                      index++;
                                      selectedTime = times[index];
                                    });
                                    widget.onTimeSelected(selectedTime);
                                  }
                                },
                                child:
                                    const Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5833),
            fixedSize: const Size(150, 50),
          ),
          child: Text(
            selectedTime == 0 ? 'Just now' : '$selectedTime minutes ago',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
