import 'package:dio/dio.dart';

import 'contato_model.dart';

class ContatoRepository {
  final _dio = Dio();
  Future<List<ContatoModel>> getContatos() async {
    _dio.options.headers["X-Parse-Application-Id"] =
        "w8k9yUj8U88kzEFNkeOr3WDvcMkMIEgkChuPFcCD";
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "9EKXGI8ZQ2ExhZrbqKUplORfiHqeh1mYdFN7lPa3";
    _dio.options.baseUrl = "https://parseapi.back4app.com/classes/";

    var response = await _dio.get("contatos");

    return (response.data["results"] as List)
        .map((e) => ContatoModel.fromJson(e))
        .toList();
  }

  Future<void> saveContatos(ContatoModel data) async {
    _dio.options.headers["X-Parse-Application-Id"] =
        "w8k9yUj8U88kzEFNkeOr3WDvcMkMIEgkChuPFcCD";
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "9EKXGI8ZQ2ExhZrbqKUplORfiHqeh1mYdFN7lPa3";
    _dio.options.baseUrl = "https://parseapi.back4app.com/classes/";
    _dio.options.headers["Content-Type"] = "application/json";

    await _dio.post("contatos", data: data);
  }

  Future<void> deleteContato(String objectId) async {
    _dio.options.headers["X-Parse-Application-Id"] =
        "w8k9yUj8U88kzEFNkeOr3WDvcMkMIEgkChuPFcCD";
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "9EKXGI8ZQ2ExhZrbqKUplORfiHqeh1mYdFN7lPa3";
    _dio.options.baseUrl = "https://parseapi.back4app.com/classes/";

    await _dio.delete("contatos/$objectId");
  }
}
