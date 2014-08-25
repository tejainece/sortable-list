library sortable_list;

import 'package:polymer/polymer.dart';
import 'dart:html';

part "sortable-item.dart";

/**
 * A Polymer click counter element.
 */
@CustomTag('sortable-list')
class SortableList extends PolymerElement with ChangeNotifier  {
  @reflectable @published List get data => __$data; List __$data; @reflectable set data(List value) { __$data = notifyPropertyChange(#data, __$data, value); }

  SortableList.created() : super.created() {
  }
}

