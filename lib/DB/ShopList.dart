class ShopList {
  int id;
  int count;
  String item;
  int price;

  ShopList(this.id, this.count, this.item, this.price);

  static ShopList fromMap(Map map) {
    return ShopList(
      map['id'] as int,
      map['count'] as int,
      map['item'] as String,
      map['price'] as int
    );
  }
}