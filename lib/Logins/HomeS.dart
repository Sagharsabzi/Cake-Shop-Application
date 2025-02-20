import 'package:flutter/material.dart';
import 'loginA.dart'; //صفحه لاگین آوین
import '../ColorPlate.dart'; //فایل رنگا
import 'signupA.dart'; //صفحه ساین اپ آوین

//stateless widget ها یه سری ویجتن که تغییر نمیکنن.
class Home extends StatelessWidget {
  @override
  //رابط کاربری صفحه اصلی رو میسازیم
  Widget build(BuildContext context) {
    //اسکفولد یه ساختاره که یه سری متد داره
    return Scaffold(
      //استفاده از ویجت کانتیرنر
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          //داخل باکس دکوریشن تصویر بکگراند رو میزاریم. ابعادشم اندازه کل صفحه ست میکنیم
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // تصویر پس‌زمینه
            fit: BoxFit.cover,
          ),
        ),
        //سیف اریا باعث میشه ویحت ها توی محدوده امنشون باشن و توهم توهم نرن
        child: SafeArea(
          child: Center(
            //کانتیرنر جدید برای دکمه ها
            child: Container(
              //پدینگ واسه فضاهای خالی اطرافه
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              //باکس پشت صفحه پس زمینه و اینا
              decoration: BoxDecoration(
                //رنگ باکس پشتش
                color: lightCyan,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              //صفحه عمودی باشه
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //وسط چین بشه
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hi! Welcome to AP project",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //سایز متن
                      fontSize: 24,
                      //رنگ متن
                      color: charcoal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "If you have an account in Blanca, please press Login\nOtherwise, for joining our community, create an account by pressing Signup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: charcoal,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  //اون دکمهه که بزنی میره تو صفحه لاگین
                  MaterialButton(
                    minWidth: double.infinity,
                    //ابعاد دکمهه
                    height: 50,
                    //با استفاده از onPressed و Navigator.push میریم تو صفحه لاگین
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginApp()), // به صفحه لاگین بروید
                      );
                    },
                    color: saffron,
                    //گرد کردن گوشه های دکمه لاگین
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: charcoal,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()), // تب ساین اپ رو باز میکنه
                      );
                    },
                    color: burntSienna,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
