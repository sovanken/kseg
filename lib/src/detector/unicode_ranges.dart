/// Unicode range definitions for script detection in the kseg package.
///
/// This file contains the character code ranges for Khmer and Latin scripts
/// used by the script detector to identify different writing systems.

/// Unicode ranges for the Khmer script
class KhmerUnicodeRanges {
  /// Main Khmer Unicode block (0x1780-0x17FF)
  static final List<int> mainRange = [0x1780, 0x17FF];

  /// Khmer Symbols (0x19E0-0x19FF)
  static final List<int> symbolsRange = [0x19E0, 0x19FF];

  /// Returns true if the character code is in the Khmer Unicode range
  static bool isKhmerChar(int charCode) {
    return (charCode >= mainRange[0] && charCode <= mainRange[1]) ||
        (charCode >= symbolsRange[0] && charCode <= symbolsRange[1]);
  }
}

/// Unicode ranges for Latin script
class LatinUnicodeRanges {
  /// Basic Latin (ASCII) (0x0000-0x007F)
  static final List<int> basicLatinRange = [0x0000, 0x007F];

  /// Latin-1 Supplement (0x0080-0x00FF)
  static final List<int> latin1SupplementRange = [0x0080, 0x00FF];

  /// Latin Extended-A (0x0100-0x017F)
  static final List<int> latinExtendedARange = [0x0100, 0x017F];

  /// Latin Extended-B (0x0180-0x024F)
  static final List<int> latinExtendedBRange = [0x0180, 0x024F];

  /// Returns true if the character code is in any Latin Unicode range
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
