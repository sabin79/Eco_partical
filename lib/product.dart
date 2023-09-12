// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String productName;
  final String productDescription;
  final double productPrice;
  Product({
    required this.productName,
    required this.productDescription,
    required this.productPrice,
  });

  Product copyWith({
    String? productName,
    String? productDescription,
    double? productPrice,
  }) {
    return Product(
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productPrice: productPrice ?? this.productPrice,
    );
  }
}
