// ignore_for_file: depend_on_referenced_packages

import 'package:http/http.dart' as http;


class HttpClient {
  final http.Client client;

  HttpClient({http.Client? client}) : client = client ?? http.Client();

  Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}
