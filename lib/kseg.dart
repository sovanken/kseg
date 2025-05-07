/// Khmer Script Segmenter (kseg)
///
/// A Flutter package that detects and segments different scripts within a string,
/// with a focus on Khmer and Latin scripts.
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
