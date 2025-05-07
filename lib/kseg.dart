/// Khmer Script Segmenter (kseg)
///
/// A Flutter package for detecting and styling different scripts within a string,
/// with a focus on Khmer and Latin scripts.
///
/// This package enables developers to automatically identify Khmer and Latin
/// script segments within text and apply different styles to each segment,
/// ensuring proper typography and readability for mixed-script text.
///
/// Example usage:
/// ```dart
/// Kseg(
///   text: "តេស្តTest អក្សរខ្មែរ Latin script",
///   khFont: "Battambang",
///   latinFont: "Roboto",
///   khFontSize: 18,
///   latinFontSize: 16,
/// )
/// ```
library kseg;

// Export detector components
export 'src/detector/script_detector.dart';
export 'src/detector/unicode_ranges.dart';

// Export segmenter components
export 'src/segmenter/segment_model.dart';
export 'src/segmenter/text_segmenter.dart';

// Export styling components
export 'src/styling/text_styler.dart';

// Export main widget
export 'src/widget/kseg_widget.dart';
