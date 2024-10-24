class Massages {
  final String message;
  Massages(this.message);

  factory Massages.fromJson(jsonData) {
    return Massages(
        jsonData['massage'] ?? ''); // التعامل مع 'massage' بدلاً من 'message'
  }
}
