import 'package:flutter/material.dart';
import 'UserS.dart'; // فایل کلاس User
import 'package:draft_ap/homePage/homeA.dart';


void main() => runApp(
  MaterialApp(
    // تنظیمات اصلی برنامه و ساختار متریال
    debugShowCheckedModeBanner: false, // غیرفعال کردن بنر دیباگ
    home: LoginApp(), // صفحه لاگین
  ),
);

// صفحه لاگین تعریف شد با ویجت ثابت
class LoginApp extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // متدی برای بررسی ورودی‌ها و لاگین کاربر
  void login(BuildContext context) {
    // گرفتن اطلاعات ورودی کاربر
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    // بررسی خالی نبودن فیلدهای یوزرنیم و رمز عبور
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username and password cannot be empty!"),
          backgroundColor: Colors.red,
        ),
      );
      return; // متوقف کردن ادامه اجرا
    }

    // بررسی وجود کاربر ثبت‌نام‌شده
    if (User.currentUser != null) {
      // آپدیت اطلاعات کاربر در کلاس User
      User.currentUser!.username = username; // به‌روزرسانی یوزرنیم
      User.currentUser!.password = password; // به‌روزرسانی رمز عبور

      // پیام موفقیت و انتقال به صفحه کتگوری
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login successful!"),
          backgroundColor: Colors.green,
        ),
      );

      // انتقال به صفحه کتگوری
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: User.currentUser!), // ارسال User
        ),
      );
    } else {
      // پیام خطا در صورت عدم وجود کاربر ثبت‌نام‌شده
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No account found. Please sign up first."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // scaffold چهارچوب اصلی صفحه را مشخص می‌کند
    return Scaffold(
      appBar: AppBar(
        // عنوان و استایل آن
        title: Text(
          ' Login page ', // متن عنوان
          style: TextStyle(
            fontWeight: FontWeight.bold, // ضخیم‌تر کردن فونت
            fontSize: 24, // اندازه فونت
            color: Colors.white, // رنگ متن
          ),
        ),
        centerTitle: true, // عنوان وسط صفحه
        // پس‌زمینه با گرادینت
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2A9D8F), Color(0xFFE76F51)], // گرادینت
              begin: Alignment.topLeft, // شروع گرادینت
              end: Alignment.bottomRight, // پایان گرادینت
            ),
          ),
        ),
        elevation: 5.0, // سایه زیر AppBar
      ),

      // طراحی بدنه صفحه لاگین
      body: Container(
        width: double.infinity, // عرض کل صفحه
        height: double.infinity, // ارتفاع کل صفحه
        decoration: BoxDecoration(
          // تنظیم پس‌زمینه
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // مسیر + اسم عکس
            fit: BoxFit.cover, // تنظیم برای پر کردن کل صفحه
          ),
        ),
        // قرار دادن تمام محتوا در مرکز صفحه
        child: Center(
          //واسه اسکرول
          child: SingleChildScrollView(
            //ویجت تو ویجت
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // ستون وسط صفحه
              crossAxisAlignment: CrossAxisAlignment.center, // چیدن همه چیز در مرکز
              children: [
                // عنوان اصلی
                const Text(
                  "Please enter your information to login", // متن عنوان
                  textAlign: TextAlign.center, // وسط‌چین کردن متن
                  style: TextStyle(
                    fontSize: 24, // اندازه فونت
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF264653),
                  ),
                ),
                SizedBox(height: 20), // فاصله بین ویجت‌ها
                // فیلد یوزرنیم یا ایمیل
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20), // فاصله از چپ و راست
                  child: TextField(
                    controller: usernameController, // کنترلر یوزرنیم
                    decoration: InputDecoration(
                      filled: true, // فعال کردن پس‌زمینه
                      fillColor: Colors.white.withOpacity(0.8), // رنگ پس‌زمینه کادر
                      labelText: "Username", // متن برچسب
                      labelStyle: TextStyle(color: Color(0xFF2A9D8F)), // رنگ متن برچسب
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // گوشه‌های گرد
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // گوشه‌های گرد
                        borderSide: BorderSide(color: Color(0xFF2A9D8F), width: 2.0), // رنگ کادر
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // گوشه‌های گرد
                        borderSide: BorderSide(color: Color(0xFFE76F51), width: 2.0), // کادر در حالت کلیک شده
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), // فاصله بین ویجت‌ها
                // کادر ورودی رمز عبور
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20), // فاصله از چپ و راست
                  child: TextField(
                    controller: passwordController, // کنترلر پسورد
                    obscureText: true, // مخفی کردن متن برای رمز عبور
                    decoration: InputDecoration(
                      filled: true, // فعال کردن پس‌زمینه
                      fillColor: Colors.white.withOpacity(0.8), // رنگ پس‌زمینه کادر
                      labelText: "Password", // متن برچسب
                      labelStyle: TextStyle(color: Color(0xFF2A9D8F)), // رنگ متن برچسب
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // گوشه‌های گرد
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // گوشه‌های گرد
                        borderSide: BorderSide(color: Color(0xFF2A9D8F), width: 2.0), // رنگ کادر
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // گوشه‌های گرد
                        borderSide: BorderSide(color: Color(0xFFE76F51), width: 2.0), // کادر در حالت کلیک شده
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30), // فاصله بین ویجت‌ها
                // کادر نارنجی دور دکمه لاگین
                Container(
                  padding: EdgeInsets.all(1.0), // فاصله داخلی کادر
                  decoration: BoxDecoration(
                    color: Color(0xFFF4A261), // رنگ پس‌زمینه نارنجی
                    borderRadius: BorderRadius.circular(12.0), // گوشه‌های گرد کادر
                  ),
                  child: ElevatedButton(
                    onPressed: () => login(context), // فراخوانی تابع لاگین
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF4A261), // رنگ دکمه
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // دکمه گردتر
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // فاصله داخلی دکمه
                    ),
                    child: Text(
                      "Login", // متن دکمه
                      style: TextStyle(
                        fontSize: 18, // اندازه متن
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF264653), // رنگ متن دکمه
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
