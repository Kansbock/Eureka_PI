import 'package:sprint2/backend/contas.dart';
import 'package:test/test.dart';

void main() {
  //CA-1
  //Dado que quero fazer login no aplicativo.
  test(
      "Testa para ver se o login está funcionando, fornecendo as informações corretas.",
      () async {
    //Quando eu fornecer as informações corretas.
    String email = "admin";
    String senha = "admin";
    var conta = await BuscarConta(email);
    //Então o aplicativo me permite acesso.
    expect(conta[0]["senha"], senha);
  });
  // CA-2
  // Dado que quero fazer login no aplicativo.
  test("Testa para ver se o login está rejeitando emails não cadastrados.",
      () async {
    //Quando eu fornecer um email não cadastrado.
    String email = "rodrigo@gmail";
    var conta = await BuscarConta(email);
    //Então o aplicativo não me permite acesso.
    expect(conta, isEmpty);
  });
  // CA-3
  // Dado que quero fazer login no aplicativo.
  test("Testa para ver se o login está rejeitando caso a senha esteja incorreta.",
      () async {
    //Quando eu fornecer a senha errada.
    String email = "admin";
    String senha = "TesteSenha";
    var conta = await BuscarConta(email);
    //Então o aplicativo não me permite acesso.
    expect(conta[0]["senha"], isNot(senha) );
  });
}
