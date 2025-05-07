import 'package:flutter/material.dart';
import '../detector/script_detector.dart';
import '../segmenter/segment_model.dart';
import '../segmenter/text_segmenter.dart';

/// Style configuration for a specific script type.
///
/// Defines the visual styling properties to be applied to a specific script type
/// (Khmer, Latin, or other). This includes font properties, colors, spacing, and
/// text decoration.
class ScriptStyle {
  /// Font family to use for this script
  final String? fontFamily;

  /// Font size to use for this script
  final double? fontSize;

  /// Font weight to use for this script
  final FontWeight? fontWeight;

  /// Font style to use for this script
  final FontStyle? fontStyle;

  /// Text color to use for this script
  final Color? color;

  /// Letter spacing to use for this script
  final double? letterSpacing;

  /// Word spacing to use for this script
  final double? wordSpacing;

  /// Height (line height) to use for this script
  final double? height;

  /// Text decoration to use for this script
  final TextDecoration? decoration;

  /// Background color to use for this script
  final Color? backgroundColor;

  /// Creates a new ScriptStyle with the specified properties.
  ///
  /// All parameters are optional, allowing for partial style definitions
  /// that can be merged with other styles.
  const ScriptStyle({
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.color,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.decoration,
    this.backgroundColor,
  });

  /// Creates a TextStyle from this ScriptStyle.
  ///
  /// Converts this ScriptStyle object into a Flutter TextStyle object
  /// that can be applied to text widgets.
  ///
  /// Returns a TextStyle with the properties defined in this ScriptStyle.
  TextStyle toTextStyle() {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      backgroundColor: backgroundColor,
    );
  }

  /// Creates a copy of this ScriptStyle with the specified properties replaced.
  ///
  /// Returns a new ScriptStyle with the same properties as this one, except
  /// for the properties specified in the parameters, which are replaced.
  ScriptStyle copyWith({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? color,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextDecoration? decoration,
    Color? backgroundColor,
  }) {
    return ScriptStyle(
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      color: color ?? this.color,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      height: height ?? this.height,
      decoration: decoration ?? this.decoration,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  /// Merges this style with another style, with the other style taking precedence.
  ///
  /// Creates a new ScriptStyle by combining the properties of this style with
  /// those of another style. If a property is defined in both styles, the value
  /// from the other style is used.
  ///
  /// [other] is the style to merge with this one. If null, returns this style unchanged.
  ///
  /// Returns a new ScriptStyle with the merged properties.
  ScriptStyle merge(ScriptStyle? other) {
    if (other == null) return this;

    return ScriptStyle(
      fontFamily: other.fontFamily ?? fontFamily,
      fontSize: other.fontSize ?? fontSize,
      fontWeight: other.fontWeight ?? fontWeight,
      fontStyle: other.fontStyle ?? fontStyle,
      color: other.color ?? color,
      letterSpacing: other.letterSpacing ?? letterSpacing,
      wordSpacing: other.wordSpacing ?? wordSpacing,
      height: other.height ?? height,
      decoration: other.decoration ?? decoration,
      backgroundColor: other.backgroundColor ?? backgroundColor,
    );
  }
}

/// A collection of style configurations for different script types.
///
/// Holds and manages style definitions for Khmer, Latin, and other script types,
/// along with a default style that can be used as a base for all scripts.
class ScriptStyleCollection {
  /// Style for Khmer script
  final ScriptStyle khmerStyle;

  /// Style for Latin script
  final ScriptStyle latinStyle;

  /// Style for other scripts
  final ScriptStyle otherStyle;

  /// Default style to use as a base for all scripts
  final ScriptStyle defaultStyle;

  /// Creates a new ScriptStyleCollection with the specified styles.
  ///
  /// All parameters are optional and will use empty styles if not provided.
  const ScriptStyleCollection({
    this.khmerStyle = const ScriptStyle(),
    this.latinStyle = const ScriptStyle(),
    this.otherStyle = const ScriptStyle(),
    this.defaultStyle = const ScriptStyle(),
  });

  /// Gets the style for a specific script type.
  ///
  /// Returns the appropriate style for the given script type, merged with
  /// the default style. The default style serves as a base, and the script-specific
  /// style takes precedence for any properties that are defined in both.
  ///
  /// [script] is the script type to get the style for.
  ///
  /// Returns a ScriptStyle for the specified script type.
  ScriptStyle getStyleForScript(ScriptType script) {
    switch (script) {
      case ScriptType.khmer:
        return defaultStyle.merge(khmerStyle);
      case ScriptType.latin:
        return defaultStyle.merge(latinStyle);
      case ScriptType.other:
        return defaultStyle.merge(otherStyle);
      default:
        return defaultStyle;
    }
  }

  /// Creates a copy of this ScriptStyleCollection with the specified styles replaced.
  ///
  /// Returns a new ScriptStyleCollection with the same styles as this one, except
  /// for the styles specified in the parameters, which are replaced.
  ScriptStyleCollection copyWith({
    ScriptStyle? khmerStyle,
    ScriptStyle? latinStyle,
    ScriptStyle? otherStyle,
    ScriptStyle? defaultStyle,
  }) {
    return ScriptStyleCollection(
      khmerStyle: khmerStyle ?? this.khmerStyle,
      latinStyle: latinStyle ?? this.latinStyle,
      otherStyle: otherStyle ?? this.otherStyle,
      defaultStyle: defaultStyle ?? this.defaultStyle,
    );
  }
}

/// A class for styling segmented text.
///
/// Provides methods to apply different styles to text segments based on
/// their script type, creating TextSpans and Text widgets with appropriate
/// styling for each script.
class TextStyler {
  /// The collection of styles to apply to different scripts
  final ScriptStyleCollection styles;

  /// Creates a new TextStyler with the specified styles.
  ///
  /// [styles] is the collection of styles to use for different script types.
  /// If not provided, an empty style collection is used.
  const TextStyler({this.styles = const ScriptStyleCollection()});

  /// Creates a list of TextSpans for segmented text.
  ///
  /// Takes a segmented string and applies the appropriate style to each segment,
  /// creating a list of TextSpans that can be used in a RichText widget.
  ///
  /// [segmentedString] is the segmented text to style.
  ///
  /// Returns a list of TextSpans, each styled according to its script type.
  List<TextSpan> createTextSpans(SegmentedString segmentedString) {
    return segmentedString.segments.map((segment) {
      final style = styles.getStyleForScript(segment.scriptType);
      return TextSpan(text: segment.text, style: style.toTextStyle());
    }).toList();
  }

  /// Creates a RichText widget for segmented text.
  ///
  /// Takes a segmented string and creates a RichText widget with appropriately
  /// styled TextSpans for each segment.
  ///
  /// [segmentedString] is the segmented text to style.
  ///
  /// Returns a RichText widget with the styled text.
  RichText createRichText(SegmentedString segmentedString) {
    return RichText(text: TextSpan(children: createTextSpans(segmentedString)));
  }

  /// Creates a TextSpan tree for segmented text.
  ///
  /// Takes a segmented string and creates a parent TextSpan with child TextSpans
  /// for each segment, each styled appropriately.
  ///
  /// [segmentedString] is the segmented text to style.
  ///
  /// Returns a parent TextSpan containing styled child TextSpans.
  TextSpan createTextSpan(SegmentedString segmentedString) {
    return TextSpan(children: createTextSpans(segmentedString));
  }

  /// Segments and styles a string directly.
  ///
  /// Takes a string, segments it by script, and applies the appropriate style
  /// to each segment.
  ///
  /// [text] is the string to segment and style.
  ///
  /// Returns a list of TextSpans with appropriate styles.
  List<TextSpan> styleText(String text) {
    final segmented = TextSegmenter.segment(text);
    return createTextSpans(segmented);
  }

  /// Segments and styles a string directly, returning a RichText widget.
  ///
  /// Takes a string, segments it by script, and creates a RichText widget
  /// with appropriately styled TextSpans for each segment.
  ///
  /// [text] is the string to segment and style.
  ///
  /// Returns a RichText widget with the styled text.
  RichText styleTextAsRichText(String text) {
    final segmented = TextSegmenter.segment(text);
    return createRichText(segmented);
  }

  /// Segments and styles a string directly, returning a TextSpan tree.
  ///
  /// Takes a string, segments it by script, and creates a parent TextSpan with
  /// child TextSpans for each segment, each styled appropriately.
  ///
  /// [text] is the string to segment and style.
  ///
  /// Returns a parent TextSpan containing styled child TextSpans.
  TextSpan styleTextAsTextSpan(String text) {
    final segmented = TextSegmenter.segment(text);
    return createTextSpan(segmented);
  }

  /// Creates a Text widget with appropriately styled TextSpans for mixed scripts.
  ///
  /// Takes a string, segments it by script, and creates a Text.rich widget with
  /// appropriately styled TextSpans for each segment.
  ///
  /// [text] is the string to segment and style.
  /// Additional parameters control the appearance and behavior of the Text widget.
  ///
  /// Returns a Text.rich widget with the styled text.
  Text styleTextAsText(
    String text, {
    TextAlign? textAlign,
    TextDirection? textDirection,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text.rich(
      styleTextAsTextSpan(text),
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  /// Creates a copy of this TextStyler with the specified styles replaced.
  ///
  /// Returns a new TextStyler with the same styles as this one, except
  /// for the styles specified in the parameters, which are replaced.
  TextStyler copyWith({ScriptStyleCollection? styles}) {
    return TextStyler(styles: styles ?? this.styles);
  }
}
