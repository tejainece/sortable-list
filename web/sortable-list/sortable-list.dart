library sortable_list;

import 'package:polymer/polymer.dart';
import 'dart:html';
import '../sortable_list.dart';
import 'dart:async';

part "sortable-item.dart";

class DragData {
  Object _data;
  Element _element;
  bool _has;

  DragData() {
    _has = false;
  }

  void set(Object data, Element element) {
    _data = data;
    _element = element;
    _has = true;
  }
  
  void remove() {
    _data = null;
    _element = null;
    _has = false;
  }

  bool hasData() {
    return _has;
  }
  
  Object getData() {
    return _data;
  }

  Element getElement() {
    return _element;
  }
}

DragData _dragdata = new DragData();
void setDragData(Object data, Element element) {
  _dragdata.set(data, element);
}

void removeDragData() {
  _dragdata.remove();
}

bool hasDragData() {
  return _dragdata.hasData();
}

Object getDragData() {
  return _dragdata.getData();
}

Element getDragElement() {
  return _dragdata.getElement();
}

class DragStreams {
  StreamSubscription dragStart;
  StreamSubscription dragEnd;
  StreamSubscription dragEnter;
  StreamSubscription dragOver;
  StreamSubscription dragLeave;
  StreamSubscription drop;
}

/**
 * A Polymer click counter element.
 */
@CustomTag('sortable-list')
class SortableList<E> extends PolymerElement {
  @published ObservableList<E> data;

  Map<HtmlElement, DragStreams> _dragStreams = new Map<HtmlElement, DragStreams>();

  void dataChanged() {
  }

  SortableList.created() : super.created() {
  }

  void ready() {
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this.shadowRoot, childList: true);
    
    this.draggable = true;
  }

  MutationObserver _observer;
  /*
   * TODO: doesn't work when target is ContentElement. MutationObserver currently doesn't fire
   * when distributed nodes in a ContentElement is mutated.
   */
  void _onMutation(records, observer) {
    //print("Mutated");
    for (MutationRecord record in records) {
      for (Node node in record.addedNodes) {
        if (node is HtmlElement) {
          _registerDragHandlers(node);
        }
      }
      //unselect removed nodes
      for (Node node in record.removedNodes) {
        if (node is HtmlElement) {
          //_degisterDragHandlers(node);
        }
      }
    }
  }

  void _registerDragHandlers(SortableItem ch) {
    ch.draggable = true;
    if (!_dragStreams.containsKey(ch)) {
      DragStreams newStreams = new DragStreams();
      newStreams.dragStart = ch.onDragStart.listen(_onDragStart);
      newStreams.dragEnd = ch.onDragEnd.listen(_onDragEnd);
      newStreams.dragEnter = ch.onDragEnter.listen(_onDragEnter);
      newStreams.dragOver = ch.onDragOver.listen(_onDragOver);
      newStreams.dragLeave = ch.onDragLeave.listen(_onDragLeave);
      newStreams.drop = ch.onDrop.listen(_onDrop);

      _dragStreams[ch] = newStreams;
    }
    
    //TODO: remove
    /*ch.onMouseUp.listen((MouseEvent m) {
      print(hasDragData());
      if(hasDragData()) {
        //simulation of drop
        if(getDragData() is Data) {
          Data d = getDragData();
          //consume
          print("Fake Dragged: ${d.title}");
          print("Fake Dropped: ${m.target.data.title}");
          int index = data.indexOf(m.target.data);
          if(index >= 0) {
            data.insert(index, d);
            removeDragData();
          }
        }
      } else {
        //simulation of drag
        setDragData(ch.data, ch);
        print("Fake start drag: ${ch.data.title}");
        data.remove(ch.data);
      }
      m.stopPropagation();
    });*/
  }

  void _degisterDragHandlers(HtmlElement ch) {
    ch.draggable = false;
    DragStreams newStreams = _dragStreams.remove(ch);
    if (newStreams != null) {
      newStreams.dragStart.cancel();
      newStreams.dragEnd.cancel();
      newStreams.dragEnter.cancel();
      newStreams.dragOver.cancel();
      newStreams.dragLeave.cancel();
      newStreams.drop.cancel();
    }
  }

  void _onDragStart(MouseEvent event) {
    Element dragTarget = event.target;
    print("Dragging ${event.target}");
    //dragTarget.classes.add('dragged');
    event.dataTransfer.effectAllowed = 'move';
    event.dataTransfer.setData('text', "");
  }

  void _onDragEnd(MouseEvent event) {
    print("Drag end!!!!!");
    Element dragTarget = event.target;
    //dragTarget.classes.remove('dragged');
    //TODO: remove over
  }

  void _onDragEnter(MouseEvent event) {
    print("Drag enter!!!!!");
    Element dropTarget = event.target;
    dropTarget.classes.add('over');


    // cache the current from element
    /*Element fromElement = _fromElement;

    // update the from element
    _fromElement = event.target;

    // if we are moving within a single sortable element, bail
    if((event.currentTarget as Element).contains(fromElement)) return;*/

    //TODO: add placeholder
    // get the index of the element begin dragged
    //int dragIndex = items.indexOf(_draggedItem);

    // get the index of the element being dragged into
    //int preIndex = items.indexOf(event.currentTarget);

    // move the dragged element before or after the entered element depending on their positions
    /*if (dragIndex < preIndex) {
      (event.currentTarget as Element).insertAdjacentElement("afterEnd", _draggedItem);
    } else {
      (event.currentTarget as Element).insertAdjacentElement("beforeBegin", _draggedItem);
    }*/
  }

  void _onDragOver(MouseEvent event) {
    print("Drag over!!!!!");
    // This is necessary to allow us to drop.
    event.preventDefault();
    event.dataTransfer.dropEffect = 'move';
  }

  void _onDragLeave(MouseEvent event) {
    Element dropTarget = event.target;
    dropTarget.classes.remove('over');
  }

  void _onDrop(MouseEvent event) {
    print("Dropped!!!!!");
    // Stop the browser from redirecting.
    event.stopPropagation();

    // Don't do anything if dropping onto the same element we're dragging.
    /*Element dropTarget = event.target;
    if (_draggedItem != null && _draggedItem != dropTarget) {
      int ind = children.indexOf(dropTarget);
      children.insert(ind, _draggedItem);
      if(_draggedItemSelected) {
        select(_draggedItem);
      }
    }
    _draggedItem = null;
    _draggedItemSelected = false;
    print("reset _draggedItem");*/
  }
}
