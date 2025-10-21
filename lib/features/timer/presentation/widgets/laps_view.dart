import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica006/features/timer/application/timer_bloc.dart';

class LapsView extends StatelessWidget {
  const LapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TimerBloc, TimerState, List<int>>(
      selector: (state) => state.laps,
      builder: (context, laps) {
        if (laps.isEmpty) {
          return const SizedBox.shrink();
        }
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          child: ListView.builder(
            shrinkWrap: false,
            itemCount: laps.length,
            itemBuilder: (context, index) {
              final duration = laps[index];
              final minutesStr =
                  ((duration / 60) % 60).floor().toString().padLeft(2, '0');
              final secondsStr =
                  (duration % 60).floor().toString().padLeft(2, '0');
              return ListTile(
                leading: Text('${index + 1}'),
                title: Text('$minutesStr:$secondsStr'),
              );
            },
          ),
        );
      },
    );
  }
}
