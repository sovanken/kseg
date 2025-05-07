import '../detector/script_detector.dart';

/// A segment represents a piece of text with a consistent script type.
///
/// This class encapsulates a segment of text that contains characters from
/// the same script (Khmer, Latin, or other), along with metadata about the
/// segment's position in the original text.
class TextSegment {
  /// The text content of this segment
  final String text;

  /// The script type of this segment
  final ScriptType scriptType;

  /// Starting index in the original text
  final int startIndex;

  /// Ending index in the original text (inclusive)
  final int endIndex;

  /// Creates a new TextSegment.
  ///
  /// [text] is the text content of this segment.
  /// [scriptType] is the script type of this segment (Khmer, Latin, or other).
  /// [startIndex] is the position where this segment starts in the original string.
  /// [endIndex] is the position where this segment ends in the original string.
  TextSegment({
    required this.text,
    required this.scriptType,
    required this.startIndex,
    required this.endIndex,
  });

  /// Creates a TextSegment from a ScriptDetectionResult.
  ///
  /// This factory constructor converts a [ScriptDetectionResult] from the
  /// detector module into a [TextSegment].
  ///
  /// [result] is the ScriptDetectionResult to convert.
  ///
  /// Returns a new TextSegment with the same properties as the ScriptDetectionResult.
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

  /// Returns the length of this segment.
  ///
  /// Provides the number of characters in this segment.
  int get length => text.length;

  /// Checks if this segment is Khmer text.
  ///
  /// Returns true if this segment contains Khmer script.
  bool get isKhmer => scriptType == ScriptType.khmer;

  /// Checks if this segment is Latin text.
  ///
  /// Returns true if this segment contains Latin script.
  bool get isLatin => scriptType == ScriptType.latin;

  /// Checks if this segment is other text.
  ///
  /// Returns true if this segment contains a script other than Khmer or Latin.
  bool get isOther => scriptType == ScriptType.other;
}

/// A segmented string that contains multiple segments of different script types.
///
/// This class represents the result of segmenting a string by script type,
/// providing convenient access to the segments and metadata about the
/// segmentation.
class SegmentedString {
  /// The original, unsegmented text
  final String originalText;

  /// List of segments that make up the original text
  final List<TextSegment> segments;

  /// Creates a new SegmentedString.
  ///
  /// [originalText] is the original, unsegmented text.
  /// [segments] is the list of segments that make up the original text.
  SegmentedString({required this.originalText, required this.segments});

  /// Creates a SegmentedString from a list of ScriptDetectionResults.
  ///
  /// This factory constructor converts a list of [ScriptDetectionResult] objects
  /// from the detector module into a [SegmentedString].
  ///
  /// [originalText] is the original, unsegmented text.
  /// [results] is the list of ScriptDetectionResults to convert.
  ///
  /// Returns a new SegmentedString containing TextSegments created from the
  /// ScriptDetectionResults.
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

  /// Returns the number of segments in this string.
  ///
  /// Provides the count of distinct script segments in the original text.
  int get segmentCount => segments.length;

  /// Returns the total length of the string.
  ///
  /// Provides the number of characters in the original text.
  int get length => originalText.length;

  /// Returns true if the string contains any Khmer segments.
  ///
  /// Checks if any segment in this string contains Khmer script.
  bool get containsKhmer =>
      segments.any((segment) => segment.scriptType == ScriptType.khmer);

  /// Returns true if the string contains any Latin segments.
  ///
  /// Checks if any segment in this string contains Latin script.
  bool get containsLatin =>
      segments.any((segment) => segment.scriptType == ScriptType.latin);

  /// Returns true if the string contains mixed scripts.
  ///
  /// Checks if this string contains both Khmer and Latin scripts.
  bool get isMixed => containsKhmer && containsLatin;

  /// Returns all Khmer segments.
  ///
  /// Provides a list of all segments that contain Khmer script.
  List<TextSegment> get khmerSegments =>
      segments.where((segment) => segment.isKhmer).toList();

  /// Returns all Latin segments.
  ///
  /// Provides a list of all segments that contain Latin script.
  List<TextSegment> get latinSegments =>
      segments.where((segment) => segment.isLatin).toList();

  /// Returns all segments of other script types.
  ///
  /// Provides a list of all segments that contain scripts other than
  /// Khmer or Latin.
  List<TextSegment> get otherSegments =>
      segments.where((segment) => segment.isOther).toList();

  /// Returns the segment at the given index.
  ///
  /// Allows accessing segments using the array indexing operator.
  ///
  /// [index] is the index of the segment to retrieve.
  ///
  /// Returns the TextSegment at the specified index.
  TextSegment operator [](int index) => segments[index];

  /// Applies a function to each segment and returns a new SegmentedString.
  ///
  /// This method enables transforming the text content of each segment
  /// while preserving script information and segment boundaries.
  ///
  /// [transform] is a function that takes a TextSegment and returns a new
  /// string to replace the text content of that segment.
  ///
  /// Returns a new SegmentedString with the transformed segments.
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

  /// Iterates through each segment.
  ///
  /// Executes a function for each segment in this SegmentedString.
  ///
  /// [action] is a function that takes a TextSegment and performs some action.
  void forEach(void Function(TextSegment segment) action) {
    segments.forEach(action);
  }
}
