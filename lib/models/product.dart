import '../api.dart';

class Review {
  final String name;
  final String rating;
  final String comment;
  Review({required this.rating, required this.name, required this.comment});

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
        rating: json['rating'],
        name: json['name'],
        comment: json['comment']
    );
  }
}

class Product {
  final String product_name;
  final String product_detail;
  final List<Review> reviews;
  final int product_price;
  final int rating;
  final int numReviews;
  final String product_image;
  final String brand;
  final String category;
  final int countInStock;
  final String id;

  Product({
    required this.rating,
    required this.product_name,
    required this.brand,
    required this.category,
    required this.countInStock,
    required this.numReviews,
    required this.product_detail,
    required this.product_image,
    required this.product_price,
    required this.reviews,
    required this.id
});


 factory Product.fromJson(Map<String, dynamic> json){
    return Product(
        rating: json['rating'],
        product_name: json['product_name'],
        brand: json['brand'],
        category: json['category'],
        countInStock: json['countInStock'],
        numReviews: json['numReviews'],
        product_detail: json['product_detail'],
        product_image: '${Api.baseUrl}${json['product_image']}',
        product_price: json['product_price'],
        reviews: (json['reviews'] as List).map((e) => Review.fromJson(e)).toList(),
      id: json['_id']
    );
  }

}
