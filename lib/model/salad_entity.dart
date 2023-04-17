class SaladItem {
  String title;
  String subtitle;
  String assetImage;

  SaladItem({
    required this.title,
    required this.subtitle,
    required this.assetImage,
  });
}

List<SaladItem> saladItems = [
  SaladItem(
    title: "Salad with cabbage and shrimp",
    subtitle: "John Adams",
    assetImage: "assets/images/img1.jpg",
  ),
  SaladItem(
    title: "Italian-style tomato salad",
    subtitle: "Thomas Jefferson",
    assetImage: "assets/images/img2.jpg",
  ),
  SaladItem(
    title: "Cucumber salad, cherry tomatoes",
    subtitle: "James Madison",
    assetImage: "assets/images/img3.jpg",
  ),
  SaladItem(
    title: "Corn Salad",
    subtitle: "James Monroe",
    assetImage: "assets/images/img4.jpg",
  ),
  SaladItem(
    title: "Avocado Salad",
    subtitle: "John Quincy Adams",
    assetImage: "assets/images/img5.jpg",
  ),
  SaladItem(
    title: "Potato Salad",
    subtitle: "Martin Van Buren",
    assetImage: "assets/images/img6.jpg",
  ),
  SaladItem(
    title: "Salad of cove beans, shrimp and potatoes",
    subtitle: "John Tyler",
    assetImage: "assets/images/img1.jpg",
  ),
];

