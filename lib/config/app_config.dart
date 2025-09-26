import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late AppConfig _instance;
  
  static AppConfig get instance => _instance;
  
  // Firebase Configuration
  late final String firebaseWebApiKey;
  late final String firebaseAndroidApiKey;
  late final String firebaseIosApiKey;
  late final String firebaseProjectId;
  late final String firebaseMessagingSenderId;
  late final String firebaseAppIdWeb;
  late final String firebaseAppIdAndroid;
  late final String firebaseAppIdIos;
  late final String firebaseAuthDomain;
  late final String firebaseStorageBucket;
  
  // OneSignal Configuration
  late final String oneSignalAppId;
  late final String oneSignalRestApiKey;
  
  // App Configuration
  late final String appName;
  late final bool debugMode;
  
  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
    _instance = AppConfig._internal();
  }
  
  AppConfig._internal() {
    // Firebase Configuration
    firebaseWebApiKey = dotenv.env['FIREBASE_WEB_API_KEY'] ?? '';
    firebaseAndroidApiKey = dotenv.env['FIREBASE_ANDROID_API_KEY'] ?? '';
    firebaseIosApiKey = dotenv.env['FIREBASE_IOS_API_KEY'] ?? '';
    firebaseProjectId = dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
    firebaseMessagingSenderId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
    firebaseAppIdWeb = dotenv.env['FIREBASE_APP_ID_WEB'] ?? '';
    firebaseAppIdAndroid = dotenv.env['FIREBASE_APP_ID_ANDROID'] ?? '';
    firebaseAppIdIos = dotenv.env['FIREBASE_APP_ID_IOS'] ?? '';
    firebaseAuthDomain = dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';
    firebaseStorageBucket = dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
    
    // OneSignal Configuration
    oneSignalAppId = dotenv.env['ONESIGNAL_APP_ID'] ?? '';
    oneSignalRestApiKey = dotenv.env['ONESIGNAL_REST_API_KEY'] ?? '';
    
    // App Configuration
    appName = dotenv.env['APP_NAME'] ?? 'Training App';
    debugMode = dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';
  }
  
  // Validate that all required configuration is present
  bool get isValid {
    return firebaseProjectId.isNotEmpty &&
           firebaseWebApiKey.isNotEmpty &&
           oneSignalAppId.isNotEmpty;
  }
  
  void logConfiguration() {
    if (debugMode) {
      print('=== App Configuration ===');
      print('App Name: $appName');
      print('Debug Mode: $debugMode');
      print('Firebase Project ID: ${firebaseProjectId.isNotEmpty ? "✓ Set" : "✗ Missing"}');
      print('Firebase Web API Key: ${firebaseWebApiKey.isNotEmpty ? "✓ Set" : "✗ Missing"}');
      print('OneSignal App ID: ${oneSignalAppId.isNotEmpty ? "✓ Set" : "✗ Missing"}');
      print('Configuration Valid: ${isValid ? "✓" : "✗"}');
      print('========================');
    }
  }
}
