import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final double goal;
  final double buttonValue;

  const SettingsPage(
      {super.key, required this.goal, required this.buttonValue});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late TextEditingController _goalController;
  late TextEditingController _buttonValueController;

  @override
  void initState() {
    super.initState();
    _goalController =
        TextEditingController(text: widget.goal.toInt().toString());
    _buttonValueController =
        TextEditingController(text: widget.buttonValue.toInt().toString());
  }

  void _saveSettings() {
    Navigator.pop(context, {
      'goal': double.parse(_goalController.text),
      'buttonValue': double.parse(_buttonValueController.text),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: const Text('Configurações',
            style: TextStyle(color: Colors.black54, fontSize: 26)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.black54),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Meta Diária de Água (ml)',
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            TextField(
              controller: _goalController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 40),
            const Text(
              'Valor do Botão (ml)',
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            TextField(
              controller: _buttonValueController,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('CONTINUAR',
                    style: TextStyle(color: Colors.black54, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
