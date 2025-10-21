import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica006/features/timer/application/timer_bloc.dart';
import 'package:practica006/features/timer/presentation/widgets/timer_text.dart';

class TimerProgressIndicator extends StatelessWidget {
  const TimerProgressIndicator({super.key, this.size = 300.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        final isTicking = state is TimerTicking;
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                value: isTicking ? state.duration / state.initialDuration : 0.0,
                strokeWidth: 15,
                backgroundColor: Colors.grey.shade300,
              ),
            ),
            const TimerText(),
          ],
        );
      },
    );
  }
}
