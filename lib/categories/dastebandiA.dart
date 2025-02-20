import 'package:flutter/material.dart';
import 'package:draft_ap/Logins/loginA.dart'; // اضافه کردن فایل loginA.dart
import 'package:draft_ap/categories/CakeCategories/birthdaycakeslistA.dart';
import 'package:draft_ap/categories/CakeCategories/anniversarycakesA.dart';
import 'package:draft_ap/categories/CakeCategories/creamcakeslist.dart';
import 'package:draft_ap/categories/CakeCategories/fondantcakeslist.dart';
import 'package:draft_ap/categories/CakeCategories/kidscakeslist.dart';
import 'package:draft_ap/categories/CakeCategories/bentocakelist.dart';
import 'package:draft_ap/profiles/ProfileS.dart';
import 'package:draft_ap/Logins/UserS.dart';
import 'package:draft_ap/homePage/homeA.dart';
import 'package:draft_ap/profiles/cartA.dart';



// صفحه اصلی شامل لیست دسته‌بندی‌ها
class CategoryPage extends StatelessWidget {
  final User user; // متغیر User برای انتقال اطلاعات
  CategoryPage({required this.user}); // سازنده با User

  // لیست دسته‌بندی‌ها
  final List<Category> categories = [
    Category(name: 'cream cakes', imagePath: 'assets/cream.jpg'),
    Category(name: 'fondant cakes', imagePath: 'assets/fondant.jpg'),
    Category(name: 'birthday cakes', imagePath: 'assets/birthday.jpg'),
    Category(name: 'anniversary cakes', imagePath: 'assets/anniversary.jpg'),
    Category(name: 'bento cakes', imagePath: 'assets/bento.jpg'),
    Category(name: 'kid`s cakes', imagePath: 'assets/baby.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    // scaffold چهارچوب اصلی صفحه را مشخص می‌کند
    return Scaffold(
      // اپ بار بالای صفحه
      appBar: AppBar(
        title: Text('Cake Categories'), // عنوان اپ بار
        centerTitle: true, // متن وسط
        backgroundColor: Colors.teal, // رنگ اپ بار
      ),
      body: Container(
        // تنظیم پس‌زمینه
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/download.jpg'), // عکس پس‌زمینه
            fit: BoxFit.cover, // عکس کل صفحه را بگیره
          ),
        ),
        // شبکه دسته‌بندی‌ها
        child: GridView.builder(
          padding: EdgeInsets.all(10), // فاصله اطراف
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // تعداد ستون‌ها
            mainAxisSpacing: 10, // فاصله عمودی
            crossAxisSpacing: 10, // فاصله افقی
            childAspectRatio: 1.0, // نسبت طول به عرض
          ),
          itemCount: categories.length, // تعداد دسته‌بندی‌ها
          itemBuilder: (context, index) {
            // ساخت کارت دسته‌بندی
            return CategoryCard(category: categories[index], user: user);
          },
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFFFF4E6),
        selectedItemColor: Color(0xFFF4A261),
        unselectedItemColor: Color(0xFF264653),
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'homepage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'cake categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(user: user)),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryPage(user: user)),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingCartPage(user: user)),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileS(user: user),
              ),
            );
          }
        },
      ),
    );
  }
}


// کلاس کتگوری‌ها شامل اسم و عکس
class Category {
  final String name; // نام دسته‌بندی
  final String imagePath; // مسیر عکس

  Category({required this.name, required this.imagePath}); // سازنده
}

// کلاس طراحی کارت دسته‌بندی‌ها
class CategoryCard extends StatelessWidget {
  final Category category; // اطلاعات دسته‌بندی
  final User user; // اطلاعات کاربر

  CategoryCard({required this.category, required this.user}); // سازنده

  @override
  Widget build(BuildContext context) {
    // طراحی دکمه دسته‌بندی
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white70.withOpacity(0.8), // رنگ دکمه
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // گوشه گرد
        ),
        elevation: 5, // سایه دکمه
      ),
      onPressed: () {
        // بررسی نوع دسته‌بندی و انتقال به صفحه مرتبط
        if (category.name.trim() == 'birthday cakes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductListApp(user: user)),
          );
        } else if (category.name.trim() == 'anniversary cakes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductListanApp(user: user)),
          );
        } else if (category.name.trim() == 'cream cakes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductListcrApp(user: user)),
          );
        } else if (category.name.trim() == 'fondant cakes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductListfoApp(user: user)),
          );
        } else if (category.name.trim() == 'bento cakes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductListbeApp(user: user)),
          );
        } else if (category.name.trim() == 'kid`s cakes') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductListkiApp(user: user)),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // وسط‌چین کردن محتوا
        children: [
          Expanded(
            child: Image.asset(
              category.imagePath, // مسیر عکس
              fit: BoxFit.cover, // پر کردن فضای موجود
            ),
          ),
          SizedBox(height: 8), // فاصله بین عکس و متن
          Text(
            category.name, // نام دسته‌بندی
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // متن وسط‌چین
          ),
        ],
      ),
    );
  }
}
