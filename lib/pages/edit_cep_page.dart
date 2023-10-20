import 'package:cep_consult/model/cep_model.dart';
import 'package:cep_consult/repository/cep_repository.dart';
import 'package:flutter/material.dart';

class EditCepPage extends StatefulWidget {
  final CepModel cep;
  const EditCepPage({super.key, required this.cep});

  @override
  // ignore: no_logic_in_create_state
  State<EditCepPage> createState() => _EditCepPageState(cep: cep);
}

class _EditCepPageState extends State<EditCepPage> {
  final CepModel cep;
  late CepRepository cepRepo;
  var logradouroController = TextEditingController(text: "");
  var complementoController = TextEditingController(text: "");

  var onLoading = false;
  _EditCepPageState({required this.cep});

  @override
  void initState() {
    super.initState();
    cepRepo = CepRepository();
    setState(() {
      logradouroController.text = cep.logradouro!;
      complementoController.text = cep.complemento ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("CEP: ${cep.cep}"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                        controller: logradouroController,
                        decoration:
                            const InputDecoration(label: Text('Logradouro'))),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: complementoController,
                      decoration:
                          const InputDecoration(label: Text('Complemento')),
                    ),
                  ],
                ),
                onLoading
                    ? const CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              if (logradouroController.text == "" &&
                                  complementoController.text == "") {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const AlertDialog(
                                        content: Text(
                                            "Preencha pelo menos um dos campos!"),
                                      );
                                    });
                                return;
                              }
                              var data = {
                                "logradouro": logradouroController.text,
                                "complemento": complementoController.text
                              };

                              setState(() {
                                onLoading = true;
                              });
                              await cepRepo.update(cep.id!, data);
                              setState(() {
                                onLoading = false;
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop(true);
                            },
                            child: const Icon(Icons.send),
                          ),
                        ],
                      )
              ]),
        ),
      ),
    );
  }
}
