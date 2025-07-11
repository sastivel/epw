import 'package:flutter/foundation.dart';
import '../../../utils/common_imports.dart';
import '../core/injection/injection.dart';
import '../core/preference/app_preference.dart';
import 'dio.dart';
import 'interface/login/login_response.dart';

export 'package:dio/dio.dart';

class DioHelper {
  Dio dio = Dio();
  final AppPreferences appPreferences;
  DioHelper({
    required this.appPreferences,
  }) {
    // dio.options.baseUrl = MattermostApiConstants.MATTERMOST_APP_BASE_URL +
    //     MattermostApiConstants.MATTERMOST_BASE_PATH;
    // dio.options.baseUrl = ApiConstants.baseURL);
    dio.options.followRedirects = true;
    dio.options.headers[HttpHeaders.acceptHeader] = "application/json";
    dio.options.validateStatus = (status) => status! <= 500;
    // dio.options.headers[HttpHeaders.accessControlAllowOriginHeader] = "http://127.0.0.1:9021";
    // dio.options.headers[HttpHeaders.accessControlAllowMethodsHeader] =
    //     "GET,PUT,PATCH,POST,DELETE";

    //dio.transformer = JsonTransformer();
    //setup auth interceptor
    _setupAuthInterceptor();
    //setup log interceptor
    // _setupLogInterceptor();
  }

  _setupAuthInterceptor() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
       LoginResponseModel? loginResponse = await appPreferences.getUser();

      if (loginResponse != null && loginResponse.token != null) {
       String? token = loginResponse.token!;
       options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      } else {
        
      }
      // String token = '3zn13ha8yjfmtmch1qgj4m38dh';

      // print('************header**************');
      // print(options.headers[HttpHeaders.authorizationHeader]);

      // if (token == null) {
      //         //no token proceed with request
      //         return options;
      //       } else {
      //         //token exists, check if valid
      //         int currentTime = DateTime.now().millisecondsSinceEpoch;
      //         if (token.expireAt > currentTime) {
      //           // token valid add token and call api
      //           options.headers[HttpHeaders.authorizationHeader] = token.getToken();
      //           return options;
      //         }
      //         //token invalid fetch new token
      //         Token newToken = await _refreshToken(dio, token);
      //         if (newToken == null) {
      //           //failed to get new token
      //           return options;
      //         } else {
      //           // got new token
      //           options.headers[HttpHeaders.authorizationHeader] =
      //               newToken.getToken();
      //           return options;
      //         }
      //       }

      // Do something before request is sent
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onError: (DioError e, handler) {
      if (e.type == DioErrorType.badResponse) {
        switch (e.response!.statusCode) {
          case 401:
            break;
          case 403:
            _showToast("403 Forbidden");
            break;
          case 404:
            _showToast("404 Forbidden");
            break;
          case 429:
            _showToast(
                "Too many requests - ${e.requestOptions.uri.toString()}");
            break;
          case 500:
            _showToast("500 Server Broken");
            break;
          case 405:
            _showToast("405 Method Not Allowed");
            break;
        }
      } else {
        _showToast(e.message!);
      }
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
    }));
  }

  //  _refreshToken(Dio dio, Token oldToken) async {
  //   try {
  //     dio.lock();
  //     Response response = await Dio().post(HttpUrls.getRefreshTokenUrl, data: {
  //       "grant_type": Constants.REFRESH_GRANT,
  //       "client_id": Constants.CLIENT_ID,
  //       "client_secret": Constants.CLIENT_SECRET,
  //       "refresh_token": oldToken.refreshToken,
  //     });

  //     var tokenResp = TokenResponse.fromJson(response.data);
  //     Token token = tokenResp.getToken();
  //     //persist token
  //     if (token != null) await PreferenceHelper.saveToken(token);

  //     dio.unlock();

  //     return token;
  //   } on DioError catch (_) {
  //     dio.unlock();
  //     return null;
  //   }
  // }

  _showToast(String text) {
    // Fluttertoast.showToast(
    //     msg: text,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 14.0);
  }

}

//This transformer runs the json decoding in a background thread.
//Thus returing a Future of Map
class JsonTransformer extends DefaultTransformer {
  JsonTransformer() : super(jsonDecodeCallback: _parseJson);
}

Map<String, dynamic> _parseAndDecode(String response) {
  return jsonDecode(response);
}

Future<Map<String, dynamic>> _parseJson(String text) {
  return compute(_parseAndDecode, text);
}

final Dio dio = DioHelper(
  appPreferences: dl(),
).dio;
