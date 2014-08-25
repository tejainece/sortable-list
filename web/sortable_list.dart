import "dart:html";
import "package:polymer/polymer.dart";
import "sortable-list/sortable-list.dart";
import "dart:math";

class Data extends Observable {
  @observable String _title;
  
  Data(String arg_title) {
    _title = arg_title;
  }
  
  get title => _title;
  
  set title(String title) {
    String oldval = _title;
    _title = title;
    notifyPropertyChange(#title, oldval, _title);
  }
}

SortableList slist;
ObservableList datalist;

main() {
  datalist = new ObservableList.from([toObservable(new Data("Item1")), toObservable(new Data("Item2")), toObservable(new Data("Item3")), toObservable(new Data("Item4"))]);

  initPolymer().run(() {
    slist = querySelector("#list1");
    slist.data = datalist;
  });

  ButtonElement but_add = querySelector("#but_add");
  but_add.onClick.listen((MouseEvent me) {
    datalist.add(toObservable(new Data("New Item")));
  });

  ButtonElement but_remove = querySelector("#but_remove");
  but_remove.onClick.listen((MouseEvent me) {
    datalist.removeLast();
  });

  ButtonElement but_change = querySelector("#but_change");
  but_change.onClick.listen((MouseEvent me) {
    int i = 0;
    for (Data data in datalist) {
      i++;
      data.title = "Item${i}";
    }
  });
  
  ButtonElement but_rearrange = querySelector("#but_rearrange");
  but_rearrange.onClick.listen((MouseEvent me) {
    datalist.shuffle(new Random());
  });

}
