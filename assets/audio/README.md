# Audio Assets

Esta carpeta contiene los archivos de audio para el temporizador.

## Archivos necesarios:

Necesitas agregar los siguientes archivos de audio en formato MP3:

1. **tick.mp3** - Sonido de tick del temporizador (opcional, actualmente comentado)
2. **complete.mp3** - Sonido cuando el temporizador termina
3. **click.mp3** - Sonido para los botones (start, pause, reset)

## Dónde conseguir audios gratuitos:

### Sitios con audios libres de derechos:

1. **Freesound.org** (https://freesound.org/)
   - Busca: "button click", "timer complete", "tick"
   - Requiere registro gratuito

2. **Pixabay** (https://pixabay.com/sound-effects/)
   - Audios libres de derechos
   - No requiere atribución

3. **Zapsplat** (https://www.zapsplat.com/)
   - Sonidos gratis para uso personal y comercial
   - Requiere registro

4. **Mixkit** (https://mixkit.co/free-sound-effects/)
   - Audios gratuitos sin atribución

## Recomendaciones:

- **Para click.mp3**: Busca "button click" o "ui click" (corto, ~0.1-0.3s)
- **Para complete.mp3**: Busca "notification", "success", "ding" (corto, ~1-2s)
- **Para tick.mp3**: Busca "clock tick" o "metronome" (muy corto, ~0.05s)

## Cómo agregar los archivos:

1. Descarga los archivos de audio
2. Renómbralos a: `tick.mp3`, `complete.mp3`, `click.mp3`
3. Colócalos en esta carpeta: `assets/audio/`
4. El archivo `pubspec.yaml` ya está configurado para cargarlos

## Ejemplo de búsqueda:

**Freesound.org:**
- Click: https://freesound.org/search/?q=button+click
- Complete: https://freesound.org/search/?q=notification+sound
- Tick: https://freesound.org/search/?q=clock+tick

**Nota:** Asegúrate de que los archivos tengan licencia libre o Creative Commons 0 para uso sin restricciones.
