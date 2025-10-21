import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practica006/features/timer/domain/repositories/timer_repository.dart';
import 'package:practica006/core/services/audio_service.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({
    required TimerRepository timerRepository,
    AudioService? audioService,
  })  : _timerRepository = timerRepository,
        _audioService = audioService ?? AudioService(),
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerReset>(_onReset);
    on<TimerLapPressed>(_onLapPressed);
  }

  final TimerRepository _timerRepository;
  final AudioService _audioService;
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    _audioService.dispose();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    _audioService.playClickSound(); // Play sound when timer starts
    emit(TimerTicking(event.duration, event.duration, const []));
    _tickerSubscription?.cancel();
    _tickerSubscription = _timerRepository
        .ticker()
        .listen((ticks) => add(TimerTicked(duration: event.duration - ticks, initialDuration: event.duration, laps: state.laps)));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    if (event.duration > 0) {
      // Play tick sound every second while timer is running
      _audioService.playTickSound();
      emit(TimerTicking(event.duration, event.initialDuration, event.laps));
    } else {
      // Play complete sound when timer reaches zero
      _audioService.playCompleteSound();
      emit(TimerFinished(event.laps));
    }
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerTicking) {
      _audioService.playClickSound(); // Play sound when paused
      _tickerSubscription?.pause();
      emit(TimerInitial(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _audioService.playClickSound(); // Play sound when reset
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }

  void _onLapPressed(TimerLapPressed event, Emitter<TimerState> emit) {
    if (state is TimerTicking) {
      final newLaps = [state.duration, ...state.laps];
      emit(TimerTicking(state.duration, state.initialDuration, newLaps));
    }
  }
}