import 'package:audioplayers/audioplayers.dart';

/// Service class to handle audio playback in the timer application
class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  /// Play a sound effect
  Future<void> playSoundEffect(String soundPath) async {
    try {
      await _audioPlayer.play(AssetSource(soundPath));
    } catch (e) {
      // Handle error playing sound
    }
  }

  /// Play timer tick sound
  Future<void> playTickSound() async {
    await playSoundEffect('audio/tick.mp3');
  }

  /// Play timer complete sound
  Future<void> playCompleteSound() async {
    await playSoundEffect('audio/complete.mp3');
  }

  /// Play alarm sound
  Future<void> playAlarmSound() async {
    await playSoundEffect('audio/alarm.mp3');
  }

  /// Play button click sound
  Future<void> playClickSound() async {
    await playSoundEffect('audio/click.mp3');
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  /// Stop current audio
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  /// Pause current audio
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  /// Resume audio
  Future<void> resume() async {
    await _audioPlayer.resume();
  }

  /// Dispose the audio player
  void dispose() {
    _audioPlayer.dispose();
  }
}
