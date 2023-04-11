import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:googleapis/pubsub/v1.dart";
import 'package:googleapis_auth/auth_io.dart';

class MyServices {
  // static const apiKey = "AIzaSyBoE8WasECrnAedkrpBRSe4Tzah7W25dlA";
  // static final _client = clientViaApiKey(apiKey);

  static const String projectPath = "projects/pubsub-seminario";

  static getTopics() async {
    debugPrint("Enviando...");

    // Pega as credenciais do arquivo e formata corretamente
    // Esse arquivo contém as informações privadas da chave da conta de serviço do projeto, é possível utilizar tokens no lugar da chave
    String arquivo = await rootBundle.loadString("lib/pubsub-seminario-private.json");
    ServiceAccountCredentials credenciaisServico =
        ServiceAccountCredentials.fromJson(json.decode(arquivo));
    
    // Cria o objeto de cliente para uso da API
    var credenciais = await clientViaServiceAccount(
        credenciaisServico, [PubsubApi.pubsubScope]);

    try {
      ListTopicsResponse message =
          await PubsubApi(credenciais).projects.topics.list(projectPath);
      for (Topic element in message.topics ?? []) {
        print(element.name);
      }
    } catch (e) {
      print(e);
    }
  }
}
