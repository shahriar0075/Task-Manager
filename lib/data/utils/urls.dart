class Urls{
  static const String _baseUrl = 'http://192.168.0.243:5000/api/auth';
  static const String _baseUrl1 = 'http://192.168.0.243:5000/api/task';
  static const String registerUrl = '$_baseUrl/register';
  static const String logInUrl = '$_baseUrl/login';
  static const String updateProfileUrl ='$_baseUrl/profile-update';
  static const String createTaskUrl = '$_baseUrl1/create';

  static String recoverVerifyEmailUrl(String email)=>'$_baseUrl/recover/verify-email?email=$email';
  static String verifyOtpUrl(String email, String otp)=>'$_baseUrl/recover/verify-otp?email=$email&otp=$otp';
  static const String recoverPasswordUrl = '$_baseUrl/recover/reset-password';

  static const String taskStatusCountUrl = '$_baseUrl1/taskStatusCount';
  static String taskListUrl(String status) {return '$_baseUrl1/listTaskByStatus/$status';}
  static String updateTaskStatusUrl(String id, String status) {return '$_baseUrl1/updateTaskStatus/$id/$status';}
  static String deleteTaskUrl(String id) {return '$_baseUrl1/deleteTask/$id';}
}