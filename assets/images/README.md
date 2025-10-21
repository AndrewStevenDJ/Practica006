# Imágenes para Icono y Splash Screen

## 📱 Archivos necesarios:

### 1. **icon.png** - Icono de la aplicación
- **Tamaño recomendado:** 1024x1024 px (mínimo 512x512 px)
- **Formato:** PNG con fondo transparente
- **Descripción:** Este será el icono que aparecerá en la pantalla de inicio del teléfono

### 2. **splash.png** - Imagen de splash screen
- **Tamaño recomendado:** 1080x1920 px o superior
- **Formato:** PNG (puede tener fondo transparente)
- **Descripción:** Imagen que se mostrará al abrir la aplicación

## 🎨 Sugerencias de diseño:

### Para el icono (icon.png):
- Un reloj o cronómetro simple
- Fondo transparente
- Diseño minimalista
- Colores: Azul (#2196F3) o contrastantes

### Para el splash (splash.png):
- Logo o icono del timer centrado
- Fondo del color de tu app (#2196F3)
- Puede incluir el nombre de la app

## 🔧 Opciones para crear las imágenes:

### Opción 1: Usar herramientas online
1. **Canva** (https://www.canva.com/)
   - Templates de app icons
   - Fácil de usar
   - Gratuito

2. **Figma** (https://www.figma.com/)
   - Más profesional
   - Control total del diseño

3. **Adobe Express** (https://www.adobe.com/express/)
   - Templates de iconos
   - Gratuito

### Opción 2: Usar iconos de Material Design
1. Ir a https://fonts.google.com/icons
2. Buscar "timer" o "schedule"
3. Descargar el icono
4. Redimensionar a 1024x1024

### Opción 3: Generador de iconos IA
1. **DALL-E** o **Midjourney**
2. Prompt: "minimalist timer app icon, blue and white, flat design, transparent background"

## 📥 Una vez que tengas las imágenes:

1. Guarda `icon.png` en esta carpeta (`assets/images/`)
2. Guarda `splash.png` en esta carpeta (`assets/images/`)
3. Ejecuta en la terminal:
   ```bash
   flutter pub get
   dart run flutter_launcher_icons
   dart run flutter_native_splash:create
   ```

## 🎨 Colores actuales configurados:
- **Color principal:** #2196F3 (Azul Material)
- Puedes cambiar estos colores en `pubspec.yaml` en las secciones:
  - `flutter_launcher_icons`
  - `flutter_native_splash`

## ⚠️ Importante:
- Los nombres de archivo deben ser exactamente: `icon.png` y `splash.png`
- Las imágenes deben estar en esta carpeta: `assets/images/`
- Después de agregar las imágenes, ejecuta los comandos mencionados arriba
