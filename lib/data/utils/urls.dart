class Urls{
  static const String _baseUrl = 'http://192.168.0.243:5000/api/auth';
  static const String _baseUrl1 = 'http://192.168.0.243:5000/api/task';
  static const String registerUrl = '$_baseUrl/register';
  static const String logInUrl = '$_baseUrl/login';
  static const String updateProfileUrl ='$_baseUrl/profile-update';
  static const String createTaskUrl = '$_baseUrl1/create';
}