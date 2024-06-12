class ItemList {
  int id;
  String item;

  ItemList(this.id, this.item);

  static ItemList fromMap(Map map) {
    return ItemList(
        map['id'] as int,
        map['item'] as String
    );
  }
}