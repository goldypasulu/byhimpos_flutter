class ListKategori {
  int id;
  dynamic name;

  ListKategori({
    required this.id,
    required this.name,
  });

  factory ListKategori.fromJson(Map<String, dynamic> json) {
    return ListKategori(
      id: json['id'],
      name: json['name'],
    );
  }
}
