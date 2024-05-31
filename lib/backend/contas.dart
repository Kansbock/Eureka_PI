import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> BuscarConta(String email) async {
  final uri = Uri.parse(
      "http://192.168.15.10/dashboard/Eureka_2023/getcontas.php?email=$email");
  final response = await http.get(uri);
  final data = json.decode(response.body);
  return data;
}

Future<List<dynamic>> BuscarCPF(String cpf) async {
  final uri = Uri.parse(
      "http://192.168.15.10/dashboard/Eureka_2023/getcpf.php?cpf=$cpf");
  final response = await http.get(uri);
  final data = json.decode(response.body);
  return data;
}

Future<bool> cadastro(String nome, String cpf, String telefone, String perfil,
    String email, String senha) async {
  var url = 'http://192.168.15.10/dashboard/Eureka_2023/inserirdados.php';

  var data = {
    'nome': nome,
    'cpf': cpf,
    'telefone': telefone,
    'perfil': perfil,
    'email': email,
    'senha': senha
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

Future<bool> mudarSenha(
    String email, String senha) async {
  var url = 'http://192.168.15.10/dashboard/Eureka_2023/mudarSenha.php?email=$email&nova_senha=$senha';

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
