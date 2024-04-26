class ShopList {
  int id;
  String com;

  ShopList(this.id, this.com);

  static ShopList fromMap(Map map) {
    return ShopList(
      map['id'] as int,
      map['com'] as String
    );
  }
}