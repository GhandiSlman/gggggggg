// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:lms/core/data/internet_checker.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'data_state.dart';
import 'package:path/path.dart' as p;
import 'package:http_parser/http_parser.dart';

class DataService {
  final http.Client _client;
  final NetworkInfo _networkInfo;

  DataService(this._client, this._networkInfo);

  Future<DataState<T>> getData<T>({
    String? token,
    required String endPoint,
    String baseUrl = baseUrl,
    Map<String, String>? queryParameters,
    fromJson,
  }) async {
    try {
      if (await checkInternet()) {
        return DataFailed(
          "No internet connection",
          statusCode: HttpStatus.serviceUnavailable,
        );
      }
      final response = await _client.get(
        Uri.parse(baseUrl + endPoint).replace(queryParameters: queryParameters),
        headers: headers(),
      );
      debugPrint('get $endPoint param: $queryParameters');
      debugPrint('response: ${response.body}');
      return handleDataState(response: response, fromJson: fromJson!);
    } catch (e) {
      debugPrint('Error: $e');

      return DataFailed(
        "unknown error",
        statusCode: HttpStatus.internalServerError,
      );
    }
  }

  Future<DataState<T>> postDataWithPhoto<T>({
    String? token,
    required String endPoint,
    required dynamic data,
    required String baseUrl,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      if (await checkInternet()) {
        return DataFailed(
          "No internet connection",
          statusCode: HttpStatus.serviceUnavailable,
        );
      }
      print(data);
      var uri = Uri.parse(baseUrl + endPoint);
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(headers());

      data.forEach((key, value) async {
        if (value is List<String>) {
          for (String imagePath in value) {
            File imageFile = File(imagePath);
            XFile? compressedImage = await compressImage(imageFile);
            if (compressedImage != null) {
              request.files.add(
                http.MultipartFile(
                  'images[]',
                  compressedImage.openRead(),
                  await getFileLength(compressedImage),
                  filename: p.basename(compressedImage.path),
                  contentType: MediaType('image', 'jpeg'),
                ),
              );
            }
          }
        } else if (key == 'image') {
          File imageFile = File(value);
          XFile? compressedImage = await compressImage(imageFile);
          if (compressedImage != null) {
            request.files.add(
              http.MultipartFile(
                'image',
                compressedImage.openRead(),
                await getFileLength(compressedImage),
                filename: p.basename(compressedImage.path),
                contentType: MediaType('image', 'jpeg'),
              ),
            );
          }
        } else {
          request.fields[key] = value.toString();
        }
      });

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      debugPrint('response: $responseBody');

      return handleDataState(
        response: http.Response(responseBody, response.statusCode),
        fromJson: fromJson,
      );
    } catch (e) {
      debugPrint('Error: $e');
      return DataFailed(
        "unknown error",
        statusCode: HttpStatus.internalServerError,
      );
    }
  }

  Future<DataState<T>> postData<T>({
    String? token,
    required String endPoint,
    required dynamic data,
    String baseUrl = baseUrl,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    print(data);
    try {
      if (await checkInternet()) {
        return DataFailed(
          "No internet connection",
          statusCode: HttpStatus.serviceUnavailable,
        );
      }
      debugPrint('post $endPoint body: ${json.encode(data)}');
      final response = await _client.post(
        Uri.parse(baseUrl + endPoint),
        headers: headers(),
        body: json.encode(data),
      );
      debugPrint('response: ${response.body}');
      return handleDataState(response: response, fromJson: fromJson);
    } catch (e) {
      debugPrint('Error: $e');
      return DataFailed(
        "unknown error",
        statusCode: HttpStatus.internalServerError,
      );
    }
  }

  Future<bool> checkInternet() async {
    return !(await _networkInfo.isConnected);
  }

  Future<DataState<T>> handleDataState<T>({
    required http.Response response,
    required fromJson,
  }) async {
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final object = fromJson(jsonData);
      return DataSuccess(object);
    } else {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      if (response.statusCode == 410) {
        Get.offAllNamed(AppRouter.loginScreen);
        box.erase();
      }
      return DataFailed(
        jsonData['error'] ?? 'unknown error',
        statusCode: response.statusCode,
      );
    }
  }

  Map<String, String> headers() {
    var headerMap = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      'lang': "en"
    };
    String? token = box.read('token');
    if (token != null && token.isNotEmpty) {
      headerMap[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    return headerMap;
  }

  Future<int> getFileLength(XFile xfile) async {
    final file = File(xfile.path);
    return file.lengthSync();
  }

  Future<XFile?> compressImage(File imageFile) async {
    // Generate a unique target path
    String fileName = p.basename(imageFile.path);
    String dirPath = p.dirname(imageFile.path);
    String targetPath =
        '$dirPath/${fileName}_compressed.jpg'; // Append "_compressed" to the original file name

    // Compress the image
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      targetPath,
      quality: 88, // Adjust compression level as needed
    );
    return compressedImage;
  }
}
