/// Unicode range definitions for script detection in the kseg package.
///
/// This file contains the character code ranges for Khmer and Latin scripts
/// used by the script detector to identify different writing systems.
/// The ranges are based on the official Unicode Standard.

/// Unicode ranges for the Khmer script.
///
/// Contains definitions for the main Khmer Unicode block (0x1780-0x17FF)
/// and Khmer Symbols block (0x19E0-0x19FF).
class KhmerUnicodeRanges {
  /// Main Khmer Unicode block (0x1780-0x17FF)
  ///
  /// This range includes Khmer consonants, vowels, and other characters
  /// used in the Khmer writing system.
  static final List<int> mainRange = [0x1780, 0x17FF];

  /// Khmer Symbols (0x19E0-0x19FF)
  ///
  /// This range includes additional symbols used in the Khmer writing system.
  static final List<int> symbolsRange = [0x19E0, 0x19FF];

  /// Returns true if the character code is in the Khmer Unicode range.
  ///
  /// Checks if the provided [charCode] falls within any of the defined
  /// Khmer Unicode ranges (main range or symbols range).
  ///
  /// Example:
  /// ```dart
  /// bool isKhmer = KhmerUnicodeRanges.isKhmerChar('ក'.codeUnitAt(0)); // Returns true
  /// ```
  ///
  /// Returns a boolean indicating whether the character is a Khmer character.
  static bool isKhmerChar(int charCode) {
    return (charCode >= mainRange[0] && charCode <= mainRange[1]) ||
        (charCode >= symbolsRange[0] && charCode <= symbolsRange[1]);
  }
}

/// Unicode ranges for Latin script.
///
/// Contains definitions for Basic Latin (ASCII), Latin-1 Supplement,
/// Latin Extended-A, and Latin Extended-B Unicode blocks.
class LatinUnicodeRanges {
  /// Basic Latin (ASCII) (0x0000-0x007F)
  ///
  /// This range includes standard ASCII characters, including English letters,
  /// numbers, and common punctuation.
  static final List<int> basicLatinRange = [0x0000, 0x007F];

  /// Latin-1 Supplement (0x0080-0x00FF)
  ///
  /// This range includes additional Latin characters with diacritical marks
  /// and special symbols commonly used in Western European languages.
  static final List<int> latin1SupplementRange = [0x0080, 0x00FF];

  /// Latin Extended-A (0x0100-0x017F)
  ///
  /// This range includes Latin characters with additional diacritical marks
  /// used in various European languages.
  static final List<int> latinExtendedARange = [0x0100, 0x017F];

  /// Latin Extended-B (0x0180-0x024F)
  ///
  /// This range includes additional Latin characters used in less common
  /// European languages and transcription systems.
  static final List<int> latinExtendedBRange = [0x0180, 0x024F];

  /// Returns true if the character code is in any Latin Unicode range.
  ///
  /// Checks if the provided [charCode] falls within any of the defined
  /// Latin Unicode ranges (Basic Latin, Latin-1 Supplement, Latin Extended-A,
  /// or Latin Extended-B).
  ///
  /// Example:
  /// ```dart
  /// bool isLatin = LatinUnicodeRanges.isLatinChar('A'.codeUnitAt(0)); // Returns true
  /// ```
  ///
  /// Returns a boolean indicating whether the character is a Latin character.
  static bool isLatinChar(int charCode) {
    return (charCode >= basicLatinRange[0] && charCode <= basicLatinRange[1]) ||
        (charCode >= latin1SupplementRange[0] &&
            charCode <= latin1SupplementRange[1]) ||
        (charCode >= latinExtendedARange[0] &&
            charCode <= latinExtendedARange[1]) ||
        (charCode >= latinExtendedBRange[0] &&
            charCode <= latinExtendedBRange[1]);
  }
}
