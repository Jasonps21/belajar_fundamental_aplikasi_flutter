class Menu {
  List<String> foods;
  List<String> drinks;

  Menu({this.foods, this.drinks});

  Menu.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = new List<String>();
      json['foods'].forEach((v) {
        foods.add(v['name']);
      });
    }
    if (json['drinks'] != null) {
      drinks = new List<String>();
      json['drinks'].forEach((v) {
        drinks.add(v['name']);
      });
    }
  }
}
