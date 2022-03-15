class Book {
  String uuid;
  String title;
  String author;

  Book({
    required this.uuid,
    required this.title,
    required this.author,
  });

  Book.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        title = json['title'],
        author = json['author'];

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'author': author,
      };
}
