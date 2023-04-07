class ProductModel {
  int id;
  String title;
  String image;
  String description;
  String category;
  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.category,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      //price: json['price'],
      description: json['description'],
      category: json['category'],
    );
  }
}
