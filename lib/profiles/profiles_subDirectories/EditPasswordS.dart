import 'package:flutter/material.dart';
import 'package:draft_ap/ColorPlate.dart';
import 'package:draft_ap/Logins/UserS.dart';

class EditPasswordPage extends StatefulWidget {
  final User user; // دریافت آبجکت User

  const EditPasswordPage({Key? key, required this.user}) : super(key: key);

  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _savePassword() {
    // بررسی رمز فعلی (اختیاری)
    if (currentPasswordController.text != widget.user.password) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: burntSienna),
          ),
          content: const Text('Current password is incorrect.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: persianGreen),
              ),
            ),
          ],
        ),
      );
      return;
    }

    // بررسی تطابق رمز جدید و تاییدیه
    if (newPasswordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: burntSienna),
          ),
          content: const Text('New password and confirm password do not match.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: persianGreen),
              ),
            ),
          ],
        ),
      );
      return;
    }

    // ست کردن رمز جدید
    setState(() {
      widget.user.password = newPasswordController.text;
    });

    // پیام موفقیت (اختیاری)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Success',
          style: TextStyle(color: persianGreen),
        ),
        content: const Text('Your password has been updated successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to the previous page
            },
            child: Text(
              'OK',
              style: TextStyle(color: persianGreen),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Password'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              controller: currentPasswordController,
              labelText: 'Current Password',
              icon: Icons.lock,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: newPasswordController,
              labelText: 'New Password',
              icon: Icons.lock_open,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: confirmPasswordController,
              labelText: 'Confirm Password',
              icon: Icons.lock_outline,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: saffron,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: _savePassword,
              child: const Text(
                'Save Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: persianGreen),
        labelStyle: TextStyle(color: charcoal, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: persianGreen),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: persianGreen, width: 2),
        ),
      ),
    );
  }
}
