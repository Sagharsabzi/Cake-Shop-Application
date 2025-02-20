import 'package:flutter/material.dart';
import '../ColorPlate.dart';
import 'loginA.dart';
import 'dart:async';
import 'UserS.dart';


class SignUpScreen extends StatelessWidget {

  //استفاده از کنترلر برای کنترل کردن ورودی هامون و دسترسی به متنی که کاربر وارد کرده
// برای کنترل کردن یوزرنیم
  final TextEditingController _usernameController = TextEditingController();
  //کنترل کردن پسسورد
  final TextEditingController _passwordController = TextEditingController();
  //کنترل کردن تکرار پسسورد
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  //کنترل کردن ایمیلی که کاربر داده
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage; // پیام خطای ایمیل
  //رجکس تیپیکال واسه ایمیل
  final String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+"; // رجکس ایمیل
//برای پنهان بودن پسورد
  bool _isPasswordVisible = false;


//متدی که بررسی میکنه ببینه کاربر میتونه اکانت بسازه یا نه
  Future<void> _validateAndSignUp(BuildContext context) async {
    //دریافت کردن مقدارها
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    String? errorMessage;
//حالا حالات مختلفی که ممکنه پیش بیاد رو بررسی میکنیم
    //همش باید پر باشه
    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      errorMessage = "All fields are required.";
      //ایمیل باید مقبول باشه
    } else if (!RegExp(emailRegex).hasMatch(email)) {
      errorMessage = "Please enter a valid email address.";
      //شروط پسوورد واسه طولش و محتواش
    } else if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]'))) {
      errorMessage =
      "Password must be at least 8 characters long and include uppercase, lowercase, and a number.";
      //تو پسورد یوزرنیم نباشه
    } else if (password.contains(username)) {
      errorMessage = "Password cannot contain the username.";
    }
    //پسورد با تکرارش یکی نباشه
    else if (password != confirmPassword) {
      errorMessage = "Passwords do not match.";
    }
// چاپ ارور ها با اسنک بار
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
    else {
      // مقداردهی به currentUser
      User.currentUser = User(
        username: username,
        email: email,
        password: password,
        accountType: 'free', // پیش‌فرض
      );

      //اگه هیچ اروری نباشه چاپ موفقیت
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("you have signed up successfully!"),
          backgroundColor: Colors.green[900],
        ),
      );
// یه تابع واسه اینکه مکث ایجاد کنه بین پیام توی اسنک بار و منتقل شدن به لاگین
        await Future.delayed(Duration(seconds: 2));


      // هدایت به صفحه لاگین بعد از موفقیت
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginApp()),
      );
    }
  }


//ساختار صفحه
  @override
  Widget build(BuildContext context) {
    //ویجت تو ویجت
    return Scaffold(
      //تزیینات اپ بار
      appBar: AppBar(
        title: Text(
          'Sign Up Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2A9D8F), Color(0xFFE76F51)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 5.0,
      ),
      //عکس پس زمینه و بقیه تزیینا
      //Container: برای طراحی پس‌زمینه و تنظیمات صفحه.
      // DecorationImage: اضافه کردن تصویر پس‌زمینه.
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/download.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        //واسه اسکرول کردن
        child: SingleChildScrollView(
          //فاصله از اطراف
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //باکس یوزرنیم
                SizedBox(height: 20),
                _buildTextField(
                  hintText: "Username",
                  icon: Icons.person,
                  controller: _usernameController,
                ),
                // باکس ایمیل با تنظیماتش
                SizedBox(height: 15),

                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email, color: charcoal),
                    filled: true,
                    fillColor: lightCyan,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    errorText: _errorMessage, // پیام خطا
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    if (!RegExp(emailRegex).hasMatch(value)) {
                      _errorMessage = "Please enter a valid email address.";
                    } else {
                      _errorMessage = null;
                    }
                    (context as Element).markNeedsBuild(); // بروزرسانی رابط کاربری
                  },
                ),
                SizedBox(height: 15),
                _buildPasswordField(
                  hintText: "Password",
                  icon: Icons.lock,
                  controller: _passwordController,
                ),
                SizedBox(height: 15),
                _buildPasswordField(
                  hintText: "Confirm Password",
                  icon: Icons.lock,
                  controller: _confirmPasswordController,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  //دکمه سایناپ
                  onPressed: () => _validateAndSignUp(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: burntSienna,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Or",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: charcoal.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Sign In with Google",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      //اگه اکانت داشته باشه میره تو لاگین
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        color: charcoal.withOpacity(0.6),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginApp(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
//کنترلر ورودی را از پارامتر ورودی دریافت می‌کند برای مدیریت محتوا
  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: charcoal),
        filled: true,
        fillColor: lightCyan,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
//فیلد ورودی رمز عبور با قابلیت نمایش یا مخفی کردن رمز عبور
  Widget _buildPasswordField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          controller: controller,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: charcoal),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                _isPasswordVisible = !_isPasswordVisible;
                (context as Element).markNeedsBuild();
              },
            ),
            filled: true,
            fillColor: lightCyan,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        );
      },
    );
  }
}
