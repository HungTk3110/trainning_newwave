void main() {
  print(isValid("()[]{}"));
}

bool isValid(String s) {
  String d1 = "()";
  String d2 = "{}";
  String d3 = "[]";
  while (s.isNotEmpty) {
    if (s.contains(d1)) {
      s = s.replaceAll(d1, '');
    } else if (s.contains(d2)) {
      s = s.replaceAll(d2, '');
    } else if (s.contains(d3)) {
      s = s.replaceAll(d3, '');
    } else {
      return false;
    }
  }
  return true;
}
