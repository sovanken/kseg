# kseg

<p align="center">
  <img src="https://via.placeholder.com/150x150.png?text=kseg" alt="kseg logo" width="150" height="150"/>
</p>

<p align="center">
  <a href="https://pub.dev/packages/kseg"><img src="https://img.shields.io/pub/v/kseg.svg?style=for-the-badge" alt="Pub.dev Badge"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg?style=for-the-badge" alt="License: MIT"></a>
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter&style=for-the-badge" alt="Platform"></a>
  <a href="https://github.com/sovanken/kseg"><img src="https://img.shields.io/github/stars/sovanken/kseg.svg?style=for-the-badge" alt="GitHub stars"></a>
</p>

<p align="center">
  <b>Khmer Script Segmenter</b> - A powerful Flutter package for detecting and styling mixed script text
</p>

<p align="center">
  <a href="#key-features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#usage">Usage</a> •
  <a href="#examples">Examples</a> •
  <a href="#api-reference">API</a> •
  <a href="#demo">Demo</a> •
  <a href="#contributing">Contributing</a>
</p>

---

## 📋 Overview

**kseg** is a specialized Flutter package that elegantly solves the challenge of displaying mixed Khmer and Latin script text with proper styling. It automatically detects and segments different scripts within a string, allowing you to apply distinct styles (font family, size, weight, color, etc.) to each script type.

<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="https://via.placeholder.com/320x180.png?text=Before+kseg" width="320"/>
        <br/>
        <em>Without kseg</em>
      </td>
      <td align="center">
        <img src="https://via.placeholder.com/320x180.png?text=With+kseg" width="320"/>
        <br/>
        <em>With kseg</em>
      </td>
    </tr>
  </table>
</div>

## ✨ Key Features

- **🔍 Smart Script Detection**: Precisely identifies Khmer and Latin scripts based on Unicode character ranges
- **✂️ Automatic Segmentation**: Seamlessly divides text into segments by script type
- **🎨 Independent Styling**: Apply different styling to each script segment (font, size, weight, color, etc.)
- **📱 Flutter Integration**: Works perfectly with Flutter's Text and RichText widgets
- **📦 Lightweight**: No bundled fonts, integrates with Google Fonts to keep package size small
- **🧩 Simple API**: Clean, widget-based API that follows Flutter conventions
- **📄 Comprehensive Documentation**: Detailed documentation and examples for easy implementation

## 📥 Installation

Add `kseg` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  kseg: ^1.0.0
  google_fonts:  # Required for Google Fonts support
```

Then run:

```bash
flutter pub get
```

## 🚀 Usage

### Basic Usage

Simply wrap your text in a `Kseg` widget and specify the fonts and styles for each script:

```dart
import 'package:flutter/material.dart';
import 'package:kseg/kseg.dart';

Kseg(
  text: "តេស្តTest អក្សរខ្មែរ Latin script",
  khFont: "Battambang",
  latinFont: "Roboto",
  khFontSize: 18,
  latinFontSize: 16,
)
```

### Google Fonts Integration

By default, `kseg` uses Google Fonts for the specified font names:

```dart
Kseg(
  text: "តេស្តTest អក្សរខ្មែរ Latin script",
  khFont: "Battambang",    // Uses Google Fonts
  latinFont: "Lato",       // Uses Google Fonts
  khFontSize: 20,
  latinFontSize: 16,
)
```

### Using System Fonts

If you want to use system fonts instead, set the appropriate flags:

```dart
Kseg(
  text: "តេស្តTest អក្សរខ្មែរ Latin script",
  khFont: "Battambang",
  latinFont: "Roboto",
  khUseGoogleFont: false,    // Use system font
  latinUseGoogleFont: false, // Use system font
)
```

## 📝 Examples

### Different Font Sizes

```dart
Kseg(
  text: "តេស្តTest អក្សរខ្មែរ Latin script",
  khFont: "Battambang",
  latinFont: "Roboto",
  khFontSize: 24,             // Larger Khmer text
  latinFontSize: 16,          // Smaller Latin text
)
```

### Color and Weight Styling

```dart
Kseg(
  text: "តេស្តTest អក្សរខ្មែរ Latin script",
  khFont: "Moul",
  latinFont: "Roboto",
  khColor: Colors.blue,                // Blue Khmer text
  latinColor: Colors.deepOrange,       // Orange Latin text
  khFontWeight: FontWeight.bold,       // Bold Khmer text
  latinFontWeight: FontWeight.normal,  // Normal Latin text
)
```

### Advanced Styling

```dart
Kseg(
  text: "តេស្តTest អក្សរខ្មែរ Latin script",
  khFont: "Battambang",
  latinFont: "Roboto Mono",
  khFontSize: 20,
  latinFontSize: 16,
  khColor: Colors.deepPurple,
  latinColor: Colors.teal,
  khLetterSpacing: 1.2,               // Wider letter spacing for Khmer
  latinLetterSpacing: 0.5,            // Normal letter spacing for Latin
  khHeight: 1.5,                      // Taller line height for Khmer
  latinHeight: 1.3,                   // Normal line height for Latin
  khBackgroundColor: Colors.yellow.shade100,  // Light yellow background for Khmer
  textAlign: TextAlign.center,        // Center align all text
  maxLines: 2,                        // Limit to 2 lines
  overflow: TextOverflow.ellipsis,    // Show ellipsis when text overflows
)
```

### Text Decoration

```dart
Kseg(
  text: "តេស្តTest អក្សរខ្មែរ Latin script",
  khFont: "Battambang",
  latinFont: "Lato",
  khDecoration: TextDecoration.underline,       // Underline Khmer text
  khDecorationColor: Colors.red,                // Red underline
  latinDecoration: TextDecoration.lineThrough,  // Strikethrough Latin text
  latinDecorationStyle: TextDecorationStyle.wavy, // Wavy line style
)
```

## 📚 API Reference

### Kseg Widget

The main widget for displaying mixed script text with different styles.

```dart
Kseg({
  // Required
  required String text,
  
  // Khmer script styling
  String? khFont,                        // Font name for Khmer text
  double? khFontSize,                    // Font size for Khmer text
  FontWeight? khFontWeight,              // Font weight for Khmer text
  FontStyle? khFontStyle,                // Font style for Khmer text
  Color? khColor,                        // Text color for Khmer text
  Color? khBackgroundColor,              // Background color for Khmer text
  double? khLetterSpacing,               // Letter spacing for Khmer text
  double? khWordSpacing,                 // Word spacing for Khmer text
  double? khHeight,                      // Line height for Khmer text
  TextBaseline? khTextBaseline,          // Text baseline for Khmer text
  List<Shadow>? khShadows,               // Text shadows for Khmer text
  TextDecoration? khDecoration,          // Text decoration for Khmer text
  Color? khDecorationColor,              // Text decoration color for Khmer text
  TextDecorationStyle? khDecorationStyle, // Text decoration style for Khmer text
  double? khDecorationThickness,         // Text decoration thickness for Khmer text
  bool khUseGoogleFont = true,           // Whether to use Google Fonts for Khmer
  
  // Latin script styling
  String? latinFont,                      // Font name for Latin text
  double? latinFontSize,                  // Font size for Latin text
  FontWeight? latinFontWeight,            // Font weight for Latin text
  FontStyle? latinFontStyle,              // Font style for Latin text
  Color? latinColor,                      // Text color for Latin text
  Color? latinBackgroundColor,            // Background color for Latin text
  double? latinLetterSpacing,             // Letter spacing for Latin text
  double? latinWordSpacing,               // Word spacing for Latin text
  double? latinHeight,                    // Line height for Latin text
  TextBaseline? latinTextBaseline,        // Text baseline for Latin text
  List<Shadow>? latinShadows,             // Text shadows for Latin text
  TextDecoration? latinDecoration,        // Text decoration for Latin text
  Color? latinDecorationColor,            // Text decoration color for Latin text
  TextDecorationStyle? latinDecorationStyle, // Text decoration style for Latin text
  double? latinDecorationThickness,       // Text decoration thickness for Latin text
  bool latinUseGoogleFont = true,         // Whether to use Google Fonts for Latin
  
  // General text properties
  TextAlign? textAlign,                   // Text alignment
  TextDirection? textDirection,           // Text direction
  Locale? locale,                         // Locale
  bool? softWrap,                         // Whether text should soft wrap
  TextOverflow? overflow,                 // Overflow behavior
  int? maxLines,                          // Maximum number of lines
  TextWidthBasis? textWidthBasis,         // Text width basis
  TextHeightBehavior? textHeightBehavior, // Text height behavior
})
```

### Utility Classes

The package also provides these utility classes for advanced usage:

#### ScriptDetector

```dart
// Detects the script type of a character
static ScriptType detectCharScript(String char)

// Analyzes the overall script composition of a string
static ScriptType analyzeString(String text)

// Segments text into parts based on script changes
static List<ScriptDetectionResult> segmentByScript(String text)

// Checks if a string contains Khmer script
static bool containsKhmer(String text)

// Checks if a string contains Latin script
static bool containsLatin(String text)

// Checks if a string contains mixed scripts
static bool containsMixedScripts(String text)
```

#### TextSegmenter

```dart
// Segments a string into different script segments
static SegmentedString segment(String text)

// Extracts only Khmer text from a string
static SegmentedString extractKhmer(String text)

// Extracts only Latin text from a string
static SegmentedString extractLatin(String text)
```

## 🎬 Demo

<div align="center">
  <img src="https://via.placeholder.com/640x360.png?text=kseg+Demo" width="640" alt="kseg demo"/>
</div>

Check out our [example project](https://github.com/sovanken/kseg/tree/main/example) for a complete demonstration of all features.

## 🔧 How It Works

1. **Text Analysis**: `kseg` analyzes the input text to identify Khmer and Latin characters using Unicode ranges.
2. **Segmentation**: The text is segmented into chunks of consistent script type.
3. **Styling**: Each segment is styled appropriately based on its script type.
4. **Rendering**: The styled segments are combined into a `Text.rich` widget for display.

## 📱 Platform Support

| Android | iOS | macOS | Web | Linux | Windows |
|:-------:|:---:|:-----:|:---:|:-----:|:-------:|
|    ✅    |  ✅  |   ✅   |  ✅  |   ✅   |    ✅    |

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Report Issues**: Report bugs or request features via GitHub issues
2. **Submit Pull Requests**: Improve the code or documentation
3. **Share Feedback**: Tell us how we can make `kseg` better

Please follow these steps for contributions:

```bash
# Fork the repository
git clone https://github.com/YOUR-USERNAME/kseg.git

# Create a branch for your feature
git checkout -b feature/amazing-feature

# Commit your changes
git commit -m 'Add some amazing feature'

# Push to the branch
git push origin feature/amazing-feature

# Open a Pull Request
```

## 📄 License

```
MIT License

Copyright (c) 2023 Sovanken

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 👨‍💻 Author

**Sovanken** - [GitHub](https://github.com/sovanken)

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/sovanken">Sovanken</a>
</p>