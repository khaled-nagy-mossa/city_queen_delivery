import 'dart:developer';

class CategoryListParams {
  const CategoryListParams({
    this.parentId,
    this.offset,
    this.limit = 10,
  });

  final int parentId;
  final int offset;
  final int limit;

  CategoryListParams copyWith({
    int parentId,
    int offset,
    int limit,
  }) {
    try {
      return CategoryListParams(
        parentId: parentId ?? this.parentId,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
      );
    } catch (e) {
      log('Exception in CategoryListParams.copyWith : $e');
      return this;
    }
  }

  /// to parse params and get as url
  String get parse {
    var url = '';

    ///add params
    try {
      url += '?';

      if (limit != null && offset != null) {
        url += 'limit=$limit&offset=$offset&';
      }

      if (parentId != null) {
        url += 'parent_id=$parentId';
      }

      ///Erase extra marks
      if (url[url.length - 1] == '&') {
        url = url.substring(0, url.length - 1);
      }
      if (url[url.length - 1] == '?') {
        url = url.substring(0, url.length - 1);
      }

      return url;
    } catch (e) {
      log('Exception in CategoryListParams.parse :$e');
      return url;
    }
  }
}
