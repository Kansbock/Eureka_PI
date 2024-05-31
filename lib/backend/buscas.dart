import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> BuscarAluno(String nomeAluno) async {
    final uri = Uri.parse("http://192.168.15.10/dashboard/Eureka_2023/getdata.php?nome=$nomeAluno");
    final response = await http.get(uri);
    final data = json.decode(response.body);
    return data;
  }
Future<List<dynamic>> BuscarProjeto(String nomeProjeto) async {
    final uri = Uri.parse("http://192.168.15.10/dashboard/Eureka_2023/getprojeto.php?tituloTrabalho=$nomeProjeto");
    final response = await http.get(uri);
    final data = json.decode(response.body);
    return data;
  }
Future<List<dynamic>> BuscarCoordenadas(String estande) async {
    final uri = Uri.parse("http://192.168.15.10/dashboard/Eureka_2023/getcoordenadas.php?estandes=$estande");
    final response = await http.get(uri);
    final data = json.decode(response.body);
    return data;
  }