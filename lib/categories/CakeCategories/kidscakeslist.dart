import 'package:flutter/material.dart';
import 'package:draft_ap/categories/dastebandiA.dart';
import 'package:draft_ap/profiles/ProfileS.dart';
import 'package:draft_ap/Logins/UserS.dart';
import 'package:draft_ap/Logins/loginA.dart';
import 'package:draft_ap/categories/CakeS.dart';
import 'package:draft_ap/categories/enum.dart';
import 'package:draft_ap/homePage/homeA.dart';
import 'package:draft_ap/profiles/cartA.dart';



class ProductListkiApp extends StatelessWidget {
  final User user; // دریافت User به عنوان ورودی
  ProductListkiApp({required this.user}); // سازنده با User

  @override
  Widget build(BuildContext context) {
    //ویجت ریشه
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //صفحه اصلی برنامه
      home: ProductListkiScreen(user: user), // ارسال User به صفحه لیست محصولات
    );
  }
}


//از ویجت استست فول استفتده کردم تا پویا باشه و بتونه تغییر کنه
class ProductListkiScreen extends StatefulWidget {

  final User user; // دریافت User به عنوان ورودی
  ProductListkiScreen({required this.user}); // سازنده با User

  @override
  //متد کرییت استیت وضعیت صفحه لیست محصولات رو میسازه
  _ProductListkiScreenState createState() => _ProductListkiScreenState();
}


class _ProductListkiScreenState extends State<ProductListkiScreen> {

//متغیر سرچ که فعلا یک استرینگ خالی است ینی تا زمانی که کاربر چیزی وارد نکند، تمام محصولات نمایش داده می‌شن
  String search = '';
  //متغیر سورت تایپ از جنس استرینگ که فعلا مقدار دیفالت دارد ینی ترتیب خاصی نداره لیست محصولا
  String sortType = 'default';


  @override
  Widget build(BuildContext context) {
    // دریافت کیک‌های دسته‌بندی شده
    List<Cake> filteredCakes = getCakesByCategory(CakeCategory.anniversary).where((cake) {
      return cake.name.toLowerCase().contains(search.toLowerCase());
    }).toList();

    // مرتب سازی محصولات
    if (sortType == 'max_price') {
      filteredCakes.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortType == 'min_price') {
      filteredCakes.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortType == 'best_rating') {
      filteredCakes.sort((a, b) => b.rating.compareTo(a.rating));
    }


//ساختار اصلی صفحه
    return Scaffold(
      appBar: AppBar(
        //رنگ اپ بار
        backgroundColor: Colors.deepOrangeAccent,
        //برای جست وجو
        title: TextField(

          decoration: InputDecoration(
            //متن پیشفرض  در فیلد جست و جو
            hintText: 'جستجوی محصول...',
            //رنگش
            hintStyle: TextStyle(color: Colors.white70),
            //حذف حاشیه دور فیلد
            border: InputBorder.none,
            //ایکون ذره بین
            icon: Icon(Icons.search, color: Colors.white),
          ),
          //متنی که کاربر میسرچه :
          style: TextStyle(color: Colors.white),
          //ان چنجد برای واکنش به تغییزات این متد هر بار که کاربر چیزی در فیلد وارد کنه فراخوانی می‌شه
          //ولیو مقدار جدیدیه که کاربر وارد کرده
          onChanged: (value) {
            setState(() {
              //متغیر سرچ مقدار ولیو رو میگیره
              search = value;
            });
          },
        ),
        //دکمه کناری اپ بار عملکرد
        actions: [
          // یک منوی کشویی است که گزینه‌هایی را به کاربر نمایش می‌ده و نوع داده ای که نمایش میده استربنگه
          PopupMenuButton<String>(
            // متدی که زمانی که کاربر یک گزینه را انتخاب کند، اجرا می‌شود.
            onSelected: (value) {
              //صفحه را بازسازی می‌کند تا مرتب‌سازی جدید اعمال شود.
              setState(() {
                // متغیر سورت تایپ مقدار ولیو رو میگیره که کاربر واردش کرده
                sortType = value;
              });
            },
            //ایکون واسه سورت
            icon: Icon(Icons.filter_list, color: Colors.white),
            itemBuilder: (context) => [
              // هر گزینه در منو پاپ اپ
              // ولیو مقداریه که موقع انتخاب گزینه به ان سلکتد ارسال میشه
              // چالدش هم ویجته واسخ نمشون دادن متنش
              PopupMenuItem(value: 'max_price', child: Text('بیشترین قیمت')),
              PopupMenuItem(value: 'min_price', child: Text('کمترین قیمت')),
              PopupMenuItem(value: 'best_rating', child: Text('بیشترین امتیاز')),
            ],
          ),
        ],
      ),
      //تنظیمات عکس واسه پس زمینه
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/download.jpg'),
            fit: BoxFit.cover,
          ),
        ),


        // لیست محصولات فیلتر شده
        child: ListView.builder(
          itemCount: filteredCakes.length,
          itemBuilder: (context, index) {
            final cake = filteredCakes[index];
            return Card(
              margin: EdgeInsets.all(20),
              elevation: 5,
              child: ListTile(
                leading: Image.asset(cake.image, width: 70, height: 70),
                title: Text(cake.name, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('قیمت: ${cake.price} تومان'),
                    if (cake.isDiscounted)
                      Text('قیمت با تخفیف: ${cake.discountedPrice} تومان',
                          style: TextStyle(color: Colors.red)),
                    Text('امتیاز: ${cake.rating} ⭐',
                        style: TextStyle(fontSize: 12, color: Colors.deepOrange)),
                    Text('موجودی: ${cake.stock} عدد',
                        style: TextStyle(color: Colors.teal, fontSize: 12)),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        product: {
                          'name': cake.name,
                          'price': cake.price,
                          'rating': cake.rating,
                          'image': cake.image,
                          'description': cake.description,
                          'stock': cake.stock,
                          'isDiscounted': cake.isDiscounted,
                          'discountedPrice': cake.discountedPrice,
                          'isFavorite': false,
                          'isincart': false,
                        },
                        cart: [],
                        user: widget.user,
                        onRatingUpdate: (newRating) {
                          setState(() {
                            cake.rating = newRating;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),


      //نویگیشن بار هم که واسه همشون ثابته
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
              MaterialPageRoute(builder: (context) => HomePage(user: widget.user)),
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
      ),
    );
  }
}


//صفحه جزییات یک ویجت استیت فوله
class ProductDetailScreen extends StatefulWidget {
  //دوتا متغیر پروداکت واسه اطلاعات محصول و ان ریتینگ اپدیت یه تابعه واسه به روز کردن امتیاز
  final Map<String, dynamic> product;
  final Function(double) onRatingUpdate;
  final List<Map<String, dynamic>> cart;
  final User user; // اضافه کردن آبجکت کاربر


//سازندش
  ProductDetailScreen({
    required this.product,
    required this.cart,
    required this.onRatingUpdate,
    required this.user, // اضافه کردن آبجکت کاربر

  });

  @override
  //این کلاس وضعیت متغیرها (مثل لیست نظرات یا امتیاز محصول) را نگه می‌دارد.
  //هر بار که داده‌ها تغییر کنه ، بعدا با  setState() رابط کاربری به‌روز می‌شود.
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}
//ویجت حالت صفحه از حالت ارثبری میکنه
class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isFavorite = false;
  bool isInCart = false;

  @override
  void initState() {
    super.initState();
    // مقدار اولیه وضعیت دکمه‌ها بر اساس داده محصول
    isFavorite = widget.product['isFavorite'] ?? false;
    isInCart = widget.product['isincart'] ?? false;
  }


  //لیست نظرات کابرا
  List<Map<String, dynamic>> comments = [];
  // کنترلر واسه دریافت ورودیه
  final TextEditingController commentController = TextEditingController();
//متد واسه نظر دهی
  void addComment() {
    //اگه نظره خالی نباشه
    if (commentController.text.isNotEmpty) {

      setState(() {
        //کامنته ادد میشه
        comments.add({
          'text': commentController.text,
          'likes': 0,
          'dislikes': 0,
          'hasLiked': false,
          'hasDisliked': false,
        });
//متنه از ورودی پاک میشه
        commentController.clear();
      });
      //با ست استیت تغیرا اعمال میشه
    }
  }
//متد واسه لایک کردن کامنتا
  void likeComment(int index) {
    setState(() {
      if (!comments[index]['hasLiked']) {
        comments[index]['likes']++;
        comments[index]['hasLiked'] = true;
        // اگر قبلاً دیسلایک کرده بود، دیسلایک رو حذف کن
        if (comments[index]['hasDisliked']) {
          comments[index]['dislikes']--;
          comments[index]['hasDisliked'] = false;
        }
      }
    });
  }
// متد واسه دیسلاک کردن
  void dislikeComment(int index) {
    setState(() {
      if (!comments[index]['hasDisliked']) {
        comments[index]['dislikes']++;
        comments[index]['hasDisliked'] = true;
        // اگر قبلاً لایک کرده بود، لایک رو حذف کن
        if (comments[index]['hasLiked']) {
          comments[index]['likes']--;
          comments[index]['hasLiked'] = false;
        }
      }
    });
  }

//متد واسه امتیاز دادن
  void rateProduct(double rating) {
    setState(() {
      //امتیاز جدید جایگزین قبلیه میشه
      widget.product['rating'] = rating;
    });

    // ذخیره امتیاز در لیست امتیازهای کاربر
    widget.user.rateCake(widget.product['name'], rating.toInt());

    //متد بروزرسانیش فراخوانی میشه
    widget.onRatingUpdate(rating);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name']),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/download.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // نمایش تصویر محصول
                      Image.asset(widget.product['image'], width: 300, height: 300),
                      SizedBox(height: 10),

                      // نمایش نام محصول
                      Text(
                        widget.product['name'],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),

                      // نمایش قیمت (قیمت اولیه و تخفیف)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // قیمت اصلی
                          Text(
                            'قیمت: ${widget.product['price']} تومان',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              decoration: widget.product['isDiscounted'] == true
                                  ? TextDecoration.lineThrough
                                  : null, // خط روی قیمت اصلی اگر تخفیف وجود داشت
                            ),
                          ),
                          // قیمت تخفیفی (فقط اگر تخفیف داشت)
                          if (widget.product['isDiscounted'] == true)
                            Text(
                              'قیمت با تخفیف: ${widget.product['discountedPrice']} تومان',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),

                      SizedBox(height: 10),

                      // نمایش امتیاز محصول
                      Text(
                        'امتیاز: ${widget.product['rating']} ⭐',
                        style: TextStyle(fontSize: 18, color: Colors.orange),
                      ),
                      SizedBox(height: 10),

                      // نمایش موجودی محصول
                      Text(
                        'موجودی: ${widget.product['stock']} عدد',
                        style: TextStyle(fontSize: 16, color: Colors.teal),
                      ),
                      SizedBox(height: 10),

                      // نمایش توضیحات محصول
                      Text(
                        widget.product['description'],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      SizedBox(height: 20),

                      //متد افزودن به سبد خرید
                      IconButton(
                        icon: Icon(
                          isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                          color: isInCart ? Colors.orange : null,
                        ),
                        onPressed: () {
                          setState(() {
                            isInCart = !isInCart;
                            widget.product['isincart'] = isInCart;
                            if (isInCart) {
                              widget.user.addToCartByName(widget.product['name']);
                            } else {
                              widget.user.removeFromCartByName(widget.product['name']);
                            }
                          });
                        },
                      ),

                      //متد افزودن به ویش لیست
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.orange : null,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                            widget.product['isFavorite'] = isFavorite;
                            if (isFavorite) {
                              widget.user.addToWishlistByName(widget.product['name']);
                            } else {
                              widget.user.removeFromWishlistByName(widget.product['name']);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('نظرات کاربران:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      ...comments.asMap().entries.map((entry) {
                        int index = entry.key;
                        var comment = entry.value;
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(comment['text']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.thumb_up, color: Colors.teal),
                                  onPressed: () => likeComment(index),
                                ),
                                Text('${comment['likes']}'),
                                IconButton(
                                  icon: Icon(Icons.thumb_down, color: Colors.orange),
                                  onPressed: () => dislikeComment(index),
                                ),
                                Text('${comment['dislikes']}'),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          labelText: 'نظر خود را وارد کنید',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: addComment,
                        child: Text('ثبت نظر'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('امتیازدهی به محصول:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < widget.product['rating'] ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              rateProduct((index + 1).toDouble());
                            },
                          );
                        }),
                      ),
                    ],
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
