import '../detector/script_detector.dart';
import 'segment_model.dart';

/// A class to segment text into different scripts
class TextSegmenter {
  /// Segments a string into different script segments
  ///
  /// Returns a [SegmentedString] containing the segmented text
  static SegmentedString segment(String text) {
    if (text.isEmpty) {
      return SegmentedString(originalText: '', segments: []);
    }

    // Use the ScriptDetector to get detection results
    final detectionResults = ScriptDetector.segmentByScript(text);

    // Convert detection results to a SegmentedString
    return SegmentedString.fromDetectionResults(text, detectionResults);
  }

  /// Segments a string and filters to only include specific script types
  ///
  /// Returns a [SegmentedString] containing only segments of the specified types
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

  /// Extracts only Khmer text from a string
  ///
  /// Returns a [SegmentedString] containing only Khmer segments
  static SegmentedString extractKhmer(String text) {
    return segmentAndFilter(text, [ScriptType.khmer]);
  }

  /// Extracts only Latin text from a string
  ///
  /// Returns a [SegmentedString] containing only Latin segments
  static SegmentedString extractLatin(String text) {
    return segmentAndFilter(text, [ScriptType.latin]);
  }

  /// Segments a list of strings
  ///
  /// Returns a list of [SegmentedString] objects
  static List<SegmentedString> segmentAll(List<String> texts) {
    return texts.map((text) => segment(text)).toList();
  }

  /// Checks if a string contains mixed scripts
  ///
  /// Returns true if the string contains both Khmer and Latin scripts
  static bool hasMixedScripts(String text) {
    return ScriptDetector.containsMixedScripts(text);
  }

  /// Segments a string and returns the segments as a list of strings
  ///
  /// This is a simplified version that returns only the text segments
  static List<String> segmentToStringList(String text) {
    final segmented = segment(text);
    return segmented.segments.map((segment) => segment.text).toList();
  }

  /// Segments a string and returns a map with script types as keys and their segments as values
  ///
  /// This provides an easy way to access all segments of a particular script type
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

  /// Returns the number of script changes in a string
  ///
  /// This can be useful for determining how "mixed" a string is
  static int countScriptChanges(String text) {
    final segmented = segment(text);
    // Number of changes = number of segments - 1 (if there are any segments)
    return segmented.segmentCount > 0 ? segmented.segmentCount - 1 : 0;
  }
}
