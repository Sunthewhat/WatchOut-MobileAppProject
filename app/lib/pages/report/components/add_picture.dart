import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
