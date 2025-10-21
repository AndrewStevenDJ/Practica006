import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica006/features/timer/application/timer_bloc.dart';
import 'package:practica006/features/timer/domain/repositories/timer_repository_impl.dart';
import 'package:practica006/features/timer/domain/entities/ticker.dart';
import 'package:practica006/features/timer/presentation/widgets/timer_view.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(timerRepository: TimerRepositoryImpl(Ticker())),
      child: BlocListener<TimerBloc, TimerState>(
        listener: (context, state) {
          if (state is TimerFinished) {
            final player = AudioPlayer();
            player.play(AssetSource('audio/alarm.mp3'));
          }
        },
        child: const TimerView(),
      ),
    );
  }
}