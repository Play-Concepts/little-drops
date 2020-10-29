var list = [
  {
    'id': 1, 'index': 1
  },
  {
    'id': 2, 'index': 2
  },
  {
    'id': 3, 'index': 3
  },
  {
    'id': 4, 'index': 4
  },
  {
    'id': 5, 'index': 5
  },
];

void upTest(int index) {
  print(list);
  var itemToMove = list.removeAt(index);
  print(list);
  itemToMove['index'] -= 1;
  list.insert(index - 1, itemToMove);
  print(list);
  list[index]['index'] += 1;
  print(list);
}

void main() {
  upTest(2);
}