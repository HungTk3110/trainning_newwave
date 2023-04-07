class MovieEntity {
  String name;
  String image;
  String describe;
  String title;
  String point;

  MovieEntity({
    this.name,
    this.image,
    this.describe,
    this.title,
    this.point,
  });
}

List<MovieEntity> listMovieTop() {
  List<MovieEntity> list = [
    MovieEntity(
      name: "Thor",
      image: "https://mcdn.coolmate"
          ".me/image/August2022/sieu-anh-hung-marvel_723.jpg",
      describe: "Thor hẳn là siêu anh hùng Marvel không thể thiếu trong danh sách những nhân vật "
          "được yêu thích nhất trên màn ảnh. ",
      title: "Ra mắt công chúng lần đầu tiên năm 2011",
      point: "assets/svg/imdb.svg",
    ),
    MovieEntity(
      name: "Doctor Strange",
      image: "https://media.coolmate"
          ".me/cdn-cgi/image/quality=80,format=auto/uploads/August2022/sieu-anh-hung-marvel_682.jpeg",
      title: "Bộ phim thứ 14 trong Vũ trụ Marvel",
      describe: "Nội dung phim xoay quanh Stephen Strange - một bác sĩ giải phẫu thần kinh hàng "
          "đầu thế giới và sở hữu trí nhớ siêu việt. ",
      point: "assets/svg/imdb.svg",
    ),
    MovieEntity(
      name: "Captain America",
      image: "https://mcdn.coolmate"
          ".me/image/August2022/sieu-anh-hung-marvel_222.jpg",
      describe: "Khi xem phim, bạn có thể thấy Captain America là một nhân vật đạt được các chức "
          "năng cơ thể tuyệt vời mà nhiều người ao ước. ",
      title: "Hình tượng một siêu anh hùng "
          "Marvel với tính cách chính trực",
      point: "assets/svg/imdb.svg",
    ),
  ];
  return list;
}
