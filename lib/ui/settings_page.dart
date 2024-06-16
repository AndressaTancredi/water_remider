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
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Configurações',
            style: TextStyle(color: Colors.blueAccent)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
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
            const Text(
              'Meta Diária de Água (ml)',
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            TextField(
              controller: _goalController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const Text(
              'Valor do Botão (ml)',
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            TextField(
              controller: _buttonValueController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blueAccent,
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.blueAccent),
              ),
              child:
                  const Text('OK', style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        ),
      ),
    );
  }
}
