import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> BuscarAluno(String nomeAluno) async {
  final String ip = await lerIPdoArquivo();
  final uri = Uri.parse("http://$ip/dashboard/Eureka_2023/getdata.php?nome=$nomeAluno");
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    data.sort((a, b) => a['nomeAluno'].compareTo(b['nomeAluno']));
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<String> lerIPdoArquivo() async {
  try {
    final String ip = await rootBundle.loadString('assets/ip.txt');
    return ip.trim();
  } catch (e) {
    print('Erro ao ler o arquivo: $e');
    throw Exception('Failed to read IP from file');
  }
}
Future<List<dynamic>> BuscarProjeto(String nomeProjeto) async {
  final String ip = await lerIPdoArquivo();
  final uri = Uri.parse("http://$ip/dashboard/Eureka_2023/getprojeto.php?tituloTrabalho=$nomeProjeto");
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    data.sort((a, b) => a['tituloTrabalho'].compareTo(b['tituloTrabalho']));
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}
Future<List<dynamic>> BuscarCoordenadas(String estande) async {
  final String ip = await lerIPdoArquivo();
    final uri = Uri.parse("http://$ip/dashboard/Eureka_2023/getcoordenadas.php?estandes=$estande");
    final response = await http.get(uri);
    final data = json.decode(response.body);
    return data;
  }