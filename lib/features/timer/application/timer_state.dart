part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  const TimerState(this.duration, this.initialDuration, this.laps);
  final int duration;
  final int initialDuration;
  final List<int> laps;

  @override
  List<Object> get props => [duration, initialDuration, laps];
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration) : super(duration, duration, const []);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerTicking extends TimerState {
  const TimerTicking(super.duration, super.initialDuration, super.laps);

  @override
  String toString() => 'TimerTicking { duration: $duration, initialDuration: $initialDuration, laps: $laps }';
}

class TimerFinished extends TimerState {
  const TimerFinished(List<int> laps) : super(0, 0, laps);
}
