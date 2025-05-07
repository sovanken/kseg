import 'unicode_ranges.dart';

/// Enum representing different script types that can be detected
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

/// Result of script detection for a segment of text
class ScriptDetectionResult {
  /// The script type detected
  final ScriptType scriptType;

  /// The text segment
  final String text;

  /// Start index in the original string
  final int startIndex;

  /// End index in the original string
  final int endIndex;

  /// Creates a new ScriptDetectionResult
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

/// A detector for identifying scripts in text
class ScriptDetector {
  /// Detects the script type of a single character
  ///
  /// Returns the [ScriptType] of the character based on Unicode ranges
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

  /// Analyzes the overall script composition of a string
  ///
  /// Returns a [ScriptType] indicating the dominant script or [ScriptType.mixed]
  /// if no script is clearly dominant
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

  /// Segments text into parts based on script changes
  ///
  /// Returns a list of [ScriptDetectionResult] objects, each containing a text segment
  /// and its detected script type
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

  /// Identifies the script boundaries in a string without extracting the segments
  ///
  /// Returns a list of pairs where each pair contains the start and end indices of a segment
  /// with the same script
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

  /// Checks if a string contains Khmer script
  static bool containsKhmer(String text) {
    for (int i = 0; i < text.length; i++) {
      if (detectCharScript(text[i]) == ScriptType.khmer) {
        return true;
      }
    }
    return false;
  }

  /// Checks if a string contains Latin script
  static bool containsLatin(String text) {
    for (int i = 0; i < text.length; i++) {
      if (detectCharScript(text[i]) == ScriptType.latin) {
        return true;
      }
    }
    return false;
  }

  /// Checks if a string contains mixed scripts (both Khmer and Latin)
  static bool containsMixedScripts(String text) {
    return containsKhmer(text) && containsLatin(text);
  }
}
