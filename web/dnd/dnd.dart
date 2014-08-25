import 'dart:html';

DivElement contianer = querySelector("#sample_container_id");
ParagraphElement p = querySelector("#hello");

void main() {
  querySelector("#sample_text_id")
      ..text = "Click me!"
      ..onClick.listen(reverseText);

  p.onClick.listen((MouseEvent m) {
    print("Hello clicked");
  });

  p.onDragStart.listen((MouseEvent m) {
    print("Drag start");
    m.dataTransfer.setData("text", "hello");
  });

  p.onDrag.listen((MouseEvent m) {
    print("drag");
  });

  p.onDragEnd.listen((MouseEvent m) {
    print("dragend");
    print(m.currentTarget);
  });

  p.onDragOver.listen((MouseEvent m) {
    print("dragover");
    m.preventDefault();
  });

  /*p.onDragLeave.listen((MouseEvent m) {
    print("dragleave");
  });

  p.onDragEnter.listen((MouseEvent m) {
    print("dragenter");
  });*/

  contianer.onDrop.listen((MouseEvent m) {
    print("Dropped ${m.dataTransfer.getData("text")}");
    m.preventDefault();
  });
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
