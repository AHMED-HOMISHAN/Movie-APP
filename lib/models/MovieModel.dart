// ignore_for_file: file_names

class MovieSliderModel {
  List<BannerModel> banners = [];

  MovieSliderModel.fromJson(Map<String, dynamic> json) {
    json['results'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
  }
}

class BannerModel {
  late int id;
  late String name;
  late String overview;
  late String image;
  late dynamic voteAverage;
  late String date;
  late double popularity;
  late bool adult;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['known_for'][0]['poster_path'];
    overview = json['known_for'][0]['overview'];
    voteAverage = json['known_for'][0]['vote_average'];
    popularity = json['known_for'][0]['popularity'];
    adult = json['known_for'][0]['adult'];
    date = json['known_for'][0]['release_date'];
  }
}

class MovieDiscoverModel {
  List<DiscoverModel> discover = [];

  MovieDiscoverModel.fromJson(Map<String, dynamic> json) {
    json['results'].forEach((element) {
      discover.add(DiscoverModel.fromJson(element));
    });
  }
}

class DiscoverModel {
  late int id;
  late String name;
  late String overview;
  late String image;
  late dynamic voteAverage;
  late String date;
  late double popularity;
  late bool adult;

  DiscoverModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['original_title'];
    overview = json['overview'];
    image = json['backdrop_path'] ??
        'https://wikireviews.com/blog/wp-content/uploads/2015/06/Movies-where-nothing-happens.jpg';

    voteAverage = json['vote_average'];
    popularity = json['popularity'];
    date = json['release_date'];
    adult = json['adult'];
  }
}

class CastModel {
  List name = [];
  List image = [];
  CastModel.fromJson(json) {
    json['cast'].forEach((element) {
      name.add(element["name"]);
      image.add(element["profile_path"]);
    });
  }
}

class GenerModel {
  List<String> name = [];

  GenerModel.fromJson(json) {
    json['genres'].forEach((element) {
      name.add(element['name']);
    });
  }
}
