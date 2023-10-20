import 'package:cep_consult/model/cep_model.dart';
import 'package:cep_consult/pages/edit_cep_page.dart';
import 'package:cep_consult/repository/cep_repository.dart';
import 'package:flutter/material.dart';

class ListCepPage extends StatefulWidget {
  const ListCepPage({super.key});

  @override
  State<ListCepPage> createState() => _ListCepPageState();
}

class _ListCepPageState extends State<ListCepPage> {
  bool onLoading = false;
  late CepRepository cepRepo;
  List<CepModel> cepList = [];

  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() async {
    cepRepo = CepRepository();
    retrieveCeps();
  }

  void retrieveCeps() async {
    setState(() {
      onLoading = true;
    });
    var ceps = await cepRepo.list();

    setState(() {
      cepList = ceps;
      onLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return onLoading
        ? const Center(child: CircularProgressIndicator())
        : cepList.isEmpty
            ? const Center(
                child: Text("Sem CEP's cadastrados ainda!"),
              )
            : ListView.builder(
                itemBuilder: (_, int index) {
                  var cep = cepList[index];
                  return InkWell(
                    onTap: () {},
                    child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cep.cep!,
                                style: const TextStyle(fontSize: 24),
                              ),
                              Text(cep.logradouro!)
                            ],
                          ),
                        ),
                        leading: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await cepRepo.delete(cep.id!);
                            // ignore: use_build_context_synchronously
                            showDialog(
                                context: context,
                                builder: (_) => const AlertDialog(
                                      content:
                                          Text('Cep Deletado com sucesso!'),
                                    ));

                            retrieveCeps();
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            var hasChanged = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditCepPage(cep: cep)));

                            if (hasChanged != null && hasChanged) {
                              retrieveCeps();
                            }
                          },
                          icon: const Icon(Icons.edit),
                        )),
                  );
                },
                itemCount: cepList.length,
              );
  }
}
