import 'package:draft_ap/Logins/HomeS.dart';
import 'package:flutter/material.dart';
import 'package:draft_ap/categories/dastebandiA.dart';
import 'package:draft_ap/Logins/UserS.dart';
import 'package:draft_ap/categories/CakeS.dart';
import 'package:draft_ap/profiles/ProfileS.dart';
import 'package:draft_ap/profiles/cartA.dart';
import 'dart:async'; //کتابخونه مربوط به تایمر


class HomePage extends StatefulWidget {
  final User user;
  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = "";
  
  List<Cake> discounteds = [];
  Duration discountTimeLeft = Duration(hours: 6); // 6 ساعت تخفیف
  late Timer discountTimer;

  @override
  void initState() {
    super.initState();
    discounteds = cakes.where((cake) => cake.isDiscounted).toList();
    startDiscountTimer();
  }


  void startDiscountTimer() {
    discountTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) { // بررسی اینکه ویجت هنوز در حال اجراست
        setState(() {
          if (discountTimeLeft.inSeconds > 0) {
            discountTimeLeft -= Duration(seconds: 1);
          } else {
            discountTimer.cancel(); // متوقف کردن تایمر
          }
        });
      }
    });
  }



  @override
  void dispose() {
    discountTimer.cancel(); // اطمینان از متوقف کردن تایمر
    super.dispose();
  }


  final List<Map<String, dynamic>> topRatedCakes = [

    //تولید فیک دیتا
    {'name': 'rose cake', 'price': 1400000, 'image': 'assets/rose.png', 'rating': 5, 'sales': 100, 'stock': 20, 'description': 'A beautiful rose-flavored cake.', 'isincart': false, 'isFavorite': false},
    {'name': 'violet cake', 'price': 800000, 'image': 'assets/purple2.png', 'rating': 5, 'sales': 90, 'stock': 15, 'description': 'A soft violet-themed cake.', 'isincart': false, 'isFavorite': false},
    {'name': 'purple geode cake', 'price': 1000000, 'image': 'assets/geode.png', 'rating': 4.8, 'sales': 85, 'stock': 10, 'description': 'Unique geode design with purple theme.', 'isincart': false, 'isFavorite': false},
    {'name': 'emerald cake', 'price': 1100000, 'image': 'assets/zomorod2.png', 'rating': 4.7, 'sales': 80, 'stock': 12, 'description': 'Elegant emerald-style cake.', 'isincart': false, 'isFavorite': false},
    {'name': 'flamingo cake', 'price': 1000000, 'image': 'assets/flamingo.jpg', 'rating': 4.5, 'sales': 75, 'stock': 18, 'description': 'Tropical flamingo design.', 'isincart': false, 'isFavorite': false},
    {'name': 'barbie cake', 'price': 1300000, 'image': 'assets/barbie.png', 'rating': 4.4, 'sales': 70, 'stock': 8, 'description': 'Perfect for Barbie fans.', 'isincart': false, 'isFavorite': false},
    {'name': 'breaking bad cake', 'price': 950000, 'image': 'assets/breakingbad.png', 'rating': 4.3, 'sales': 65, 'stock': 14, 'description': 'Inspired by Breaking Bad series.', 'isincart': false, 'isFavorite': false},
    {'name': 'the frog cake', 'price': 1050000, 'image': 'assets/thefrog.png', 'rating': 4.2, 'sales': 60, 'stock': 16, 'description': 'Funny frog-themed cake.', 'isincart': false, 'isFavorite': false},
    {'name': 'gold & gray cake', 'price': 950000, 'image': 'assets/gray.png', 'rating': 4.1, 'sales': 55, 'stock': 10, 'description': 'Luxurious gold and gray design.', 'isincart': false, 'isFavorite': false},
    {'name': 'pink lemonade cake', 'price': 900000, 'image': 'assets/pinklemonade.png', 'rating': 4.0, 'sales': 50, 'stock': 13, 'description': 'Refreshing pink lemonade flavor.', 'isincart': false, 'isFavorite': false},
  ];


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTopRatedCakes = topRatedCakes
        .where((cake) => cake['name'].toLowerCase().contains(search.toLowerCase()))
        .toList();

    List<Cake> filteredLowestPriceCakes = discounteds
        .where((cake) => cake.name.toLowerCase().contains(search.toLowerCase()))
        .toList();


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/download.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.deepOrangeAccent,
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'جستجوی محصول...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.login, color: Colors.white),
                  onPressed: () {
                    // هدایت به صفحه moz
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()), // MozPage صفحه جدید
                    );
                  },
                ),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Special offers :',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      SizedBox(height: 5),
                      // افزودن تایمر تخفیف
                      Text(
                        'Time left: ${discountTimeLeft.inHours}:${(discountTimeLeft.inMinutes % 60).toString().padLeft(2, '0')}:${(discountTimeLeft.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 16, color: Colors.redAccent),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredLowestPriceCakes.length,
                          itemBuilder: (context, index) {
                            final cake = filteredLowestPriceCakes[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                      user: widget.user,
                                      product: {
                                        'name': cake.name,
                                        'price': cake.price,
                                        'discountedPrice': cake.discountedPrice,
                                        'image': cake.image,
                                        'description': cake.description,
                                        'rating': cake.rating,
                                        'stock': cake.stock,
                                        'isDiscounted': cake.isDiscounted,
                                        'discountedPrice': cake.discountedPrice,
                                        'isincart': false,
                                        'isFavorite': false,
                                      },
                                      cart: [],
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          cake.rating = rating;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: ProductCard(
                                image: cake.image,
                                name: cake.name,
                                price: cake.price.toString(),
                                discountedPrice: cake.discountedPrice?.toString(),
                                rating: null,
                                sales: null,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Top products :',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredTopRatedCakes.length,
                          itemBuilder: (context, index) {
                            final cake = filteredTopRatedCakes[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                      user: widget.user,
                                      product: cake,
                                      cart: [],
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          cake['rating'] = rating;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: ProductCard(
                                image: cake['image'],
                                name: cake['name'],
                                price: cake['price'].toString(),
                                discountedPrice: null,
                                rating: cake['rating'],
                                sales: cake['sales'],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFFFF4E6),
        selectedItemColor: Color(0xFFF4A261),
        unselectedItemColor: Color(0xFF264653),
        currentIndex: 0,
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


class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String? discountedPrice;
  final double? rating;
  final double? sales;


  ProductCard({
    required this.image,
    required this.name,
    required this.price,
    this.discountedPrice,
    this.rating,
    this.sales,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // تصویر محصول
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          // نام محصول
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          if (rating != null) ...[
            Text(
              'امتیاز: $rating ⭐',
              style: TextStyle(fontSize: 10, color: Colors.orange),
            ),
          ],
          if (sales != null) ...[
            Text(
              'فروش: $sales عدد',
              style: TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],

          // قیمت اصلی
          Text(
            'قیمت: $price تومان',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red,
              decoration: discountedPrice != null ? TextDecoration.lineThrough : null,
            ),
            textAlign: TextAlign.center,
          ),
          // قیمت تخفیفی (در صورت وجود)
          if (discountedPrice != null) ...[
            SizedBox(height: 4),
            Text(
              'قیمت بعد از تخفیف: $discountedPrice تومان',
              style: TextStyle(
                fontSize: 12,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),


          ],
        ],
      ),
    );
  }
}


class ProductDetailScreen extends StatefulWidget {
  //دوتا متغیر پروداکت واسه اطلاعات محصول و ان ریتینگ اپدیت یه تابعه واسه به روز کردن امتیاز
  final Map<String, dynamic> product;
  final Function(double) onRatingUpdate;
  final List<Map<String, dynamic>> cart;
  final User user;

  ProductDetailScreen({
    required this.product,
    required this.cart,
    required this.onRatingUpdate,
    required this.user,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isFavorite = false;
  bool isInCart = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.product['isFavorite'] ?? false;
    isInCart = widget.product['isincart'] ?? false;
  }

  //لیست نظرات کابرا
  List<Map<String, dynamic>> comments = [];
  final TextEditingController commentController = TextEditingController();

  void addComment() {
    if (commentController.text.isNotEmpty) {
      setState(() {
        comments.add({
          'text': commentController.text,
          'likes': 0,
          'dislikes': 0,
          'hasLiked': false,
          'hasDisliked': false,
        });
        commentController.clear();
      });
    }
  }

  void likeComment(int index) {
    setState(() {
      if (!comments[index]['hasLiked']) {
        comments[index]['likes']++;
        comments[index]['hasLiked'] = true;
        if (comments[index]['hasDisliked']) {
          comments[index]['dislikes']--;
          comments[index]['hasDisliked'] = false;
        }
      }
    });
  }

  void dislikeComment(int index) {
    setState(() {
      if (!comments[index]['hasDisliked']) {
        comments[index]['dislikes']++;
        comments[index]['hasDisliked'] = true;
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
      widget.product['rating'] = rating;
    });

    widget.user.rateCake(widget.product['name'], rating.toInt());
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
