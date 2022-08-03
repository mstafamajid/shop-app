class Products {
  final String id;
  final String description;
  final String title;
  final String imgURL;
  final double price;
   bool isfavorite;
  Products({
    required this.id,
    required this.description,
    required this.title,
    required this.imgURL,
    required this.price,
     this.isfavorite=false,
  });
}
