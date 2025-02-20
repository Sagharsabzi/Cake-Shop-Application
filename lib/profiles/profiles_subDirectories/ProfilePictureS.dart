import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:draft_ap/ColorPlate.dart';
import 'package:draft_ap/Logins/UserS.dart';

class EditProfilePicturePage extends StatefulWidget {
  final Function(File?) onImageSelected;
  final User user; // دریافت آبجکت کاربر


  const EditProfilePicturePage({
    Key? key,
    required this.onImageSelected,
    required this.user,
  }) : super(key: key);


  @override
  _EditProfilePicturePageState createState() => _EditProfilePicturePageState();
}

class _EditProfilePicturePageState extends State<EditProfilePicturePage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _saveImage() {
    if (_selectedImage != null) {
      // تبدیل XFile به File
      final File imageFile = File(_selectedImage!.path);

      // استفاده از متد برای آپدیت عکس پروفایل
      widget.user.updateProfilePicture(imageFile); // تغییر عکس پروفایل کاربر
      widget.onImageSelected(imageFile); // ارسال تغییرات

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile picture saved successfully!'),
          backgroundColor: persianGreen,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No image selected to save.'),
          backgroundColor: burntSienna,
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Profile Picture'),
        centerTitle: true,
        backgroundColor: persianGreen,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [lightCyan, sandyBrown.withOpacity(0.3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage:
                _selectedImage != null ? FileImage(_selectedImage!) : null,
                backgroundColor: Colors.white,
                child: _selectedImage == null
                    ? Icon(
                  Icons.person,
                  size: 80,
                  color: persianGreen.withOpacity(0.7),
                )
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo, color: Colors.white),
                label: const Text('Select from Gallery'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: saffron,
                  foregroundColor: charcoal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera, color: Colors.white),
                label: const Text('Take a Picture'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: saffron,
                  foregroundColor: charcoal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: persianGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Save and Go Back',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
