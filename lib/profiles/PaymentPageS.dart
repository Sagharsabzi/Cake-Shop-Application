import 'package:flutter/material.dart'; //کتابخونه برای استفاده از widget material
import 'package:flutter/services.dart'; //کتابخونه مربوط به ورودی ها و textInputFormatter
import 'dart:async'; //کتابخونه مربوط به تایمر
import 'package:draft_ap/Logins/UserS.dart';
import 'package:draft_ap/profiles/ProfileS.dart';


//کلاس برای فرمت کردن شماره کارت
//از TextInputFormatter ارثبری میکنه یعنی میتونه ورودیهارو تغییر بده
class CardNumberFormatter extends TextInputFormatter {
  @override
  // تغییر یا فرمت متن در هنگام وارد کردن formatEditUpdate
  //با مقادیر جدید و قبلی ورودی کار میکنیم
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    //برای وارد کردن - بین هر ۴ رقم شماره کارت
    String text = newValue.text.replaceAll('-', ''); // حذف خط تیره‌ها

    //محدود کردن ورودی به ۱۶ رقم. بیشتر نشه
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    //۴ رقم ۴ رقم جدا میکنیم بینش - میزاریم
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formatted += '-';
      }
      formatted += text[i];
    }

    //مقدار جدیدی که همه این شروط روش اعمال شدن رو ریترن میکنه (یعنی چک میکنه ۱۶ رقم باشه و ۴ تا ۴ تا جدا شده باشه و...)
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

//یه متد برای مدیریت کردن وضعیت صفحه پرداخت با StatefulWidget
class PaymentPage extends StatefulWidget {
  final User user; // متغیر User برای انتقال اطلاعات
  final int totalAmount; // مبلغ اکانت انتخاب‌شده
  final VoidCallback? onPaymentSuccess;
  final VoidCallback? onPremiumSuccess; // تابع برای بروزرسانی نوع اکانت

  PaymentPage({required this.user, required this.totalAmount, this.onPaymentSuccess,  this.onPremiumSuccess});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  //یه سری کنترلر برای کنترل کردن ورودی های متنی مثل cvv2 یا شماره کارت یا رمز دوم با TextEditingController میسازیم
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController vcc2Controller = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late Timer _timer; // تایمر
  int _remainingTime = 600; // ۱۰ دقیقه = ۶۰۰ ثانیه

  //توابع initState برای استفاده از StatefulWidget ها هستند و زمانی فراخوانی میشن که میخوایم ویجت برا اولین بار بسازیم
  @override
  void initState() {
    super.initState();
    _startTimer();
  }


  //تایمر شروع میشه
  //هر یه ثانیه یکی ازش کم میشه
  //وقتی تایمر تموم شه صفحه بسته میشه و میره صفحه قبل
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
        _exitPage();
      }
    });
  }


  // پیام موفقیت پرداخت
  void _showPaymentSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Payment successful!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // پیام خطای پرداخت
  void _showPaymentErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Payment failed! Please try again.'),
        backgroundColor: Colors.red,
      ),
    );
  }


  void _exitPage() {
    // برگشت به صفحه قبلی
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //scaffold برای ساختار اصلی صفحه
    return Scaffold(
      //رنگ بکگراند
      backgroundColor: Colors.blueGrey[50],
      //قابلیت اسکرول کردن صفحه
      body: SingleChildScrollView(
        child: Column(
          children: [
            // باکس گردینت بالای صفحه
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.redAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                //گوشه های گرد باکس
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'صفحه پرداخت',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      //نمایش زمان باقی مانده
                      'زمان باقی‌مانده: ${_formatTime(_remainingTime)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'لطفاً اطلاعات پرداخت خود را وارد کنید:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 20),
                  // شماره کارت
                  buildTextField(
                    controller: cardNumberController,
                    label: 'شماره کارت',
                    hint: '1234-5678-9123-4567',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      //محدود کردن ورودی فقط به اعداد
                      FilteringTextInputFormatter.digitsOnly,
                      //فرمت کردن شماره کارت
                      CardNumberFormatter(),
                    ],
                  ),
                  SizedBox(height: 15),
                  // رمز CVV2
                  buildTextField(
                    controller: vcc2Controller,
                    label: 'رمز CVV2',
                    hint: '3 یا 4 رقم',
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 15),
                  // تاریخ انقضا (ماه و سال جدا)
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          controller: monthController,
                          label: 'ماه',
                          hint: '01 تا 12',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: buildTextField(
                          controller: yearController,
                          label: 'سال',
                          hint: 'مثال: 04',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  // رمز دوم
                  buildTextField(
                    controller: passwordController,
                    label: 'رمز دوم',
                    hint: '۶ رقم',
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    //مبلغ پرداختی از طریق مقدار ارسالی نمایش داده می‌شود
                    'مبلغ پرداختی: ${_formatAmount(widget.totalAmount)} تومان',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      validatePayment(context);
                    },
                    child: Text('پرداخت'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //تو این بخش زمان باقی مانده رو نشون میدیم
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    //padLeft(2, '0'): اگر مقدار زمان یا دقیقه کمتر از ۲ رقم باشد، با صفر پر می‌کند (مثلاً ۳ → ۰۳).
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  //این متد مبلغ را به فرمت دلخواه نمایش میدهد. بین هر ۳ رقم "," اضافه می‌کند
  String _formatAmount(int amount) {
    return amount.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  //یه ویجت متنی ایجاد میکنیم
  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: Colors.teal),
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
        //OutlineInputBorder: برای تنظیم شکل حاشیه فیلد (با گوشه‌های گرد و رنگ مشخص)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.teal),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.orange, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  //اینجا میایم ویژگی های هر فیلد رو بررسی میکنیم. مثلا بررسی میکنیم شماره کارت ۱۶ رقم باشد و ...
  //بررسی فیلدها
  void validatePayment(BuildContext context) {
    String cardNumber = cardNumberController.text.replaceAll('-', '');
    String vcc2 = vcc2Controller.text;
    String month = monthController.text;
    String year = yearController.text;
    String secondPassword = passwordController.text;

    if (cardNumber.length != 16) {
      showErrorDialog(context, 'شماره کارت باید ۱۶ رقم باشد.');
    } else if (vcc2.length < 3 || vcc2.length > 4) {
      showErrorDialog(context, 'CVV2 باید ۳ یا ۴ رقم باشد');
    } else if (!_isValidExpiryDate(month, year)) {
      showErrorDialog(context, 'تاریخ انقضا نامعتبر است.');
    } else if (secondPassword.length != 6) {
      showErrorDialog(context, 'رمز دوم باید ۶ رقم باشد.');
    } else {
      showSuccessDialog(context);
    }
  }

  //تاربخ انقضای روی کارت (ماه و سال )
  bool _isValidExpiryDate(String month, String year) {
    //جفتش پر باشه
    if (month.isEmpty || year.isEmpty) return false;

    //tryParse هر چیزی رو به عدد صحیح تبدیل میکنه
    //اینجا داریم رشته ی ورودی رو به عدد صحیح تبدیل میکنه
    int monthValue = int.tryParse(month) ?? 0;
    int yearValue = int.tryParse(year) ?? 0;

    if (monthValue < 1 || monthValue > 12) return false;
    if (yearValue < 3) return false; // حداقل سال ۴۰۳

    return true;
  }

  //تابع کمکی است که یک دیالوگ خطا را به کاربر نمایش می‌دهد
  // message: پیامی که به عنوان محتوای خطا نمایش داده می‌شود
  //context: کانتکست صفحه فعلی که برای نمایش دیالوگ استفاده می‌شود.
  void showErrorDialog(BuildContext context, String message) {
    //متدی برای نمایش دیالوگ
    showDialog(
      context: context,
      //alertDialog یه دیالوگ تو فلاتره که عنوان، محتوا و اکشن داره
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[50],
        title: Text('خطا', style: TextStyle(color: Colors.redAccent)),
        //message به عنوان ارگومان ارسال میشه
        //کانتنت پیام خطارو نشون میده
        content: Text(message, style: TextStyle(color: Colors.black)),
        //دکمه ی پایین
        actions: [
          TextButton(
            onPressed: () {
              //با استفاده از این دکمه تب رو میبندیم
              Navigator.of(context).pop();
            },
            //متن دکمه رو میزاریم "باشه"
            child: Text('باشه', style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }

  //اگه پرداخت موفق بود این تابع میاد
  //همچنین کاربر به صفحه پروفایل بازگردانده می‌شود
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[50],
        title: Text('پرداخت موفق', style: TextStyle(color: Colors.teal)),
        content: Text('پرداخت شما با موفقیت انجام شد.', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // بستن دیالوگ

              // بررسی اینکه آیا باید اکانت به پریمیوم تغییر کند
              if (widget.onPremiumSuccess != null) {
                widget.onPremiumSuccess!();
              }

              // انتقال آیتم‌های سبد خرید به لیست سفارش‌ها
              setState(() {
                widget.user.orderedCakes.addAll(widget.user.cartList); // انتقال کیک‌ها
                widget.user.cartList.clear(); // خالی کردن سبد خرید
              });

              // هدایت به صفحه پروفایل
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileS(user: widget.user),
                ),
                    (route) => false,
              );
            },
            child: Text('باشه', style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }
}
