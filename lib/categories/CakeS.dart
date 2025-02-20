import 'dart:convert';
import 'package:http/http.dart' as http;
import 'enum.dart';


class Cake {
  final int id;
  final String name;
  final int price;
  int? discountedPrice;
  double rating;
  final String image;
  final String description;
  int stock;
  bool isDiscounted;
  final List<String> categories;

  Cake({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
    required this.description,
    required this.stock,
    required this.categories,
    this.discountedPrice,
    this.isDiscounted = false,
  });


  factory Cake.fromJson(Map<String, dynamic> json) {
    return Cake(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      price: json['price'],
      discountedPrice: json['discounted_price'],
      rating: (json['rating'] as num).toDouble(),
      image: json['image'],
      description: json['description'],
      stock: json['stock'],
      isDiscounted: json['is_discounted'] == 1, // Converting int to bool
      categories: (json['categories'] as String).split(','), // Splitting categories
    );
  }

  // Method to convert a Cake object to JSON (e.g., for sending to the API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'discounted_price': discountedPrice,
      'rating': rating,
      'image': image,
      'description': description,
      'stock': stock,
      'is_discounted': isDiscounted,
      'categories': categories.join(','), // Joining categories to a string
    };
  }

}



List<Cake> cakes = [];

Future<void> fetchCakesFromServer() async {
  final url = Uri.parse('http://yourserver.com/api/cakes');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      cakes = data.map((cakeJson) => Cake.fromJson(cakeJson)).toList();
    } else {
      print('Failed to fetch cakes. Status Code: ${response.statusCode}');
      throw Exception('Failed to fetch cakes');
    }
  } catch (e) {
    print('Error fetching cakes: $e');
  }
}


List<Cake> getCakesByCategory(CakeCategory category) {
  return cakes.where((cake) => cake.categories.contains(category)).toList();
}

Future<void> updateCakeRating(int cakeId, double newRating) async {
  final url = Uri.parse('http://yourserver.com/api/updateRating/$cakeId');
  try {
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'rating': newRating}),
    );

    if (response.statusCode == 200) {
      final cakeIndex = cakes.indexWhere((cake) => cake.id == cakeId);
      if (cakeIndex != -1) {
        cakes[cakeIndex].rating = newRating;
      }
    } else {
      throw Exception('Failed to update cake rating');
    }
  } catch (e) {
    print('Error updating cake rating: $e');
  }
}

