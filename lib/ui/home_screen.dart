import 'package:flutter/material.dart';
import 'package:water_app/ui/settings_page.dart';
import 'package:water_app/ui/water_painter_widget.dart';

/// TODO: arrumar botao continuar da settings page para nao resetar quando o intake de agua estiver em curso

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
  bool _isGoalReached = false;

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
      if (_waterIntake >= _waterGoal) {
        _isGoalReached = true;
      }
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

  void _reset() {
    setState(() {
      _waterIntake = 0;
      _isGoalReached = false;
      _controller.reset();
      _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
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
        _isGoalReached = false;
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
          Column(
            children: [
              AppBar(
                toolbarHeight: 80,
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.menu_sharp,
                      color: _isGoalReached ? Colors.white : Colors.blueAccent,
                      size: 40,
                    ),
                    onPressed: _openSettings,
                  ),
                ],
              ),
            ],
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                left: 20,
                bottom: 70 +
                    (_animation.value *
                        (MediaQuery.of(context).size.height - 100)),
                child: Text(
                  '${_waterIntake.toInt()} ml / ${_waterGoal.toInt()} ml',
                  style: TextStyle(
                    fontSize: 20,
                    color: _isGoalReached ? Colors.white : Colors.blueAccent,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 45,
            right: 35,
            child: SizedBox(
              width: 120.0,
              height: 120.0,
              child: FloatingActionButton(
                splashColor: Colors.transparent,
                onPressed:
                    _isGoalReached ? _reset : () => _addWater(_buttonValue),
                backgroundColor: Colors.white,
                shape: const CircleBorder(
                    side: BorderSide(color: Colors.white, width: 2)),
                elevation: 6.0,
                highlightElevation: 12.0,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isGoalReached ? Icons.refresh_outlined : Icons.add,
                        color: Colors.blueAccent,
                        size: 35,
                      ),
                      const SizedBox(height: 6),
                      Text(
                          _isGoalReached
                              ? 'Reiniciar'
                              : '${_buttonValue.toInt()} ml',
                          style: const TextStyle(
                              color: Colors.blueAccent, fontSize: 18)),
                    ],
                  ),
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
