const _kUuid = 'uuid';
const _kTitle = 'title';
const _kAuthor = 'author';
const _kIsPopular = 'isPopular';
const _kIsNewRelease = 'isNewRelease';
const _kGenre = 'genre';
const _kDescription = 'description';
const _kPosterUrl = 'posterUrl';

class Book {
  String uuid;
  String title;
  String author;
  bool isPopular;
  bool isNewRelease;
  String genre;
  String description;
  String posterUrl;

  Book({
    required this.uuid,
    required this.title,
    required this.author,
    required this.isPopular,
    required this.isNewRelease,
    required this.genre,
    required this.description,
    required this.posterUrl,
  });

  Book.fromJson(Map<String, dynamic> json)
      : uuid = json[_kUuid],
        title = json[_kTitle],
        author = json[_kAuthor],
        isPopular = json[_kIsPopular],
        isNewRelease = json[_kIsNewRelease],
        genre = json[_kGenre],
        description = json[_kDescription],
        posterUrl = json[_kPosterUrl];

  Map<String, dynamic> toJson() => {
        _kUuid: uuid,
        _kTitle: title,
        _kAuthor: author,
        _kIsPopular: isPopular,
        _kIsNewRelease: isNewRelease,
        _kGenre: genre,
        _kDescription: description,
        _kPosterUrl: posterUrl,
      };
}
