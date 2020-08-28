class List_Of_Items {
  final int id;
  final String name;
  final String item;

  List_Of_Items({
    this.id,
    this.name,
    this.item,
  });

  String getName() {
    return this.name;
  }

  String getItem() {
    return this.item;
  }

  int getID() {
    return this.id;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'item': item,
      'id': id,
    };
  }

  @override
  String toString() {
    return "The Id: $id, The List name: $name, The item name: $item";
  }
}
