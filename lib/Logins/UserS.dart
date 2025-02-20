import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:draft_ap/categories/CakeS.dart';
import 'package:http_parser/http_parser.dart';

class User {
  static User? currentUser;

  String _username;
  String _email;
  String _password;
  List<Cake> wishlist = [];
  List<Cake> cartList = [];
  String _accountType = 'free';
  Map<String, int> cakeRatings = {};
  File? profilePicture;
  List<Cake> orderedCakes = [];
  List<String> savedAddresses;

  static const String baseUrl = 'http://yourserver.com/api';

  // Constructor
  User({
    required String username,
    required String email,
    required String password,
    required String accountType,
    this.profilePicture,
    List<String>? savedAddresses,
  })  : _username = username,
        _email = email,
        _password = password,
        _accountType = accountType,
        savedAddresses = savedAddresses ?? [];

  // Getters
  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get accountType => _accountType;

  // Setters
  set username(String newUsername) {
    _username = newUsername;
  }

  set email(String newEmail) {
    _email = newEmail;
  }

  set password(String newPassword) {
    _password = newPassword;
  }

  set accountType(String newAccountType) {
    if (newAccountType == 'free' || newAccountType == 'premium') {
      _accountType = newAccountType;
    }
  }

  /// متد لاگین
  static Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        currentUser = User.fromJson(data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login Error: $e');
      return false;
    }
  }

  /// متد ثبت‌نام
  static Future<bool> register(User user) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Registration Error: $e');
      return false;
    }
  }

  Future<void> addToWishlist(Cake cake) async {
    final url = Uri.parse('$baseUrl/users/$_username/wishlist');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'cakeId': cake.id}),
      );
      if (response.statusCode == 200) {
        wishlist.add(cake);
      }
    } catch (e) {
      print('Error adding to wishlist: $e');
    }
  }

  /// متد حذف از ویش‌لیست
  Future<void> removeFromWishlist(Cake cake) async {
    final url = Uri.parse('$baseUrl/users/$_username/wishlist/${cake.id}');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        wishlist.remove(cake);
      }
    } catch (e) {
      print('Error removing from wishlist: $e');
    }
  }

  /// متد افزودن به سبد خرید
  Future<void> addToCart(Cake cake) async {
    final url = Uri.parse('$baseUrl/users/$_username/cart');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'cakeId': cake.id}),
      );
      if (response.statusCode == 200) {
        cartList.add(cake);
      }
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  /// متد حذف از سبد خرید
  Future<void> removeFromCart(Cake cake) async {
    final url = Uri.parse('$baseUrl/users/$_username/cart/${cake.id}');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        cartList.remove(cake);
      }
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  /// متد برای امتیازدهی به کیک
  Future<void> rateCake(String cakeId, int rating) async {
    final url = Uri.parse('$baseUrl/cakes/$cakeId/rate');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'rating': rating}),
      );
      if (response.statusCode == 200) {
        cakeRatings[cakeId] = rating;
      }
    } catch (e) {
      print('Error rating cake: $e');
    }
  }

  /// متد برای آپدیت اطلاعات کاربر
  Future<void> updateUserData(String email, String accountType) async {
    final url = Uri.parse('$baseUrl/users/$_username');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'accountType': accountType}),
      );
      if (response.statusCode == 200) {
        _email = email;
        _accountType = accountType;
      }
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  Future<void> addToCartByName(String cakeName) async {
    try {
      // پیدا کردن کیک بر اساس نام
      final Cake? cake = cakes.firstWhere(
            (cake) => cake.name == cakeName,
        orElse: () => throw Exception('Cake not found'), // استفاده از استثناء
      );

      // بررسی اینکه کیک پیدا شده است
      if (cake != null) {
        final url = Uri.parse('$baseUrl/users/$_username/cart');
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'cakeId': cake.id}),
        );

        if (response.statusCode == 200) {
          cartList.add(cake);
        } else {
          throw Exception('Failed to add cake to cart');
        }
      }
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }


  Future<void> removeFromCartByName(String cakeName) async {
    try {
      final Cake? cake = cakes.firstWhere(
            (cake) => cake.name == cakeName,
        orElse: () => throw Exception('Cake not found'),
      );

      if (cake != null) {
        final url = Uri.parse('$baseUrl/users/$_username/cart/${cake.id}');
        final response = await http.delete(url);

        if (response.statusCode == 200) {
          cartList.remove(cake);
        } else {
          throw Exception('Failed to remove cake from cart');
        }
      }
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  Future<void> addToWishlistByName(String cakeName) async {
    try {
      // پیدا کردن کیک بر اساس نام
      final Cake? cake = cakes.firstWhere(
            (cake) => cake.name == cakeName,
        orElse: () => throw Exception('Cake not found'), // تولید استثناء در صورت پیدا نشدن کیک
      );

      // بررسی و اضافه کردن کیک به ویش‌لیست
      if (cake != null) {
        final url = Uri.parse('$baseUrl/users/$_username/wishlist');
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'cakeId': cake.id}),
        );

        if (response.statusCode == 200) {
          wishlist.add(cake);
        } else {
          throw Exception('Failed to add cake to wishlist');
        }
      }
    } catch (e) {
      print('Error adding to wishlist: $e');
    }
  }

  Future<void> removeFromWishlistByName(String cakeName) async {
    try {
      // پیدا کردن کیک بر اساس نام
      final Cake? cake = cakes.firstWhere(
            (cake) => cake.name == cakeName,
        orElse: () => throw Exception('Cake not found'), // تولید استثناء در صورت پیدا نشدن کیک
      );

      // بررسی و حذف کیک از ویش‌لیست
      if (cake != null) {
        final url = Uri.parse('$baseUrl/users/$_username/wishlist/${cake.id}');
        final response = await http.delete(url);

        if (response.statusCode == 200) {
          wishlist.remove(cake);
        } else {
          throw Exception('Failed to remove cake from wishlist');
        }
      }
    } catch (e) {
      print('Error removing from wishlist: $e');
    }
  }

  Future<void> updateProfilePicture(File newPicture) async {
    try {
      final url = Uri.parse('$baseUrl/users/$_username/profile-picture');

      // ساخت یک درخواست چندبخشی برای ارسال فایل
      final request = http.MultipartRequest('POST', url)
        ..fields['username'] = _username
        ..files.add(await http.MultipartFile.fromPath(
          'profile_picture',
          newPicture.path,
          contentType: MediaType('image', 'jpeg'), // نوع فایل
        ));

      // ارسال درخواست
      final response = await request.send();

      // بررسی وضعیت پاسخ
      if (response.statusCode == 200) {
        // به‌روزرسانی عکس پروفایل در کلاس
        profilePicture = newPicture;
      } else {
        throw Exception('Failed to update profile picture');
      }
    } catch (e) {
      print('Error updating profile picture: $e');
    }
  }



  Map<String, dynamic> toJson() {
    return {
      'username': _username,
      'email': _email,
      'password': _password,
      'accountType': _accountType,
      'wishlist': wishlist.map((cake) => cake.toJson()).toList(),
      'cartList': cartList.map((cake) => cake.toJson()).toList(),
      'orderedCakes': orderedCakes.map((cake) => cake.toJson()).toList(),
      'savedAddresses': savedAddresses,
    };
  }


  /// متد تبدیل از JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      accountType: json['accountType'],
      savedAddresses: List<String>.from(json['savedAddresses'] ?? []),
    )
      ..wishlist = (json['wishlist'] as List)
          .map((cake) => Cake.fromJson(cake))
          .toList()
      ..cartList = (json['cartList'] as List)
          .map((cake) => Cake.fromJson(cake))
          .toList()
      ..orderedCakes = (json['orderedCakes'] as List)
          .map((cake) => Cake.fromJson(cake))
          .toList();
  }
}
