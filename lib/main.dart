import 'package:flutter/material.dart';
import 'package:draft_ap/homePage/homeA.dart';
import 'package:draft_ap/Logins/UserS.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ایجاد یک کاربر پیش‌فرض
    User user = User(
      username: 'Test User',
      email: 'test@example.com',
      password: 'password123',
      accountType: 'free',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false, // حذف بنر Debug
      home: HomePage(user: user), // ارسال user به CategoryPage
    );
  }
}
