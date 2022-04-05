import 'dart:developer';

import '../../model/product_list.dart';

import 'products_cubit.dart';

///helper methods
extension ProductsCubitExtension on ProductsCubit {
  void initialFromObject(ProductList initData) {
    if (initData == null) return;

    productList = ProductList(
      count: initData.count,
      products: initData.products,
    );
  }

  bool get isEmpty {
    try {
      return productList.count == null ||
          productList.count == 0 ||
          productList == null ||
          productList.products.isEmpty ||
          productList.unusable;
    } catch (e) {
      log('Exception in ProductsCubitExtension.isEmpty : $e');
      return true;
    }
  }

  void resetCubitData() {
    /// comment this to show data in the background in screen
    // filteredProductList = common ProductList();
    // productList = common ProductList();

    resetOffset();
  }

  void increaseOffset() {
    params = params.copyWith(offset: (params?.offset ?? -10) + 10);
  }

  void decreaseOffset() {
    params = params.copyWith(offset: (params?.offset ?? 10) - 10);
  }

  void resetOffset() {
    params = params.copyWith(offset: 0);
  }
}
