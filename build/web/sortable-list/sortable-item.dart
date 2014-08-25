part of sortable_list;

/**
 * A Polymer click counter element.
 */
@CustomTag('sortable-item')
class SortableItem extends PolymerElement with ChangeNotifier  {
  @reflectable @published String get label => __$label; String __$label = "List Item"; @reflectable set label(String value) { __$label = notifyPropertyChange(#label, __$label, value); }

  SortableItem.created() : super.created() {
  }
}

