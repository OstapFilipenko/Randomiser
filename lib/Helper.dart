import 'package:randomiser/Models/List_Of_Items.dart';

class Helper{
  List<List_Of_Items> list = new List();


  void addToList(List_Of_Items lt){
    list.add(lt);
  }

  List<List_Of_Items> getList(){
    return this.list;
  }

}