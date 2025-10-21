import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica006/features/timer/application/timer_bloc.dart';

/// The TimerText class is a StatelessWidget in Dart that displays a timer in minutes and seconds
/// format with responsive font size.
class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(
      2,
      '0',
    );
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    
    // Obtener el tamaño de pantalla para ajustar el tamaño del texto
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait = screenHeight > screenWidth;
    
    // Tamaño de fuente responsivo
    final fontSize = isPortrait 
        ? screenWidth * 0.15  // En vertical, 15% del ancho
        : screenHeight * 0.15; // En horizontal, 15% de la altura
    
    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize: fontSize.clamp(40.0, 80.0), // Limitar entre 40 y 80
        fontWeight: FontWeight.bold,
      ),
    );
  }
}