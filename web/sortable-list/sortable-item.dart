part of sortable_list;

/**
 * A Polymer click counter element.
 */
@CustomTag('sortable-item')
class SortableItem extends PolymerElement {
  @published Data data;
  
  void dataChanged() {
    //print("Changed ${data.title}");
  }

  SortableItem.created() : super.created() {
  }
  
  
  
  void ready() {
    /*this.draggable = true;
    this.onDragStart.listen((MouseEvent m) {
      m.dataTransfer.effectAllowed = 'move';
      m.dataTransfer.setData('text', "");
      print("Clicked ${data.title}");
    });
    
    this.onDrag.listen((MouseEvent m) {
          print("Clicked ${data.title}");
        });
    
    this.onDragEnd.listen((MouseEvent m) {
          print("Clicked ${data.title}");
        });
    
    this.onDragOver.listen((MouseEvent m) {
          print("Clicked ${data.title}");
          m.preventDefault();
        });
    
    this.onDragLeave.listen((MouseEvent m) {
          print("Clicked ${data.title}");
        });
    
    this.onDragEnter.listen((MouseEvent m) {
          print("Clicked ${data.title}");
        });*/
  }
}

