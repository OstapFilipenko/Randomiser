class List_Of_Items{
  final String name;
  final List<String> items; 

  List_Of_Items(
    this.name,
    this.items
  );
  
  String getName(){
    return this.name;
  }

  List<String> getItems(){
    return this.items;
  }

  String toString(){
    return "Name:$name|Items:" + items.join(",");
  }

}