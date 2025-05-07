import 'package:flutter/material.dart';
import '../detector/script_detector.dart';
import '../segmenter/segment_model.dart';
import '../segmenter/text_segmenter.dart';

/// Style configuration for a specific script type
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

  /// Creates a new ScriptStyle with the specified properties
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

  /// Creates a TextStyle from this ScriptStyle
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

  /// Creates a copy of this ScriptStyle with the specified properties replaced
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

  /// Merges this style with another style, with the other style taking precedence
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

/// A collection of style configurations for different script types
class ScriptStyleCollection {
  /// Style for Khmer script
  final ScriptStyle khmerStyle;

  /// Style for Latin script
  final ScriptStyle latinStyle;

  /// Style for other scripts
  final ScriptStyle otherStyle;

  /// Default style to use as a base for all scripts
  final ScriptStyle defaultStyle;

  /// Creates a new ScriptStyleCollection with the specified styles
  const ScriptStyleCollection({
    this.khmerStyle = const ScriptStyle(),
    this.latinStyle = const ScriptStyle(),
    this.otherStyle = const ScriptStyle(),
    this.defaultStyle = const ScriptStyle(),
  });

  /// Gets the style for a specific script type
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

  /// Creates a copy of this ScriptStyleCollection with the specified styles replaced
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

/// A class for styling segmented text
class TextStyler {
  /// The collection of styles to apply to different scripts
  final ScriptStyleCollection styles;

  /// Creates a new TextStyler with the specified styles
  const TextStyler({this.styles = const ScriptStyleCollection()});

  /// Creates a list of TextSpans for segmented text
  ///
  /// Each TextSpan will have a style appropriate for its script type
  List<TextSpan> createTextSpans(SegmentedString segmentedString) {
    return segmentedString.segments.map((segment) {
      final style = styles.getStyleForScript(segment.scriptType);
      return TextSpan(text: segment.text, style: style.toTextStyle());
    }).toList();
  }

  /// Creates a RichText widget for segmented text
  ///
  /// The RichText widget will contain TextSpans with appropriate styles
  RichText createRichText(SegmentedString segmentedString) {
    return RichText(text: TextSpan(children: createTextSpans(segmentedString)));
  }

  /// Creates a TextSpan tree for segmented text
  ///
  /// The returned TextSpan will contain child TextSpans with appropriate styles
  TextSpan createTextSpan(SegmentedString segmentedString) {
    return TextSpan(children: createTextSpans(segmentedString));
  }

  /// Segments and styles a string directly
  ///
  /// Returns a list of TextSpans with appropriate styles
  List<TextSpan> styleText(String text) {
    final segmented = TextSegmenter.segment(text);
    return createTextSpans(segmented);
  }

  /// Segments and styles a string directly, returning a RichText widget
  RichText styleTextAsRichText(String text) {
    final segmented = TextSegmenter.segment(text);
    return createRichText(segmented);
  }

  /// Segments and styles a string directly, returning a TextSpan tree
  TextSpan styleTextAsTextSpan(String text) {
    final segmented = TextSegmenter.segment(text);
    return createTextSpan(segmented);
  }

  /// Creates a Text widget with appropriately styled TextSpans for mixed scripts
  ///
  /// This is a convenience method for creating a Text.rich widget
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

  /// Creates a copy of this TextStyler with the specified styles replaced
  TextStyler copyWith({ScriptStyleCollection? styles}) {
    return TextStyler(styles: styles ?? this.styles);
  }
}
