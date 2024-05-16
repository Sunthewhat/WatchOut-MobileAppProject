import 'package:flutter/material.dart';

class ButtonType extends StatefulWidget {
  final Function(String) onSelected;
  const ButtonType({super.key, required this.onSelected});

  @override
  State<ButtonType> createState() => _ButtonTypeState();
}

class _ButtonTypeState extends State<ButtonType> {
  String _selectedType =
      'Select Type'; // Natural, Collaps, Crash, Fight, Forest Fire, Residential Fire, Shooting, Theif, Traffic, Vandalism, Suspicious, Danger
  int _selectedColor = 0xFFFF5833;
  int _buttonColor(String type) {
    switch (type) {
      case 'Natural':
        return 0xFF71D374;
      case 'Collaps':
        return 0xFF757575;
      case 'Crash':
        return 0xFFF53535;
      case 'Fight':
        return 0xFFFFB01F;
      case 'Forest Fire':
        return 0xFFFF591C;
      case 'Resident Fire':
        return 0xFF871212;
      case 'Shooting':
        return 0xFF13137F;
      case 'Theif':
        return 0xFF1D1D1D;
      case 'Traffic':
        return 0xFFFDFD3E;
      case 'Vandalism':
        return 0xFFA74AA7;
      case 'Suspicious':
        return 0xFF808080;
      case 'Danger':
        return 0xFFFF0000;
      default:
        return 0xFFFF5833;
    }
  }

  int _textColor(String type) {
    switch (type) {
      case 'Natural':
        return 0xFF333333;
      case 'Collaps':
        return 0xFFFFFFFF;
      case 'Crash':
        return 0xFFFFFFFF;
      case 'Fight':
        return 0xFF212427;
      case 'Forest Fire':
        return 0xFFFFFFFF;
      case 'Resident Fire':
        return 0xFFFFFFFF;
      case 'Shooting':
        return 0xFFFFFFFF;
      case 'Theif':
        return 0xFFFFFFFF;
      case 'Traffic':
        return 0xFF333333;
      case 'Vandalism':
        return 0xFFFFFFFF;
      case 'Suspicious':
        return 0xFFFFFFFF;
      case 'Danger':
        return 0xFFFFFFFF;
      default:
        return 0xFFFFFFFF;
    }
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
