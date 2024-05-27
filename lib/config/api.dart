//
// Created by 1 More Code on 27/05/24.
//

class API {
  static String baseUrl = 'https://dummyjson.com';

  static String getAllProducts({int limit = 10, int skip = 0}) =>
      '$baseUrl/products?limit=$limit&skip=$skip';

  static String productById({required String id}) => '$baseUrl/products/$id';

  static String searchProducts(
          {int limit = 10, int skip = 0, required String query}) =>
      '$baseUrl/products/search?q=$query&limit=$limit&skip=$skip';

  static String productsByCategory({required String category}) =>
      '$baseUrl/products/category/$category';

  static String getAllCategories = '$baseUrl/products/categories';

  static String addNewProduct = '$baseUrl/products/add';

  static String updateProduct({required String id}) => '$baseUrl/products/$id';

  static String deleteProduct({required String id}) => '$baseUrl/products/$id';
}
