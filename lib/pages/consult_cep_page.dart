import 'package:cep_consult/pages/list_cep_page.dart';
import 'package:cep_consult/repository/cep_repository.dart';
import 'package:flutter/material.dart';

class ConsultCepPage extends StatefulWidget {
  const ConsultCepPage({super.key});

  @override
  State<ConsultCepPage> createState() => _ConsultCepPageState();
}

class _ConsultCepPageState extends State<ConsultCepPage> {
  TextEditingController cepController = TextEditingController(text: "");
  PageController pgController = PageController(initialPage: 0);
  var selectedPage = 0;
  List<String> ceps = [];

  late CepRepository cepRepo;

  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() async {
    cepRepo = CepRepository();
  }

  onSubmitCep() async {
    var val = cepController.text;
    if (val != "") {
      var parsedValue = int.tryParse(val);
      if (parsedValue != null) {
        cepRepo.get(parsedValue);
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content:
                      Text('CEP Registrado! Vá para a página de listagem.'),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text('CEP inserido incorretamente'),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Buscar Cep:',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 220,
          child: TextField(
            maxLength: 8,
            controller: cepController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text("CEP"),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 220,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: onSubmitCep,
                  child: const Icon(
                    Icons.send,
                    size: 26,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
