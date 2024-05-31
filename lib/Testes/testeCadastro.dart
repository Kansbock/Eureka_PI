import 'dart:math';

import 'package:sprint2/backend/contas.dart';

import 'package:test/test.dart';

void main() {
  // CA-1
  // Dado que quero fazer cadastro no aplicativo.
  test("Testar para ver se o cadastro está funcionando.", () async {
    //Quando eu fornecer as informações corretas.
    String nome = "Matheus";
    String cpf = "111.222.333-44";
    String telefone = "11 22222-3333";
    String perfil = "Aluno Mauá";
    String email = "matheus@gmail.com";
    String senha = "senhaLegal";
    //Então o aplicativo me permite acesso e cria minha conta.
    expect(await cadastro(nome, cpf, telefone, perfil, email, senha), true);
  });
  // CA-2
  // Dado que quero fazer cadastro no aplicativo.
  test("Testar para ver se o cadastro está funcionando.", () async {
    //Quando eu fornecer um email já cadastrado.
    String nome = "Matheus";
    String cpf = "111.212.333-44";
    String telefone = "11 22222-3333";
    String perfil = "Aluno Mauá";
    String email = "matheus@gmail.com";
    String senha = "senhaLegal";
    var emailJaCadastrado = await BuscarConta(email);
    //Então o aplicativo não me permite criar a conta.
    expect(emailJaCadastrado, isNotEmpty);
  });
  // CA-3
  // Dado que quero fazer cadastro no aplicativo.
  test("Testar para ver se o cadastro está funcionando.", () async {
    //Quando eu fornecer um CPF já cadastrado.
    String nome = "Matheus";
    String cpf = "111.222.333-44";
    String telefone = "11 22222-3333";
    String perfil = "Aluno Mauá";
    String email = "felipe@gmail.com";
    String senha = "senhaLegal";
    var cpfJaCadastrado = await BuscarCPF(cpf);
    //Então o aplicativo não me permite criar a conta.
    expect(cpfJaCadastrado, isNotEmpty);
  });
}
