part of 'timer_bloc.dart';

sealed class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration, required this.initialDuration, required this.laps});
  final int duration;
  final int initialDuration;
  final List<int> laps;

  @override
  List<Object> get props => [duration, initialDuration, laps];
}

class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class TimerLapPressed extends TimerEvent {
  const TimerLapPressed();
}
