import 'package:flutter/material.dart';
import 'package:draft_ap/Logins/UserS.dart';


class OrdersPage extends StatelessWidget {
  final User user; // کاربر فعلی که شامل لیست سفارش‌ها است

  OrdersPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('کیک‌های سفارش داده‌شده'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.orange[50], // پس‌زمینه کرم
        padding: const EdgeInsets.all(16.0),
        child: user.orderedCakes.isEmpty
            ? Center(
          child: Text(
            'هیچ سفارشی ثبت نشده است!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        )
            : ListView.builder(
          itemCount: user.orderedCakes.length,
          itemBuilder: (context, index) {
            final cake = user.orderedCakes[index];
            return Card(
              color: Colors.orange[100], // رنگ کارت
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Image.asset(
                  cake.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  cake.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('قیمت: ${cake.price} تومان'),
              ),
            );
          },
        ),
      ),
    );
  }
}