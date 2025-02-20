import 'package:draft_ap/Logins/HomeS.dart';
import 'package:draft_ap/profiles/PaymentPageS.dart';
import 'package:flutter/material.dart';
import 'package:draft_ap/Logins/UserS.dart';
import 'package:draft_ap/categories/CakeS.dart';
import 'package:draft_ap/homepage/homeA.dart';
import 'package:draft_ap/profiles/ProfileS.dart';
import 'package:draft_ap/categories/dastebandiA.dart';
import 'package:draft_ap/profiles/cartA.dart';




class ShoppingCartPage extends StatefulWidget {
  final User user;

  ShoppingCartPage({required this.user});

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  String searchQuery = '';
  String? selectedAddress; // مقدار اولیه می‌تواند null باشد

  void _increaseQuantity(Cake cake) {
    setState(() {
      cake.stock--;
      widget.user.cartList.add(cake);
    });
  }

  void _decreaseQuantity(Cake cake) {
    setState(() {
      if (widget.user.cartList.contains(cake)) {
        widget.user.cartList.remove(cake);
        cake.stock++;
      }
    });
  }

  void _removeItem(Cake cake) {
    setState(() {
      widget.user.cartList.removeWhere((item) => item.name == cake.name);
    });
  }

  double _calculateTotal() {
    // بررسی نوع اکانت کاربر
    double deliveryCost = widget.user.accountType == 'premium' ? 0 : 80000;
    return widget.user.cartList.fold(0, (sum, cake) => sum + cake.price) + deliveryCost;
  }


  @override
  Widget build(BuildContext context) {
    final filteredCart = widget.user.cartList.where((cake) {
      return cake.name.contains(searchQuery);
    }).toList();

    final isCartEmpty = widget.user.cartList.isEmpty; // بررسی خالی بودن سبد خرید

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'search',
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
            Expanded(
              child: filteredCart.isEmpty
                  ? Center(
                child: Text(
                  'your cartlist is empty',
                  style: TextStyle(fontSize: 18, color: Colors.brown),
                ),
              )
                  : ListView.builder(
                itemCount: filteredCart.length,
                itemBuilder: (context, index) {
                  final cake = filteredCart[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.asset(cake.image),
                      title: Text(cake.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('قیمت: ${cake.price} تومان'),
                          Text('توضیحات: ${cake.description}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => _decreaseQuantity(cake),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => _increaseQuantity(cake),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeItem(cake),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (!isCartEmpty) // نمایش بخش آدرس و هزینه ارسال تنها در صورتی که سبد خرید پر است
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // دکمه برای انتخاب آدرس
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'choose address',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Divider(),
                                ListTile(
                                  leading: Icon(Icons.add_location_alt),
                                  title: Text('add new address'),
                                  onTap: () {
                                    Navigator.pop(context); // بستن BottomSheet
                                    TextEditingController addressController = TextEditingController();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('add new address'),
                                          content: TextField(
                                            controller: addressController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'add new address',
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text('save address'),
                                              onPressed: () {
                                                if (addressController.text.isNotEmpty) {
                                                  setState(() {
                                                    widget.user.savedAddresses.add(addressController.text);
                                                  });
                                                  Navigator.pop(context); // بستن دیالوگ
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('address saved!'),
                                                      duration: Duration(seconds: 2),
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('address cannot be empty'),
                                                      duration: Duration(seconds: 2),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.location_on),
                                  title: Text('استفاده از آدرس‌های ذخیره‌شده'),
                                  onTap: () {
                                    Navigator.pop(context); // بستن BottomSheet
                                    if (widget.user.savedAddresses.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('هیچ آدرس ذخیره‌شده‌ای وجود ندارد!'),
                                        ),
                                      );
                                    }
                                    else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('آدرس‌های ذخیره‌شده'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: widget.user.savedAddresses.map((address) {
                                                return ListTile(
                                                  title: Text(address),
                                                  onTap: () {
                                                    setState(() {
                                                      selectedAddress = address;
                                                    });
                                                    Navigator.pop(context); // بستن دیالوگ انتخاب آدرس
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('آدرس انتخاب شد: $address'),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('مشخص کردن آدرس'),
                  ),

                  SizedBox(height: 10),
                  Text(
                    widget.user.accountType == 'premium' ? 'هزینه ارسال: رایگان' : 'هزینه ارسال: 80000 تومان',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),

                  SizedBox(height: 10),
                  Text(
                    'مجموع قیمت: ${_calculateTotal()} تومان',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: widget.user.cartList.isEmpty || selectedAddress == null
                        ? null // غیرفعال کردن دکمه در صورت عدم شرایط لازم
                        : () {
                      final totalAmount = _calculateTotal().toInt(); // محاسبه مبلغ کل
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            user: widget.user,
                            totalAmount: totalAmount,
                          ),
                        ),
                      );
                    },
                    child: Text('نهایی کردن خرید و پرداخت'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // ثابت ماندن نوار ناوبری
          backgroundColor: Color(0xFFFFF4E6),
          selectedItemColor: Color(0xFFF4A261),
          unselectedItemColor: Color(0xFF264653),
          currentIndex: 2, // کتگوری باشه صفحه فعلی
          items: [
            //نوار ناوبری و ایکون هاش
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
                MaterialPageRoute(builder: (context) => HomePage(user:widget.user)),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryPage(user: widget.user)),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartPage(user: widget.user)),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileS(user: widget.user),
                ),
              );
            }
          },
        )
    )
    ;
  }
}

class AddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ثبت آدرس'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'آدرس جدید را وارد کنید',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () {
                // Confirm address action
              },
              child: Text('تایید آدرس'),
            ),
          )
        ],
      ),
    );
  }
}
