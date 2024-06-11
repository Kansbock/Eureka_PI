import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:sprint2/backend/buscas.dart';

Future<List<dynamic>> BuscarConta(String email) async {
  final String ip = await lerIPdoArquivo();
  final uri = Uri.parse(
      "http://$ip/dashboard/Eureka_2023/getcontas.php?email=$email");
  final response = await http.get(uri);
  final data = json.decode(response.body);
  return data;
}

Future<List<dynamic>> BuscarCPF(String cpf) async {
  final String ip = await lerIPdoArquivo();
  final uri = Uri.parse(
      "http://$ip/dashboard/Eureka_2023/getcpf.php?cpf=$cpf");
  final response = await http.get(uri);
  final data = json.decode(response.body);
  return data;
}

Future<bool> cadastro(String nome, String cpf, String telefone, String perfil,
    String email, String senha) async {
  
    var bytes = utf8.encode(senha);
    var digest = sha256.convert(bytes);
    String senhaCriptografada = digest.toString();
  final String ip = await lerIPdoArquivo();
  var url = 'http://$ip/dashboard/Eureka_2023/inserirdados.php';

  var data = {
    'nome': nome,
    'cpf': cpf,
    'telefone': telefone,
    'perfil': perfil,
    'email': email,
    'senha': senhaCriptografada
  };

  var response = await http.post(Uri.parse(url), body: data);

  if (response.statusCode == 200) {
    print('Solicitação bem-sucedida');
    print('Resposta do servidor: ${response.body}');
    return true;
  } else {
    print('Erro na solicitação: ${response.statusCode}');
    return false;
  }
}
  Future<void> enviarEmail({
    required String email,
    required String senha,
    required String remetente,
    required String assunto,
    required String corpo,
  }) async {
    final smtpServer = gmail(email, senha);

    final message = Message()
      ..from = Address(email, 'Equipe_Eureka')
      ..recipients.add(remetente)
      ..subject = assunto
      ..text = corpo;

    try {
      final sendReport = await send(message, smtpServer);
      print('Mensagem enviada: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Mensagem não enviada. \n${e.toString()}');
      for (var p in e.problems) {
        print('Erro: ${p.code}: ${p.msg}');
      }
    }
  }
Future<bool> mudarSenha(String email, String senha) async {
  final String ip = await lerIPdoArquivo();
  var bytes = utf8.encode(senha);
  var digest = sha256.convert(bytes);
  String senhaCriptografada = digest.toString();
  
  var url = 'http://$ip/dashboard/Eureka_2023/mudarSenha.php?email=$email&nova_senha=$senhaCriptografada';

  var response = await http.post(Uri.parse(url));

  if (response.statusCode == 200) {
    print('Solicitação bem-sucedida');
    print('Resposta do servidor: ${response.body}');
    return true;
  } else {
    print('Erro na solicitação: ${response.statusCode}');
    return false;
  }
  
}
