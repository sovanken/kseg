import '../detector/script_detector.dart';

/// A segment represents a piece of text with a consistent script type
class TextSegment {
  /// The text content of this segment
  final String text;

  /// The script type of this segment
  final ScriptType scriptType;

  /// Starting index in the original text
  final int startIndex;

  /// Ending index in the original text (inclusive)
  final int endIndex;

  /// Creates a new TextSegment
  TextSegment({
    required this.text,
    required this.scriptType,
    required this.startIndex,
    required this.endIndex,
  });

  /// Creates a TextSegment from a ScriptDetectionResult
  factory TextSegment.fromDetectionResult(ScriptDetectionResult result) {
    return TextSegment(
      text: result.text,
      scriptType: result.scriptType,
      startIndex: result.startIndex,
      endIndex: result.endIndex,
    );
  }

  @override
  String toString() =>
      'TextSegment{text: "$text", scriptType: $scriptType, '
      'range: $startIndex-$endIndex}';

  /// Returns the length of this segment
  int get length => text.length;

  /// Checks if this segment is Khmer text
  bool get isKhmer => scriptType == ScriptType.khmer;

  /// Checks if this segment is Latin text
  bool get isLatin => scriptType == ScriptType.latin;

  /// Checks if this segment is other text
  bool get isOther => scriptType == ScriptType.other;
}

/// A segmented string that contains multiple segments of different script types
class SegmentedString {
  /// The original, unsegmented text
  final String originalText;

  /// List of segments that make up the original text
  final List<TextSegment> segments;

  /// Creates a new SegmentedString
  SegmentedString({required this.originalText, required this.segments});

  /// Creates a SegmentedString from a list of ScriptDetectionResults
  factory SegmentedString.fromDetectionResults(
    String originalText,
    List<ScriptDetectionResult> results,
  ) {
    return SegmentedString(
      originalText: originalText,
      segments:
          results
              .map((result) => TextSegment.fromDetectionResult(result))
              .toList(),
    );
  }

  @override
  String toString() =>
      'SegmentedString{originalText: "$originalText", '
      'segments: $segments}';

  /// Returns the number of segments in this string
  int get segmentCount => segments.length;

  /// Returns the total length of the string
  int get length => originalText.length;

  /// Returns true if the string contains any Khmer segments
  bool get containsKhmer =>
      segments.any((segment) => segment.scriptType == ScriptType.khmer);

  /// Returns true if the string contains any Latin segments
  bool get containsLatin =>
      segments.any((segment) => segment.scriptType == ScriptType.latin);

  /// Returns true if the string contains mixed scripts
  bool get isMixed => containsKhmer && containsLatin;

  /// Returns all Khmer segments
  List<TextSegment> get khmerSegments =>
      segments.where((segment) => segment.isKhmer).toList();

  /// Returns all Latin segments
  List<TextSegment> get latinSegments =>
      segments.where((segment) => segment.isLatin).toList();

  /// Returns all segments of other script types
  List<TextSegment> get otherSegments =>
      segments.where((segment) => segment.isOther).toList();

  /// Returns the segment at the given index
  TextSegment operator [](int index) => segments[index];

  /// Applies a function to each segment and returns a new SegmentedString
  SegmentedString map(String Function(TextSegment segment) transform) {
    // Create new segments by applying the transform function
    final newSegments =
        segments.map((segment) {
          final newText = transform(segment);
          return TextSegment(
            text: newText,
            scriptType: segment.scriptType,
            startIndex: segment.startIndex,
            endIndex: segment.endIndex,
          );
        }).toList();

    // Join the transformed segments to create the new original text
    final newOriginalText = newSegments.map((s) => s.text).join('');

    return SegmentedString(
      originalText: newOriginalText,
      segments: newSegments,
    );
  }

  /// Iterates through each segment
  void forEach(void Function(TextSegment segment) action) {
    segments.forEach(action);
  }
}
