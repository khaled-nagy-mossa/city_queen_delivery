import 'dart:developer';

class ProductListParams {
  const ProductListParams({
    this.branchId,
    this.categoryId,
    this.offset,
    this.limit = 10,
    this.search,
  });

  final int branchId;
  final int categoryId;
  final int offset;
  final int limit;
  final String search;

  ProductListParams copyWith({
    int branchId,
    int categoryId,
    int offset,
    int limit,
    String search,
  }) {
    try {
      return ProductListParams(
        branchId: branchId ?? this.branchId,
        categoryId: categoryId ?? this.categoryId,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        search: search ?? this.search,
      );
    } catch (e) {
      log('Exception in ProductListParams.copyWith : $e');
      return this;
    }
  }

  /// to parse params and get as url
  String get parse {
    var url = '';

    ///add params
    try {
      url += '?';

      if (branchId != null) {
        url += 'branch_id=$branchId&';
      }
      if (categoryId != null) {
        url += 'category_id=$categoryId&';
      }
      if (limit != null && offset != null) {
        url += 'limit=$limit&offset=$offset&';
      }
      if (search != null) {
        url += 'search=$search';
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
      log('Exception in ProductListParams.parse :$e');
      return url;
    }
  }
}
