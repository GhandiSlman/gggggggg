import 'package:get_storage/get_storage.dart';

const baseUrl = "http://192.168.103.80:8000/api/";
const imageBaseUrl = "http://192.168.103.80:8000/storage/";
final box = GetStorage();
// class HttpService {
//   late SharedPreferences prefs;
//   http.Client client = http.Client();

//   HttpService() {
//     _init();
//   }

//   void _init() async {
//     prefs = await SharedPreferences.getInstance();
//   }
//   void close() {
//     client.close();
//   }
// }
