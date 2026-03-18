abstract class BaseApiServices {
  Future<dynamic> getApi(String url);
  Future<dynamic> getApi1(String url, var header);
  Future<dynamic> postApi(dynamic data, String url);
  Future<dynamic> postApi1(dynamic data, String url, var header);
  Future<dynamic> putApi(dynamic data, String url);
  Future<dynamic> deleteApi(String url);
}
