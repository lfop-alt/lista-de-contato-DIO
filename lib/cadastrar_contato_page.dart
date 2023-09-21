import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:list_of_contact/contato_model.dart';
import 'package:list_of_contact/contato_page.dart';
import 'package:list_of_contact/contato_repository.dart';
import 'package:path_provider/path_provider.dart';

class CadastrarContatoPage extends StatefulWidget {
  const CadastrarContatoPage({super.key});

  @override
  State<CadastrarContatoPage> createState() => _CadastrarContatoPageState();
}

class _CadastrarContatoPageState extends State<CadastrarContatoPage> {
  final ContatoRepository _contatoRepository = ContatoRepository();

  XFile? image;

  TextEditingController nameController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController telFixoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                "Cadastrar Contato",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: const InputDecoration(
                        hintText: "Digite o nome do Contato",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: celularController,
                    decoration: const InputDecoration(
                        hintText: "Numero de celular",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: telFixoController,
                    decoration: const InputDecoration(
                        hintText: "Numero de Telefone Fixo",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: "Digite o e-mail",
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                image = await picker.pickImage(source: ImageSource.camera);

                setState(() {});
              },
              child: const Text("Carregar Imagem"),
            ),
            image != null
                ? const Text("Imagem Carregada com sucesso")
                : const Text("Nenhuma imagem carregada"),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                final Directory appDocumentsDir =
                    await getApplicationDocumentsDirectory();
                var response = ContatoModel(
                        name: nameController.text,
                        email: emailController.text,
                        telefoneCelular: celularController.text,
                        telefoneFixo: telFixoController.text,
                        image: "${appDocumentsDir.path}/${image!.name}")
                    .toJson();

                await _contatoRepository
                    .saveContatos(ContatoModel.fromJson(response));
                await image!.saveTo("${appDocumentsDir.path}/${image!.name}");

                navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ContatoPage(),
                  ),
                );
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
