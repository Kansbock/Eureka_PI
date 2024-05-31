import 'package:flutter/material.dart';
import 'package:sprint2/backend/contas.dart';
import 'package:sprint2/paginas/tipoBusca.dart';
import 'package:sprint2/widgets/appBar.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool _nomeVazio = false;
  bool _cpfVazio = false;
  bool _cpfIncorreto = false;
  bool _cpfJaCadastrado = false;
  bool _telefoneVazio = false;
  bool _telefoneIncorreto = false;
  bool _emailVazio = false;
  bool _emailIncorreto = false;
  bool _emailJaCadastrado = false;
  bool _senhaVazio = false;
  bool _senhaPequena = false;
  bool _senhaCVazio = false;
  bool _perfilVazio = false;
  bool _senhasDiferentes = false;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _senhaCController = TextEditingController();
  String? _perfil;

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _senhaCController.dispose();
    super.dispose();
  }

  void _criarConta() async {
    setState(() {
      _nomeVazio = false;
      _cpfVazio = false;
      _cpfIncorreto = false;
      _telefoneVazio = false;
      _telefoneIncorreto = false;
      _emailVazio = false;
      _emailIncorreto = false;
      _senhaVazio = false;
      _senhaPequena = false;
      _senhaCVazio = false;
      _perfilVazio = false;
      _senhasDiferentes = false;
      String? nome = _nomeController.text;
      String? cpf = _cpfController.text;
      String? telefone = _telefoneController.text;
      String? email = _emailController.text;
      String? senha = _senhaController.text;
      String? senhaC = _senhaCController.text;
      if (nome.isEmpty) {
        _nomeVazio = true;
      }
      if (cpf.isEmpty) {
        _cpfVazio = true;
      }
      RegExp cpfRegex = RegExp(r'^(\d{3}\.?\d{3}\.?\d{3}-?\d{2})$');
      if (!cpfRegex.hasMatch(cpf)) {
        _cpfIncorreto = true;
        _cpfController.clear();
      }
      if (telefone.isEmpty) {
        _telefoneVazio = true;
      }
      RegExp telefoneRegex = RegExp(r'^\d{2}\s?\d{4,5}-?\d{4}$');
      if (!telefoneRegex.hasMatch(telefone)) {
        _telefoneIncorreto = true;
        _telefoneController.clear();
      }
      if (email.isEmpty) {
        _emailVazio = true;
      }
      RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        _emailIncorreto = true;
        _emailController.clear();
      }
      if (senha.isEmpty) {
        _senhaVazio = true;
      }
      if (senha.length < 6) {
        _senhaPequena = true;
        _senhaController.clear();
        _senhaCController.clear();
      }
      if (senhaC.isEmpty) {
        _senhaCVazio = true;
      }
      if (_perfil == null) {
        _perfilVazio = true;
      }
      if (senha != senhaC) {
        _senhasDiferentes = true;
        _senhaCController.clear();
      }
      if (!_nomeVazio &&
          !_cpfVazio &&
          !_cpfIncorreto &&
          !_telefoneVazio &&
          !_telefoneIncorreto &&
          !_emailVazio &&
          !_emailIncorreto &&
          !_senhaVazio &&
          !_senhaPequena &&
          !_senhaCVazio &&
          !_perfilVazio &&
          !_senhasDiferentes) {
        cadastro(nome, cpf, telefone, _perfil!, email, senha);
        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => tipoBusca()),
                        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 41, 141, 1),
      appBar: const AppBarM(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Criar uma conta",
                style: TextStyle(fontSize: 30, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: _nomeVazio
                        ? 'Digite seu nome completo'
                        : 'Nome completo',
                    hintStyle:
                        TextStyle(color: _nomeVazio ? Colors.red : Colors.grey),
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _nomeVazio ? Colors.red : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _nomeVazio ? Colors.red : Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: TextField(
                  controller: _cpfController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: _cpfVazio
                        ? 'Digite seu CPF'
                        : _cpfIncorreto
                            ? 'CPF inválido'
                            : _cpfJaCadastrado
                                ? 'CPF já cadastrado'
                                : 'CPF',
                    hintStyle: TextStyle(
                        color: _cpfVazio || _cpfIncorreto || _cpfJaCadastrado
                            ? Colors.red
                            : Colors.grey),
                    prefixIcon: const Icon(Icons.edit_document),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _cpfVazio || _cpfIncorreto || _cpfJaCadastrado
                              ? Colors.red
                              : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _cpfVazio || _cpfIncorreto || _cpfJaCadastrado
                              ? Colors.red
                              : Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: TextField(
                  controller: _telefoneController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: _telefoneVazio
                        ? 'Digite seu telefone'
                        : _telefoneIncorreto
                            ? 'Telefone incorreto'
                            : 'Telefone(com DDD regional)',
                    hintStyle: TextStyle(
                        color: _telefoneVazio || _telefoneIncorreto
                            ? Colors.red
                            : Colors.grey),
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _telefoneVazio || _telefoneIncorreto
                              ? Colors.red
                              : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _telefoneVazio || _telefoneIncorreto
                              ? Colors.red
                              : Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _perfil,
                      hint: Text(
                        _perfilVazio ? 'Escolha seu perfil' : 'Perfil',
                        style: TextStyle(
                            color: _perfilVazio ? Colors.red : Colors.grey),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'Aluno Mauá', child: Text('Aluno Mauá')),
                        DropdownMenuItem(
                            value: 'Ex-aluno', child: Text('Ex-aluno')),
                        DropdownMenuItem(
                            value: 'Professor Mauá',
                            child: Text('Professor Mauá')),
                        DropdownMenuItem(
                            value: 'Colaborador Mauá',
                            child: Text('Colaborador Mauá')),
                        DropdownMenuItem(
                            value: 'Familiar do Formado',
                            child: Text('Familiar do Formado')),
                        DropdownMenuItem(
                            value: 'Estudante do Ensino Médio',
                            child: Text('Estudante do Ensino Médio')),
                        DropdownMenuItem(
                            value: 'Professor do Ensino Médio',
                            child: Text('Professor do Ensino Médio')),
                        DropdownMenuItem(
                            value: 'Investidor', child: Text('Investidor')),
                        DropdownMenuItem(
                            value: 'Empresário', child: Text('Empresário')),
                        DropdownMenuItem(
                            value: 'Outros', child: Text('Outros')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _perfil = value;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                              color: _perfilVazio ? Colors.red : Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                              color: _perfilVazio ? Colors.red : Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: _emailVazio
                        ? 'Digite seu email'
                        : _emailIncorreto
                            ? 'Email inválido'
                            : _emailJaCadastrado
                                ? 'Email já cadastrado'
                                : 'Email',
                    hintStyle: TextStyle(
                        color:
                            _emailVazio || _emailIncorreto || _emailJaCadastrado
                                ? Colors.red
                                : Colors.grey),
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _emailVazio ||
                                  _emailIncorreto ||
                                  _emailJaCadastrado
                              ? Colors.red
                              : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _emailVazio ||
                                  _emailIncorreto ||
                                  _emailJaCadastrado
                              ? Colors.red
                              : Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: _senhaVazio
                        ? 'Digite sua senha'
                        : _senhaPequena
                            ? 'Senha muito pequena'
                            : 'Senha',
                    hintStyle: TextStyle(
                        color: _senhaVazio || _senhaPequena
                            ? Colors.red
                            : Colors.grey),
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _senhaVazio ? Colors.red : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _senhaVazio ? Colors.red : Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: TextField(
                  controller: _senhaCController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: _senhaCVazio
                        ? 'Confirme a sua senha'
                        : _senhasDiferentes
                            ? 'Senhas diferentes'
                            : 'Confirmar senha',
                    hintStyle: TextStyle(
                        color: _senhaCVazio
                            ? Colors.red
                            : _senhasDiferentes
                                ? Colors.red
                                : Colors.grey),
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _senhaCVazio ? Colors.red : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _senhaCVazio ? Colors.red : Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(0, 26, 114, 1)),
                  ),
                  onPressed: () async {
                    var emailCadastrado =
                        await BuscarConta(_emailController.text);
                    var cpfCadastrado = await BuscarCPF(_cpfController.text);
                    if (emailCadastrado.isEmpty && cpfCadastrado.isEmpty) {
                      _criarConta();
                    } else if (emailCadastrado.isNotEmpty) {
                      setState(() {
                        _emailJaCadastrado = true;
                        _emailController.clear();
                      });
                    }
                    if (cpfCadastrado.isNotEmpty) {
                      setState(() {
                        _cpfJaCadastrado = true;
                        _cpfController.clear();
                      });
                    }
                    Future.delayed(const Duration(seconds: 10), () {
                      setState(() {
                        _emailJaCadastrado = false;
                        _cpfJaCadastrado = false;
                      });
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                    child: Text(
                      "CRIAR",
                      style: TextStyle(
                          color: Color.fromRGBO(216, 207, 207, 1),
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
