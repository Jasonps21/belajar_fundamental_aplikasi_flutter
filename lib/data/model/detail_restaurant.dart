class RestaurantDetail {
  RestaurantDetail({
    this.error,
    this.message,
    this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.consumerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<ConsumerReview> consumerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        menus: json["menus"] == null ? [] : Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        consumerReviews: json["customerReviews"] == null
            ? []
            : List<ConsumerReview>.from(
                json["customerReviews"].map((x) => ConsumerReview.fromJson(x))),
      );
}

class Category {
  Category({
    this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );
}

class ConsumerReview {
  ConsumerReview({
    this.name,
    this.review,
    this.date,
  });

  String name;
  String review;
  String date;

  factory ConsumerReview.fromJson(Map<String, dynamic> json) => ConsumerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json["foods"] == null
            ? []
            : List<Category>.from(
                json["foods"].map((x) => Category.fromJson(x))),
        drinks: json["drinks"] == null
            ? []
            : List<Category>.from(
                json["drinks"].map((x) => Category.fromJson(x))),
      );
}

class ConsumerReviewPost {
  ConsumerReviewPost({
    this.id,
    this.name,
    this.review,
  });

  String name;
  String review;
  String id;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
