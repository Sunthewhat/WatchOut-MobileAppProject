import 'package:app/constant/colors.dart';
import 'package:flutter/material.dart';

class ButtonType extends StatefulWidget {
  final Function(String) onSelected;
  const ButtonType({super.key, required this.onSelected});

  @override
  State<ButtonType> createState() => _ButtonTypeState();
}

class _ButtonTypeState extends State<ButtonType> {
  String _selectedType = 'Select Type';
  int _selectedColor = 0xFFFF5833;
  int _buttonColor(String type) {
    return AppColors.getReportColor(type);
  }

  int _textColor(String type) {
    return AppColors.getReportTextColor(type);
  }

  void _selectType(String type) {
    setState(() {
      _selectedType = type;
      _selectedColor = _buttonColor(type);
      widget.onSelected(type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(
          150,
          40,
        ),
        backgroundColor: Color(_selectedColor),
        foregroundColor: Color(
          _textColor(_selectedType),
        ),
      ),
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(child: Text('Select Report Type')),
          scrollable: true,
          backgroundColor: const Color(0xFFFFE2DB),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Natural');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Natural'),
                      ),
                      foregroundColor: Color(
                        _textColor('Natural'),
                      ),
                    ),
                    child: const Text('Natural'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Collaps');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Collaps'),
                      ),
                      foregroundColor: Color(
                        _textColor('Collaps'),
                      ),
                    ),
                    child: const Text('Collaps'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Fight');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Fight'),
                      ),
                      foregroundColor: Color(
                        _textColor('Fight'),
                      ),
                    ),
                    child: const Text('Fight'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Resident Fire');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Resident Fire'),
                      ),
                      foregroundColor: Color(
                        _textColor('Resident Fire'),
                      ),
                    ),
                    child: const Text('Resident Fire'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Forest Fire');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Forest Fire'),
                      ),
                      foregroundColor: Color(
                        _textColor('Forest Fire'),
                      ),
                    ),
                    child: const Text('Forest Fire'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Crash');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Crash'),
                      ),
                      foregroundColor: Color(
                        _textColor('Crash'),
                      ),
                    ),
                    child: const Text('Crash'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Shooting');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Shooting'),
                      ),
                      foregroundColor: Color(
                        _textColor('Shooting'),
                      ),
                    ),
                    child: const Text('Shooting'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Theif');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Theif'),
                      ),
                      foregroundColor: Color(
                        _textColor('Theif'),
                      ),
                    ),
                    child: const Text('Theif'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Traffic');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Traffic'),
                      ),
                      foregroundColor: Color(
                        _textColor('Traffic'),
                      ),
                    ),
                    child: const Text('Traffic'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Vandalism');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Vandalism'),
                      ),
                      foregroundColor: Color(
                        _textColor('Vandalism'),
                      ),
                    ),
                    child: const Text('Vandalism'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Suspicious');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Suspicious'),
                      ),
                      foregroundColor: Color(
                        _textColor('Suspicious'),
                      ),
                    ),
                    child: const Text('Suspicious'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectType('Danger');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        _buttonColor('Danger'),
                      ),
                      foregroundColor: Color(
                        _textColor('Danger'),
                      ),
                    ),
                    child: const Text('Danger'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      child: Text(_selectedType),
    );
  }
}
