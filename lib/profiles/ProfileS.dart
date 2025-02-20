import 'dart:io';
import 'package:flutter/material.dart';
import 'profiles_subDirectories/EditProfileS.dart'; // Import EditProfilePage
import 'profiles_subDirectories/ProfilePictureS.dart';
import 'profiles_subDirectories/PremiumAccountS.dart';
import 'profiles_subDirectories/OnlineSupportS.dart';
import 'package:draft_ap/categories/dastebandiA.dart';
import 'package:draft_ap/ColorPlate.dart';
import 'package:draft_ap/Logins/UserS.dart';
import 'package:draft_ap/profiles/profiles_subDirectories/WishListS.dart';
import 'package:draft_ap/homePage/homeA.dart';
import 'package:draft_ap/profiles/cartA.dart';
import 'package:draft_ap/profiles/profiles_subDirectories/OrderedS.dart';




class ProfileS extends StatelessWidget {
  final User user; // متغیر User برای انتقال اطلاعات
  ProfileS({required this.user}); // سازنده با User

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: pastelSaffron,
        appBarTheme: AppBarTheme(
          backgroundColor: pastelSandyBrown,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87, fontSize: 20), // متن خواناتر
          bodyMedium: TextStyle(color: Colors.black54, fontSize: 18), // متن کمی پررنگ‌تر
        ),
        iconTheme: IconThemeData(color: Colors.black54), // آیکون پررنگ‌تر
        listTileTheme: ListTileThemeData(
          tileColor: pastelLightCyan,
          textColor: Colors.black87,
          iconColor: Colors.black87,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: UserAccountPage(user: user),
    );
  }
}

class UserAccountPage extends StatefulWidget {
  final User user;

  const UserAccountPage({Key? key, required this.user}) : super(key: key);

  @override
  _UserAccountPageState createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  void _updateUserData(String username, String email) {
    setState(() {
      user.username = username;
      user.email = email;
    });
  }

  void _updateProfileImage(File? newImage) {
    if (newImage != null) {
      setState(() {
        user.updateProfilePicture(newImage); // آپدیت عکس پروفایل
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile picture updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No image selected.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  void _updateAccountType(String newAccountType) {
    setState(() {
      user.accountType = newAccountType;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePicturePage(
                            onImageSelected: _updateProfileImage,
                            user: user, // ارسال آبجکت User
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: user.profilePicture != null
                          ? FileImage(user.profilePicture!)
                          : null,
                      child: user.profilePicture == null
                          ? const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.black,
                      )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.username,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.email, //ایمیل کاربرمون
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.accountType, //نوع اکانتش
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildMenuItem(
                  context,
                  icon: Icons.edit,
                  text: "Edit Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                          user: user,
                          onSave: (updatedUser) {
                            _updateUserData(updatedUser.username, updatedUser.email);
                          },
                        ),
                      ),
                    );
                  },
                ),
                buildMenuItem(
                  context,
                  icon: Icons.star,
                  text: "Premium Accounts",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PremiumAccountS(
                          user: user, // ارسال آبجکت user
                          accountType: user.accountType, // ارسال نوع اکانت فعلی
                        ),
                      ),
                    );

                  },
                ),
                buildMenuItem(
                  context,
                  icon: Icons.favorite,
                  text: "Wishlist",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistPage(user: user), // هدایت به صفحه Wishlist
                      ),
                    );
                  },
                ),
                buildMenuItem(
                  context,
                  icon: Icons.history,
                  text: "Order History",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersPage(user: widget.user),
                      ),
                    );
                  },
                ),

                buildMenuItem(
                  context,
                  icon: Icons.add_circle,
                  text: "Online Support",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SupportChat(
                          user: widget.user, // ارسال آبجکت user
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFFFF4E6),
        selectedItemColor: Color(0xFFF4A261),
        unselectedItemColor: Color(0xFF264653),
        currentIndex: 3,
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


  Widget buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String text,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black), // آیکون سمت چپ
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ), // متن آیتم
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey), // فلش سمت راست
      onTap: onTap, // عمل کلیک
      tileColor: const Color(0xFFF1F1F1), // رنگ پس‌زمینه آیتم
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // گوشه‌های گرد
      ),
    );
  }

