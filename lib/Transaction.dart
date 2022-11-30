class Transaction {
  final String id;
  final String tilte;
  final double total;
  final DateTime date;

  Transaction(
      {required this.total,
      required this.date,
      required this.id,
      required this.tilte});
}
