class ProductModel {
  int id;
  String title;
  String image;
  String description;
  String category;
  int qty;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.category,
    required this.qty,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      category: json['category'],
      qty: 1,
    );
  }
}
