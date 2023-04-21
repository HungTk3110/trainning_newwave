class MovieCollection {
  String title;
  String assetImage;

  MovieCollection({
    required this.title,
    required this.assetImage,
  });
}

List<MovieCollection> listCollectionEntity = [
  MovieCollection(assetImage: "assets/svg/Vector.svg", title: "Genres"),
  MovieCollection(
      assetImage: "assets/svg/tv series icon.svg", title: "TV series"),
  MovieCollection(assetImage: "assets/svg/Movie Roll.svg", title: "Movies"),
  MovieCollection(assetImage: "assets/svg/Cinema.svg", title: "In Theatre"),
];
