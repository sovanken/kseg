import '../detector/script_detector.dart';
import 'segment_model.dart';

/// A class to segment text into different scripts.
///
/// Provides methods to divide text into segments based on script type,
/// filter segments, and analyze text composition.
class TextSegmenter {
  /// Segments a string into different script segments.
  ///
  /// Divides the input text into segments where each segment contains
  /// characters from the same script (Khmer, Latin, or other).
  ///
  /// Example:
  /// ```dart
  /// SegmentedString result = TextSegmenter.segment('Hello ក');
  /// ```
  ///
  /// [text] is the string to segment.
  ///
  /// Returns a [SegmentedString] containing the segmented text.
  static SegmentedString segment(String text) {
    if (text.isEmpty) {
      return SegmentedString(originalText: '', segments: []);
    }

    // Use the ScriptDetector to get detection results
    final detectionResults = ScriptDetector.segmentByScript(text);

    // Convert detection results to a SegmentedString
    return SegmentedString.fromDetectionResults(text, detectionResults);
  }

  /// Segments a string and filters to only include specific script types.
  ///
  /// Divides the input text into segments and keeps only those segments
  /// with script types that match the provided list of included types.
  ///
  /// Example:
  /// ```dart
  /// SegmentedString khmerOnly = TextSegmenter.segmentAndFilter(
  ///   'Hello ក',
  ///   [ScriptType.khmer],
  /// );
  /// ```
  ///
  /// [text] is the string to segment.
  /// [includedTypes] is a list of script types to include in the result.
  ///
  /// Returns a [SegmentedString] containing only segments of the specified types.
  static SegmentedString segmentAndFilter(
    String text,
    List<ScriptType> includedTypes,
  ) {
    final segmented = segment(text);

    // Filter out segments that don't match the included types
    final filteredSegments =
        segmented.segments
            .where((segment) => includedTypes.contains(segment.scriptType))
            .toList();

    // Join the filtered segments to create a new original text
    final filteredText = filteredSegments.map((s) => s.text).join('');

    return SegmentedString(
      originalText: filteredText,
      segments: filteredSegments,
    );
  }

  /// Extracts only Khmer text from a string.
  ///
  /// Segments the input text and keeps only the Khmer segments.
  ///
  /// Example:
  /// ```dart
  /// SegmentedString khmerOnly = TextSegmenter.extractKhmer('Hello ក');
  /// // Contains only 'ក'
  /// ```
  ///
  /// [text] is the string to process.
  ///
  /// Returns a [SegmentedString] containing only Khmer segments.
  static SegmentedString extractKhmer(String text) {
    return segmentAndFilter(text, [ScriptType.khmer]);
  }

  /// Extracts only Latin text from a string.
  ///
  /// Segments the input text and keeps only the Latin segments.
  ///
  /// Example:
  /// ```dart
  /// SegmentedString latinOnly = TextSegmenter.extractLatin('Hello ក');
  /// // Contains only 'Hello '
  /// ```
  ///
  /// [text] is the string to process.
  ///
  /// Returns a [SegmentedString] containing only Latin segments.
  static SegmentedString extractLatin(String text) {
    return segmentAndFilter(text, [ScriptType.latin]);
  }

  /// Segments a list of strings.
  ///
  /// Applies the [segment] method to each string in the input list.
  ///
  /// Example:
  /// ```dart
  /// List<SegmentedString> results = TextSegmenter.segmentAll(['Hello', 'ក', 'Hello ក']);
  /// ```
  ///
  /// [texts] is the list of strings to segment.
  ///
  /// Returns a list of [SegmentedString] objects.
  static List<SegmentedString> segmentAll(List<String> texts) {
    return texts.map((text) => segment(text)).toList();
  }

  /// Checks if a string contains mixed scripts.
  ///
  /// Determines whether the input text contains both Khmer and Latin scripts.
  ///
  /// Example:
  /// ```dart
  /// bool isMixed = TextSegmenter.hasMixedScripts('Hello ក'); // Returns true
  /// ```
  ///
  /// [text] is the string to check.
  ///
  /// Returns true if the string contains both Khmer and Latin scripts.
  static bool hasMixedScripts(String text) {
    return ScriptDetector.containsMixedScripts(text);
  }

  /// Segments a string and returns the segments as a list of strings.
  ///
  /// This is a simplified version that returns only the text segments
  /// without script type information.
  ///
  /// Example:
  /// ```dart
  /// List<String> segments = TextSegmenter.segmentToStringList('Hello ក');
  /// // Returns ['Hello ', 'ក']
  /// ```
  ///
  /// [text] is the string to segment.
  ///
  /// Returns a list of string segments.
  static List<String> segmentToStringList(String text) {
    final segmented = segment(text);
    return segmented.segments.map((segment) => segment.text).toList();
  }

  /// Segments a string and returns a map with script types as keys and their segments as values.
  ///
  /// Organizes the segments by script type for easy access.
  ///
  /// Example:
  /// ```dart
  /// Map<ScriptType, List<TextSegment>> segmentsByType = TextSegmenter.segmentByScriptType('Hello ក');
  /// // Returns a map with ScriptType.latin -> ['Hello '] and ScriptType.khmer -> ['ក']
  /// ```
  ///
  /// [text] is the string to segment.
  ///
  /// Returns a map with script types as keys and lists of segments as values.
  static Map<ScriptType, List<TextSegment>> segmentByScriptType(String text) {
    final segmented = segment(text);
    final Map<ScriptType, List<TextSegment>> result = {};

    // Initialize the map with empty lists for each script type
    for (var scriptType in ScriptType.values) {
      if (scriptType != ScriptType.mixed) {
        // Exclude "mixed" as it's not a real script type
        result[scriptType] = [];
      }
    }

    // Add each segment to the appropriate list
    for (var segment in segmented.segments) {
      result[segment.scriptType]!.add(segment);
    }

    return result;
  }

  /// Returns the number of script changes in a string.
  ///
  /// Counts how many times the script type changes in the input text.
  /// This can be useful for determining how "mixed" a string is.
  ///
  /// Example:
  /// ```dart
  /// int changes = TextSegmenter.countScriptChanges('Hello ក');
  /// // Returns 1 (one change from Latin to Khmer)
  /// ```
  ///
  /// [text] is the string to analyze.
  ///
  /// Returns the number of script changes.
  static int countScriptChanges(String text) {
    final segmented = segment(text);
    // Number of changes = number of segments - 1 (if there are any segments)
    return segmented.segmentCount > 0 ? segmented.segmentCount - 1 : 0;
  }
}
