import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey="USERKEY";
   static String userNameKey="USERNAMEKEY";
  static String userEmailKey="USEREMAILKEY";
  static String userPhoneKey="USERPHONEKEY";


    Future<bool> saveUserId(String getUserId)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString(userIdKey, getUserId);
    }
     Future<bool> saveUserName(String getUserName)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString(userNameKey, getUserName);
    }
     Future<bool> saveUserEmail(String getUserEmail)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString(userEmailKey, getUserEmail);
    }
     
         Future<bool> saveUserPhone(String getUserPhone)async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString(userPhoneKey, getUserPhone);
    }

    Future<String?>getUserId()async{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      return prefs.getString(userIdKey);
    }
    Future<String?>getUserName()async{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      return prefs.getString(userNameKey);
    }
    Future<String?>getUserEmail()async{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      return prefs.getString(userEmailKey);
    }
   
        Future<String?>getUserPhone()async{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      return prefs.getString(userPhoneKey);
    }
}