class Pagination {
  const Pagination({
    this.limit,
    this.offset,
  });

  final int limit;
  final int offset;

  Pagination copyWith({int limit, int offset}) {
    return Pagination(
      limit: limit,
      offset: offset,
    );
  }

  String parse() {
    String temp = '?';

    if (limit != null) {
      temp += 'limit=$limit';
    }

    if (offset != null) {
      if (temp.isNotEmpty) {
        temp += '&';
      }

      temp += 'offset=$offset';
    }

    return temp;
  }
}
