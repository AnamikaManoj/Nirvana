import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class HelperFunction{
  static String sharedPreferenceLoginInKey='ISLOGGEDIN';
  static String sharedPreferenceNameKey='USERNAMEKEY';
  static String sharedPreferenceEmailKey='EMAILKEY';
  static String sharedPreferenceSearchUserKey='SEARCHUSERKEY';
  static String  sharedPreferencesUserType='USERTYPE';

  //saving data to sharedPreference

static Future<void> saveUserLoggedInState(bool isUserLoggedIn)async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  return await preferences.setBool(sharedPreferenceLoginInKey,isUserLoggedIn);
}
static Future<void> saveUserName(String Username)async{
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceNameKey, Username);
  }catch(e){
    print(e);
  }
}
  static Future<void> saveUserEmail(String Email)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceEmailKey,Email);
  }
  static Future<void> saveSearchUser(String SearchUser)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceSearchUserKey,SearchUser);
  }

  static Future<void> saveUserType(String UserType)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferencesUserType,UserType);
  }

  //Getting Daa from SharedPreference
  static Future<bool> getUserLoggedInState()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceLoginInKey);}

  static Future<String> getUserName()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.get(sharedPreferenceNameKey);
  }
  static Future<String> getUserEmail()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.get(sharedPreferenceEmailKey);
  }
  static Future<String> getSearchUser()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.get(sharedPreferenceSearchUserKey);
  }
  static Future<String> getUserType()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return await preferences.get(sharedPreferencesUserType);
  }
}