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

void deleteTest(int index) {
  print(list);
  var itemToDelete = list.removeAt(index);
  print(list);
  for (int i = index; i < list.length; i++) {
    list[i]['index'] = i + 1;
  }
  print(list);
}

void main() {
  deleteTest(2);
}