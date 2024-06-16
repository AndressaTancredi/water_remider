import 'package:flutter/material.dart';
import 'package:water_app/ui/settings_page.dart';
import 'package:water_app/ui/water_painter_widget.dart';

class WaterHomePage extends StatefulWidget {
  const WaterHomePage({super.key});

  @override
  WaterHomePageState createState() => WaterHomePageState();
}

class WaterHomePageState extends State<WaterHomePage>
    with SingleTickerProviderStateMixin {
  double _waterIntake = 0.0;
  late double _waterGoal;
  late double _buttonValue;
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _waterGoal = 2000;
    _buttonValue = 250;
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void _addWater(double amount) {
    if (_waterIntake + amount > _waterGoal) {
      amount = _waterGoal - _waterIntake;
    }
    setState(() {
      _previousProgress = _waterIntake / _waterGoal;
      _waterIntake += amount;
      _controller.reset();
      _animation = Tween<double>(
              begin: _previousProgress, end: _waterIntake / _waterGoal)
          .animate(_controller)
        ..addListener(() {
          setState(() {});
        });
      _controller.forward();
    });
  }

  void _openSettings() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SettingsPage(goal: _waterGoal, buttonValue: _buttonValue)),
    );
    if (result != null) {
      setState(() {
        _waterGoal = result['goal'];
        _buttonValue = result['buttonValue'];
        _waterIntake = 0;
        _controller.reset();
        _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.blueAccent),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: WaterPainter(_animation.value),
                );
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: kToolbarHeight),
                const Text(
                  'Ingestão Diária de Água',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${_waterIntake.toInt()} / ${_waterGoal.toInt()} ml',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            right: 50,
            child: FloatingActionButton(
              onPressed: () => _addWater(_buttonValue),
              backgroundColor: Colors.white,
              shape: const CircleBorder(
                  side: BorderSide(color: Colors.blueAccent, width: 2)),
              elevation: 6.0,
              highlightElevation: 12.0,
              splashColor: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: Colors.blueAccent, size: 30),
                    Text('${_buttonValue.toInt()} ml',
                        style: const TextStyle(
                            color: Colors.blueAccent, fontSize: 14)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
