import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica006/features/timer/application/timer_bloc.dart';
import 'package:practica006/features/timer/presentation/widgets/actions_buttons.dart';
import 'package:practica006/features/timer/presentation/widgets/background.dart';
import 'package:practica006/features/timer/presentation/widgets/laps_view.dart';
import 'package:practica006/features/timer/presentation/widgets/timer_progress_indicator.dart';

/// The TimerView class in Dart defines a widget for displaying a timer with associated actions in a
/// responsive layout.
class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Timer')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isPortrait = constraints.maxHeight > constraints.maxWidth;
          return Stack(
            children: [
              Positioned.fill(
                child: const Background(),
              ),
              _TimerView(
                isPortrait: isPortrait,
                maxHeight: constraints.maxHeight,
                maxWidth: constraints.maxWidth,
              ),
            ],
          );
        },
      ),
    );
  }
}

/// The _TimerView class is a StatelessWidget in Dart that displays a timer with
/// responsive layout for both portrait and landscape orientations.
class _TimerView extends StatelessWidget {
  const _TimerView({
    required this.isPortrait,
    required this.maxHeight,
    required this.maxWidth,
  });

  final bool isPortrait;
  final double maxHeight;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    // Ajustar el tamaño del indicador según la orientación
    final indicatorSize = isPortrait
        ? maxWidth * 0.7 // En vertical, 70% del ancho
        : maxHeight * 0.5; // En horizontal, 50% de la altura

    if (isPortrait) {
      // Layout vertical
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Spacer(flex: 1),
          BlocBuilder<TimerBloc, TimerState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: state is TimerInitial
                    ? () async {
                        final duration = await _showDurationInputDialog(context);
                        if (duration != null && context.mounted) {
                          context.read<TimerBloc>().add(TimerStarted(duration: duration));
                        }
                      }
                    : null,
                child: TimerProgressIndicator(size: indicatorSize),
              );
            },
          ),
          const SizedBox(height: 20),
          const ActionsButtons(),
          const SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: Container(
              constraints: BoxConstraints(maxHeight: maxHeight * 0.3),
              child: const LapsView(),
            ),
          ),
        ],
      );
    } else {
      // Layout horizontal
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Lado izquierdo: Timer y botones
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<TimerBloc, TimerState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: state is TimerInitial
                              ? () async {
                                  final duration = await _showDurationInputDialog(context);
                                  if (duration != null && context.mounted) {
                                    context.read<TimerBloc>().add(TimerStarted(duration: duration));
                                  }
                                }
                              : null,
                          child: TimerProgressIndicator(size: indicatorSize),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const ActionsButtons(),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Lado derecho: Laps
              Flexible(
                flex: 2,
                child: Container(
                  constraints: BoxConstraints(maxHeight: maxHeight - 32),
                  child: const LapsView(),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

Future<int?> _showDurationInputDialog(BuildContext context) async {
  final controller = TextEditingController();
  
  return showDialog<int?>(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) {
      final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
      
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
              constraints: const BoxConstraints(
                maxWidth: 320,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: EdgeInsets.all(isLandscape ? 14.0 : 18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: isLandscape ? 18 : 22,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Set Timer',
                          style: TextStyle(
                            fontSize: isLandscape ? 15 : 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isLandscape ? 8 : 12),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Seconds',
                      labelStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      hintText: '60',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(Icons.access_time, size: 18),
                      filled: true,
                      fillColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade800
                          : Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: isLandscape ? 8 : 10,
                      ),
                    ),
                  ),
                  SizedBox(height: isLandscape ? 8 : 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: isLandscape ? 14 : 18,
                            vertical: isLandscape ? 6 : 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isLandscape ? 18 : 22,
                            vertical: isLandscape ? 6 : 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          final value = int.tryParse(controller.text);
                          Navigator.of(context).pop(value);
                        },
                        child: const Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ),
          ),
        ),
      );
    },
  );
}