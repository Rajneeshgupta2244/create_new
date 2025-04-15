import 'api_functions.dart';
const String baseUrl = 'http://147.93.121.73/backend/api/';
ApiService apiService=ApiService();

///Auth Api
final Uri signupLoginSentOtpApi = Uri.parse('${baseUrl}auth/onboarding');
