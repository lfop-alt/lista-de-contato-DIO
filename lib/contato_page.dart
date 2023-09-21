import 'package:flutter/material.dart';
import 'package:list_of_contact/cadastrar_contato_page.dart';
import 'package:list_of_contact/contato_model.dart';
import 'package:list_of_contact/contato_repository.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  ContatoRepository contatoRepository = ContatoRepository();

  List<ContatoModel> contatos = <ContatoModel>[];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getContato();
  }

  void getContato() async {
    contatos = await contatoRepository.getContatos();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CadastrarContatoPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contatos.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(contatos[index].objectId!),
                  onDismissed: (_) async {
                    await contatoRepository
                        .deleteContato(contatos[index].objectId!);
                    getContato();
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(contatos[index].name!),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Tel: ${contatos[index].telefoneFixo!}"),
                              Text(
                                  "Celular: ${contatos[index].telefoneCelular!}")
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(contatos[index].email!),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
