import 'package:sprint2/backend/buscas.dart';
import 'package:test/test.dart';

void main() {
  //CA-1
  //Dado que quero consultar um aluno específico.
  test("Testar para ver se ele retorna as informações dos alunos.", () async {
    //Quando entrar na tela de busca.
    var alunos = await BuscarAluno("ANA LUISA ALVES DA CUNHA");
    //Então quero pesquisar um nome ou sobrenome em especifico e se ele estiver registrado no banco de dados aparecer na tela, o nome; projeto; o estande; descrição. 
    expect(alunos[0]["nomeAluno"],"ANA LUISA ALVES DA CUNHA");
  });
  //CA-2
  //Dado que quero consultar todos os alunos.
  test("Testar para ver se ao não se digitar nada ele retorna todos os alunos.", () async {
    //Quando entrar na tela sem digitar nenhum nome.
    var alunos = await BuscarAluno("");
    //Então o sistema retorna a lista completa de alunos cadastrados.
    expect(alunos,isNotEmpty);
  });
  //CA-3
  //Dado que quero consultar um aluno específico.
  test("Testar para ver se ele retorna uma lista vazia ao digitar um nome incorreto.", () async {
    //Quando erro o nome do aluno.
    var alunos = await BuscarAluno("ANU LUIZA");
    //Então não irá aparecer ninguém.
    expect(alunos,isEmpty);
  });
  //CA-4
  //Dado que quero consultar um aluno específico.
  test("Testar para ver se ele retorna uma lista vazia ao digitar um nome de um aluno não cadastrado.", () async {
    //Quando o aluno não está registrado.
    var alunos = await BuscarAluno("RODRIGO PEREZ ALMEIDA FERRAZ");
    //Então não irá aparecer ninguém.
    expect(alunos,isEmpty);
  });
  //CA-1
  //Dado que quero consultar um projeto específico.
  test("Testar para ver se ele retorna as informações dos projetos.", () async {
    //Quando entrar na tela de busca.
    var projetos = await BuscarProjeto("A BUSCA DA AUTONOMIA NA COZINHA PARA PESSOAS COM BAIXA VIS\u00c3O");
    //Então quero pesquisar um projeto em especifico e se ele estiver registrado no banco de dados aparecer na tela, o nome do projeto; alunos envolvidos; o estande; descrição. 
    expect(projetos[0]["tituloTrabalho"],"A BUSCA DA AUTONOMIA NA COZINHA PARA PESSOAS COM BAIXA VIS\u00c3O");
  });
  //CA-2
  //Dado que quero consultar todos os projetos.
  test("Testar para ver se ao não se digitar nada ele retorna todos os projetos.", () async {
    //Quando entrar na tela sem digitar nenhum nome.
    var projetos = await BuscarProjeto("");
    //Então o sistema retorna a lista completa de todos os projetos cadastrados.
    expect(projetos,isNotEmpty);
  });
  //CA-3
  //Dado que quero consultar um projeto específico.
  test("Testar para ver se ele retorna uma lista vazia ao digitar um nome de projeto incorreto.", () async {
    //Quando erro o nome do projeto.
    var projetos = await BuscarProjeto("A BUSCAS DA AUTONÔMIA");
    //Então não irá aparecer nenhum.
    expect(projetos,isEmpty);
  });
  //CA-4
  //Dado que quero consultar um projeto específico.
  test("Testar para ver se ele retorna uma lista vazia ao digitar um nome de um projeto não cadastrado.", () async {
    //Quando o projeto não está registrado.
    var projetos = await BuscarProjeto("CRIAÇÂO AVIÂO NUCLEAR");
    //Então não irá aparecer nenhum.
    expect(projetos,isEmpty);
  });
}
