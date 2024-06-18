class ListHistory {
  int id;
  String? transaction_number;
  String? transaction_date;
  String? name_customer;
  String? total_amount;
  String? discount;

  ListHistory({
    required this.id,
    required this.transaction_number,
    required this.transaction_date,
    required this.name_customer,
    required this.total_amount,
    required this.discount,
  });

  factory ListHistory.fromJson(Map<String, dynamic> json) {
    return ListHistory(
      id: json['id'],
      transaction_number: json['transaction_number'] ?? '-',
      transaction_date: json['transaction_date'] ?? '-',
      total_amount: json['total_amount'] ?? '0',
      discount: json['discount'] ?? '0',
      name_customer: json['name_customer'] ?? '-',
    );
  }
}
