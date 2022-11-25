import 'dart:convert';
import 'package:http/http.dart' as http;


class Networking {
  static final Networking _instance = Networking._internal();
  static Networking getInstance() => _instance;

  // named constructor
  Networking._internal();

  // Need to be changed
  var _host = 'http://118.68.218.70';
  var _userName = 'Administrator';
  var _password = '';

  Networking setHost(String host) {
    _host = host;
    return _instance;
  }

  Networking setUserName(String userName) {
    _userName = userName;
    return _instance;
  }

  Networking setPassword(String password) {
    _password = password;
    return _instance;
  }

  Future<dynamic> getDogData(String code) async {
    // if (_userName == '' || _password == '' || _host == '') {
    //   throw Exception('Networking props error!');
    // }

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.get(
        Uri.parse(
            '$_host/PetsPark/hs/DogsPark/V1/Dog?Code=$code'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to call API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> getTaskList(String code) async {
  // String dateString = DateFormat("yyyyMMdd").format(date);

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.get(
        Uri.parse(
            '$_host/PetsPark/hs/DogsPark/V1/DayCare?EmployeeCode=$code'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
     if(response.body=="NoData" || response.body=="EmployeeDidNotExist" ){
       return false;
     }else{
       return jsonDecode(response.body);
     }

    } else {
      throw Exception('Failed to call API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> isEmployee(String phone, String password) async {
    // if (_userName == '' || _password == '' || _host == '') {
    //   throw Exception('Networking props error!');
    // }

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.get(
        Uri.parse(
            '$_host/PetsPark/hs/DogsPark/V1/Moderator?ModeratorPhoneNumber=$phone&Password=$password'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to call API, StatusCode: ${response.statusCode}');
    }
  }

  String getUserName() => _userName;
  // String? getPassword() => _password;

  Future<dynamic> getJSON(var url) async {
    // if (_userName == '' || _password == '' || _host == '') {
    //   throw Exception('Networking props error!');
    // }

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response =
    await http.get(Uri.parse('$_host/$url'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to call API, StatusCode: ${response.statusCode}');
    }
  }

  //Get list zone
  Future<dynamic> getListZone() async {
    // String dateString = DateFormat("yyyyMMdd").format(date);

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.get(
        Uri.parse(
            '$_host/PetsPark/hs/DogsPark/V1/Listzone'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      if(response.body=="NoData"){
        return false;
      }else{
        return jsonDecode(response.body);
      }
      // (response.body=="NoData")?return esponse.body:
      // return jsonDecode(response.body);
    } else {
      throw Exception('Failed to call API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> postToken(var url) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response =
    await http.post(Uri.parse('$_host/$url'), headers: requestHeaders);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> putMaintenance(var url, var spobject) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.put(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> putUser(var url, var spobject) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.put(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

/// When check in call to create document into 1c
  Future<dynamic> postCheckInDocument(var object) async {

    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.post(Uri.parse('$_host/PetsPark/hs/DogsPark/V1/NewDogTracking'),
        headers: requestHeaders, body: object);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> putSupport(var url, var object) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.put(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: object);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }

  Future<dynamic> postJSON(var url, var spobject) async {
    if (_userName == '' || _password == '' || _host == '') {
      throw Exception('Networking props error!');
    }

    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.post(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }
  Future<dynamic> putCustomer(var url, var spobject) async {
    // if (_userName == '' || _password == '' || _host == '') {
    //   throw Exception('Networking props error!');
    // }

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.put(Uri.parse('$_host/$url'),
        headers: requestHeaders, body: spobject);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }
  Future<dynamic> putTracking(var dogCode) async {
    // if (_userName == '' || _password == '' || _host == '') {
    //   throw Exception('Networking props error!');
    // }

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_userName:$_password'))}';
    Map<String, String> requestHeaders = {'authorization': basicAuth};

    final response = await http.put(Uri.parse('$_host/PetsPark/hs/DogsPark/V1/NewDogTracking?Code=$dogCode'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post API, StatusCode: ${response.statusCode}');
    }
  }
}
