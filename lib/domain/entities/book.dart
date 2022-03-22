const _kUuid = 'uuid';
const _kTitle = 'title';
const _kAuthor = 'author';

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
      : uuid = json[_kUuid],
        title = json[_kTitle],
        author = json[_kAuthor];

  Map<String, dynamic> toJson() => {
        _kUuid: uuid,
        _kTitle: title,
        _kAuthor: author,
      };
}
