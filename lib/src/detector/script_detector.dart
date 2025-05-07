import 'unicode_ranges.dart';

/// Enum representing different script types that can be detected.
///
/// Used to categorize text segments by their writing system.
enum ScriptType {
  /// Khmer script
  khmer,

  /// Latin script
  latin,

  /// Other scripts not specifically handled
  other,

  /// Mixed scripts (used for analysis results)
  mixed,
}

/// Result of script detection for a segment of text.
///
/// Contains information about a detected script segment, including the script type,
/// the text content, and the position in the original string.
class ScriptDetectionResult {
  /// The script type detected
  final ScriptType scriptType;

  /// The text segment
  final String text;

  /// Start index in the original string
  final int startIndex;

  /// End index in the original string
  final int endIndex;

  /// Creates a new ScriptDetectionResult.
  ///
  /// [scriptType] is the detected script type (Khmer, Latin, other, or mixed).
  /// [text] is the text segment content.
  /// [startIndex] is the position where this segment starts in the original string.
  /// [endIndex] is the position where this segment ends in the original string.
  ScriptDetectionResult({
    required this.scriptType,
    required this.text,
    required this.startIndex,
    required this.endIndex,
  });

  @override
  String toString() =>
      'ScriptDetectionResult{scriptType: $scriptType, '
      'text: "$text", startIndex: $startIndex, endIndex: $endIndex}';
}

/// A detector for identifying scripts in text.
///
/// Provides methods to detect script types in characters and strings,
/// segment text by script, and analyze script composition.
class ScriptDetector {
  /// Detects the script type of a single character.
  ///
  /// Examines a character and determines whether it belongs to the Khmer script,
  /// Latin script, or another script based on Unicode ranges.
  ///
  /// Example:
  /// ```dart
  /// ScriptType khmerType = ScriptDetector.detectCharScript('ក'); // Returns ScriptType.khmer
  /// ScriptType latinType = ScriptDetector.detectCharScript('A'); // Returns ScriptType.latin
  /// ```
  ///
  /// [char] is the character to analyze.
  ///
  /// Returns the [ScriptType] of the character based on Unicode ranges.
  static ScriptType detectCharScript(String char) {
    if (char.isEmpty) return ScriptType.other;

    int charCode = char.codeUnitAt(0);

    if (KhmerUnicodeRanges.isKhmerChar(charCode)) {
      return ScriptType.khmer;
    } else if (LatinUnicodeRanges.isLatinChar(charCode)) {
      return ScriptType.latin;
    } else {
      return ScriptType.other;
    }
  }

  /// Analyzes the overall script composition of a string.
  ///
  /// Examines a string and determines the dominant script type based on
  /// the frequency of character types. If no script is clearly dominant,
  /// returns [ScriptType.mixed].
  ///
  /// Example:
  /// ```dart
  /// ScriptType dominant = ScriptDetector.analyzeString('Hello ក'); // Depends on character counts
  /// ```
  ///
  /// [text] is the string to analyze.
  ///
  /// Returns a [ScriptType] indicating the dominant script or [ScriptType.mixed]
  /// if no script is clearly dominant.
  static ScriptType analyzeString(String text) {
    if (text.isEmpty) return ScriptType.other;

    int khmerCount = 0;
    int latinCount = 0;
    int otherCount = 0;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final script = detectCharScript(char);

      switch (script) {
        case ScriptType.khmer:
          khmerCount++;
          break;
        case ScriptType.latin:
          latinCount++;
          break;
        case ScriptType.other:
          otherCount++;
          break;
        default:
          otherCount++;
      }
    }

    // Get the dominant script
    if (khmerCount > latinCount && khmerCount > otherCount) {
      return ScriptType.khmer;
    } else if (latinCount > khmerCount && latinCount > otherCount) {
      return ScriptType.latin;
    } else if (otherCount > khmerCount && otherCount > latinCount) {
      return ScriptType.other;
    } else {
      // No clear dominance, consider it mixed
      return ScriptType.mixed;
    }
  }

  /// Segments text into parts based on script changes.
  ///
  /// Divides a string into segments whenever there is a change in script type,
  /// providing detailed information about each segment.
  ///
  /// Example:
  /// ```dart
  /// List<ScriptDetectionResult> segments = ScriptDetector.segmentByScript('Hello ក');
  /// // Returns two segments: one for 'Hello ' (Latin) and one for 'ក' (Khmer)
  /// ```
  ///
  /// [text] is the string to segment.
  ///
  /// Returns a list of [ScriptDetectionResult] objects, each containing a text segment
  /// and its detected script type.
  static List<ScriptDetectionResult> segmentByScript(String text) {
    if (text.isEmpty) return [];

    List<ScriptDetectionResult> segments = [];

    int startIndex = 0;
    ScriptType currentScript = detectCharScript(text[0]);

    for (int i = 1; i < text.length; i++) {
      final char = text[i];
      final charScript = detectCharScript(char);

      // If script changes, create a new segment
      if (charScript != currentScript) {
        segments.add(
          ScriptDetectionResult(
            scriptType: currentScript,
            text: text.substring(startIndex, i),
            startIndex: startIndex,
            endIndex: i - 1,
          ),
        );

        startIndex = i;
        currentScript = charScript;
      }
    }

    // Add the final segment
    segments.add(
      ScriptDetectionResult(
        scriptType: currentScript,
        text: text.substring(startIndex),
        startIndex: startIndex,
        endIndex: text.length - 1,
      ),
    );

    return segments;
  }

  /// Identifies the script boundaries in a string without extracting the segments.
  ///
  /// Similar to [segmentByScript], but returns only the boundary information
  /// rather than the actual text segments.
  ///
  /// Example:
  /// ```dart
  /// List<Map<String, dynamic>> boundaries = ScriptDetector.identifyScriptBoundaries('Hello ក');
  /// // Returns boundary information for two segments
  /// ```
  ///
  /// [text] is the string to analyze.
  ///
  /// Returns a list of maps where each map contains the start and end indices of a segment
  /// with the same script, as well as the script type.
  static List<Map<String, dynamic>> identifyScriptBoundaries(String text) {
    List<Map<String, dynamic>> boundaries = [];
    List<ScriptDetectionResult> segments = segmentByScript(text);

    for (var segment in segments) {
      boundaries.add({
        'startIndex': segment.startIndex,
        'endIndex': segment.endIndex,
        'scriptType': segment.scriptType,
      });
    }

    return boundaries;
  }

  /// Checks if a string contains Khmer script.
  ///
  /// Example:
  /// ```dart
  /// bool hasKhmer = ScriptDetector.containsKhmer('Hello ក'); // Returns true
  /// ```
  ///
  /// [text] is the string to check.
  ///
  /// Returns true if the string contains at least one Khmer character.
  static bool containsKhmer(String text) {
    for (int i = 0; i < text.length; i++) {
      if (detectCharScript(text[i]) == ScriptType.khmer) {
        return true;
      }
    }
    return false;
  }

  /// Checks if a string contains Latin script.
  ///
  /// Example:
  /// ```dart
  /// bool hasLatin = ScriptDetector.containsLatin('Hello ក'); // Returns true
  /// ```
  ///
  /// [text] is the string to check.
  ///
  /// Returns true if the string contains at least one Latin character.
  static bool containsLatin(String text) {
    for (int i = 0; i < text.length; i++) {
      if (detectCharScript(text[i]) == ScriptType.latin) {
        return true;
      }
    }
    return false;
  }

  /// Checks if a string contains mixed scripts (both Khmer and Latin).
  ///
  /// Example:
  /// ```dart
  /// bool isMixed = ScriptDetector.containsMixedScripts('Hello ក'); // Returns true
  /// ```
  ///
  /// [text] is the string to check.
  ///
  /// Returns true if the string contains both Khmer and Latin characters.
  static bool containsMixedScripts(String text) {
    return containsKhmer(text) && containsLatin(text);
  }
}
