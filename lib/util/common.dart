import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ntp/ntp.dart';

const mobileWidth = 600;
const timer = 3;


class LoginData {
  final String loja;
  final String latitude;
  final String longitude;

  LoginData({required this.loja, required this.latitude , required this.longitude});
}

class LoginSingleton {
  static LoginData? _loginData;

  LoginSingleton._();

  static LoginData get loginData {
    assert(_loginData != null, 'Dados de login Não disponiveis');
    return _loginData!;
  }

  static void setLoginData(LoginData loginData) {
    _loginData = loginData;
  }

}



Future<List> getProdutos() async {
  final response =
  await http.get(Uri.parse('https://devtecapps.com.br/ixin/getProdutos.php'));
  return json.decode(response.body);
}

Future<List> getTypeOs() async {
  final response =
  await http.get(Uri.parse('https://devtecapps.com.br/ixin/getTypeOs.php'));
  return json.decode(response.body);
}

Future<List> getSeller() async {
  final response =
  await http.get(Uri.parse('https://devtecapps.com.br/ixin/getSeller.php'));
  return json.decode(response.body);
}

Future<List> getStore() async {
  final response =
  await http.get(Uri.parse('https://devtecapps.com.br/ixin/getStore.php'));
  return json.decode(response.body);
}

Future<List> getMotoboyName() async {
  final response =
  await http.get(Uri.parse('https://devtecapps.com.br/ixin/getMotoboy.php'));
  return json.decode(response.body);
}

Future<List> getOs(int storeName) async{
  var url = "https://devtecapps.com.br/ixin/getOs.php?loja=$storeName";
  final uri = Uri.tryParse(url);

  final response = await http.get(uri!);
  return jsonDecode(response.body);

}

Future<List> getEncomenda(int storeName) async{
  var url = "https://devtecapps.com.br/ixin/getDataOrder.php?loja=$storeName";
  final uri = Uri.tryParse(url);

  final response = await http.get(uri!);
  return jsonDecode(response.body);

}

Future<List<dynamic>> getOsLimit(int storeName) async {
  final response = await http.get(Uri.parse('https://devtecapps.com.br/ixin/getOsLimit.php?loja=$storeName'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Falha ao carregar dados do servidor');
  }
}

Future<List<Map<String, dynamic>>> getHistoryOs(int storeName) async {
  final response = await http.get(Uri.parse('https://devtecapps.com.br/ixin/getHistoryOs.php?loja=$storeName'));
  final List<dynamic> produtosJson = jsonDecode(response.body);
  final List<Map<String, dynamic>> produtos = produtosJson.cast<Map<String, dynamic>>();
  return produtos;
}


Future<List> getMotoboy() async{
  var url = "https://devtecapps.com.br/ixin/getRotaMotoboy.php";

  final uri = Uri.tryParse(url);

  final response = await http.get(uri!);
  return jsonDecode(response.body);

}

Future<List> getProduto(int storeName) async{
  var url = "https://devtecapps.com.br/ixin/getListProdutos.php?loja=$storeName";
  final uri = Uri.tryParse(url);

  final response = await http.get(uri!);
  return jsonDecode(response.body);

}



Future<List> getData() async{
  var url = "https://devtecapps.com.br/ixin/getWarning.php";

  final uri = Uri.tryParse(url);

  final response = await http.get(uri!);
  return jsonDecode(response.body);

}

Future<List> getSP() async{
  const  url = "https://devtecapps.com.br/ixin/getDataSP.php";
  final uri = Uri.tryParse(url);

  final response = await http.get(uri!);
  return jsonDecode(response.body);

}



Future<DateTime?> getCurrentTime() async {
  DateTime? currentTime;
  try {
    currentTime = await NTP.now();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return currentTime;
}


