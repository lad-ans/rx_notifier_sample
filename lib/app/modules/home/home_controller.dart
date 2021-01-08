import 'package:rx_notifier/rx_notifier.dart';

class HomeController {
  /// RxNotifiers
  final _list = RxNotifier<List<String>>(RxList());

  final _item = RxNotifier<String>(null);

  /// getters e setter to avoid data.value o calling data
  List<String> get list => this._list.value;
  String get item => this._item.value;
  set item(String value) => this._item.value = value;

  /// add item to list function
  void addItem() => this._list.value.add(_item.value);

  /// remove item from list function
  void removeItem(index) => this._list.value.removeAt(index);
}
