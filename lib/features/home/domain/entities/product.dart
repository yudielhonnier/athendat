class Product {
  final int id;
  final String title;
  final String body;
  final int approved;
  final String? uuid;

  const Product(
      {required this.id,
      required this.title,
      required this.body,
      this.approved = 0,
      this.uuid});
}
