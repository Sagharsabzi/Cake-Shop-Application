import 'package:flutter/material.dart';
import 'package:draft_ap/Logins/UserS.dart';
import 'package:draft_ap/categories/CakeS.dart';


class WishlistPage extends StatefulWidget {
  final User user;

  WishlistPage({required this.user});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  String searchQuery = ''; // متغیر جستجو

  @override
  Widget build(BuildContext context) {
    // فیلتر کیک‌های علاقه‌مندی بر اساس جستجو
    final filteredWishlist = widget.user.wishlist.where((cake) {
      return cake.name.contains(searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.favorite, color: Colors.redAccent),
          ),
        ],
      ),
      body: Column(
        children: [
          // فیلد جستجو
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'جستجوی کیک...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // نمایش لیست علاقه‌مندی‌ها
          Expanded(
            child: filteredWishlist.isEmpty
                ? Center(
              child: Text(
                'your wishlist is empty, go pick some cakes!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: filteredWishlist.length,
              itemBuilder: (context, index) {
                final cake = filteredWishlist[index]; // کل اطلاعات کیک

                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    leading: Image.asset(
                      cake.image,
                      width: 70,
                      height: 70,
                    ), // تصویر کیک
                    title: Text(
                      cake.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('قیمت: ${cake.price} تومان'),
                        Text('امتیاز: ${cake.rating} ⭐'),
                        Text('موجودی: ${cake.stock} عدد'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.user.wishlist.remove(cake); // حذف کیک
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
