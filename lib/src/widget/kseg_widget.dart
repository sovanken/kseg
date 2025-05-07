import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../detector/script_detector.dart';
import '../segmenter/text_segmenter.dart';

/// A widget that displays text with different styles for Khmer and Latin scripts
class Kseg extends StatelessWidget {
  /// The text to display
  final String text;

  // Khmer text style properties
  /// Font size for Khmer text
  final double? khFontSize;

  /// Font weight for Khmer text
  final FontWeight? khFontWeight;

  /// Font style for Khmer text
  final FontStyle? khFontStyle;

  /// Font family for Khmer text (system font or Google Font name)
  final String? khFont;

  /// Text color for Khmer text
  final Color? khColor;

  /// Background color for Khmer text
  final Color? khBackgroundColor;

  /// Letter spacing for Khmer text
  final double? khLetterSpacing;

  /// Word spacing for Khmer text
  final double? khWordSpacing;

  /// Text baseline for Khmer text
  final TextBaseline? khTextBaseline;

  /// Height for Khmer text
  final double? khHeight;

  /// Shadows for Khmer text
  final List<Shadow>? khShadows;

  /// Text decoration for Khmer text
  final TextDecoration? khDecoration;

  /// Text decoration color for Khmer text
  final Color? khDecorationColor;

  /// Text decoration style for Khmer text
  final TextDecorationStyle? khDecorationStyle;

  /// Text decoration thickness for Khmer text
  final double? khDecorationThickness;

  // Latin text style properties
  /// Font size for Latin text
  final double? latinFontSize;

  /// Font weight for Latin text
  final FontWeight? latinFontWeight;

  /// Font style for Latin text
  final FontStyle? latinFontStyle;

  /// Font family for Latin text (system font or Google Font name)
  final String? latinFont;

  /// Text color for Latin text
  final Color? latinColor;

  /// Background color for Latin text
  final Color? latinBackgroundColor;

  /// Letter spacing for Latin text
  final double? latinLetterSpacing;

  /// Word spacing for Latin text
  final double? latinWordSpacing;

  /// Text baseline for Latin text
  final TextBaseline? latinTextBaseline;

  /// Height for Latin text
  final double? latinHeight;

  /// Shadows for Latin text
  final List<Shadow>? latinShadows;

  /// Text decoration for Latin text
  final TextDecoration? latinDecoration;

  /// Text decoration color for Latin text
  final Color? latinDecorationColor;

  /// Text decoration style for Latin text
  final TextDecorationStyle? latinDecorationStyle;

  /// Text decoration thickness for Latin text
  final double? latinDecorationThickness;

  // Flag to determine if we should use Google Fonts
  /// Whether to use Google Fonts for the Khmer font
  final bool khUseGoogleFont;

  /// Whether to use Google Fonts for the Latin font
  final bool latinUseGoogleFont;

  // General text properties
  /// Text align for the entire widget
  final TextAlign? textAlign;

  /// Text direction for the entire widget
  final TextDirection? textDirection;

  /// Locale for the entire widget
  final Locale? locale;

  /// Overflow behavior for the entire widget
  final TextOverflow? overflow;

  /// Maximum lines for the entire widget
  final int? maxLines;

  /// Soft wrap for the entire widget
  final bool? softWrap;

  /// Text width basis for the entire widget
  final TextWidthBasis? textWidthBasis;

  /// Text height behavior for the entire widget
  final TextHeightBehavior? textHeightBehavior;

  /// Creates a new Kseg widget with support for both system fonts and Google Fonts
  const Kseg({
    Key? key,
    required this.text,

    // Khmer style properties
    this.khFontSize,
    this.khFontWeight,
    this.khFontStyle,
    this.khFont,
    this.khColor,
    this.khBackgroundColor,
    this.khLetterSpacing,
    this.khWordSpacing,
    this.khTextBaseline,
    this.khHeight,
    this.khShadows,
    this.khDecoration,
    this.khDecorationColor,
    this.khDecorationStyle,
    this.khDecorationThickness,
    this.khUseGoogleFont = true,

    // Latin style properties
    this.latinFontSize,
    this.latinFontWeight,
    this.latinFontStyle,
    this.latinFont,
    this.latinColor,
    this.latinBackgroundColor,
    this.latinLetterSpacing,
    this.latinWordSpacing,
    this.latinTextBaseline,
    this.latinHeight,
    this.latinShadows,
    this.latinDecoration,
    this.latinDecorationColor,
    this.latinDecorationStyle,
    this.latinDecorationThickness,
    this.latinUseGoogleFont = true,

    // General text properties
    this.textAlign,
    this.textDirection,
    this.locale,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create TextStyles for Khmer and Latin scripts
    TextStyle khmerStyle;

    // Use Google Fonts if specified, otherwise use regular TextStyle
    if (khFont != null && khUseGoogleFont) {
      khmerStyle = GoogleFonts.getFont(
        khFont!,
        fontSize: khFontSize,
        fontWeight: khFontWeight,
        fontStyle: khFontStyle,
        color: khColor,
        backgroundColor: khBackgroundColor,
        letterSpacing: khLetterSpacing,
        wordSpacing: khWordSpacing,
        textBaseline: khTextBaseline,
        height: khHeight,
        shadows: khShadows,
        decoration: khDecoration,
        decorationColor: khDecorationColor,
        decorationStyle: khDecorationStyle,
        decorationThickness: khDecorationThickness,
      );
    } else {
      khmerStyle = TextStyle(
        fontSize: khFontSize,
        fontWeight: khFontWeight,
        fontStyle: khFontStyle,
        fontFamily: khFont,
        color: khColor,
        backgroundColor: khBackgroundColor,
        letterSpacing: khLetterSpacing,
        wordSpacing: khWordSpacing,
        textBaseline: khTextBaseline,
        height: khHeight,
        shadows: khShadows,
        decoration: khDecoration,
        decorationColor: khDecorationColor,
        decorationStyle: khDecorationStyle,
        decorationThickness: khDecorationThickness,
      );
    }

    TextStyle latinStyle;

    // Use Google Fonts if specified, otherwise use regular TextStyle
    if (latinFont != null && latinUseGoogleFont) {
      latinStyle = GoogleFonts.getFont(
        latinFont!,
        fontSize: latinFontSize,
        fontWeight: latinFontWeight,
        fontStyle: latinFontStyle,
        color: latinColor,
        backgroundColor: latinBackgroundColor,
        letterSpacing: latinLetterSpacing,
        wordSpacing: latinWordSpacing,
        textBaseline: latinTextBaseline,
        height: latinHeight,
        shadows: latinShadows,
        decoration: latinDecoration,
        decorationColor: latinDecorationColor,
        decorationStyle: latinDecorationStyle,
        decorationThickness: latinDecorationThickness,
      );
    } else {
      latinStyle = TextStyle(
        fontSize: latinFontSize,
        fontWeight: latinFontWeight,
        fontStyle: latinFontStyle,
        fontFamily: latinFont,
        color: latinColor,
        backgroundColor: latinBackgroundColor,
        letterSpacing: latinLetterSpacing,
        wordSpacing: latinWordSpacing,
        textBaseline: latinTextBaseline,
        height: latinHeight,
        shadows: latinShadows,
        decoration: latinDecoration,
        decorationColor: latinDecorationColor,
        decorationStyle: latinDecorationStyle,
        decorationThickness: latinDecorationThickness,
      );
    }

    // Segment the text by script
    final segments = TextSegmenter.segment(text).segments;

    // Create TextSpans for each segment with the appropriate style
    final textSpans =
        segments.map((segment) {
          if (segment.scriptType == ScriptType.khmer) {
            return TextSpan(text: segment.text, style: khmerStyle);
          } else if (segment.scriptType == ScriptType.latin) {
            return TextSpan(text: segment.text, style: latinStyle);
          } else {
            // For other scripts, default to Latin style
            return TextSpan(text: segment.text, style: latinStyle);
          }
        }).toList();

    // Create a Text.rich widget with the TextSpans
    return Text.rich(
      TextSpan(children: textSpans),
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
