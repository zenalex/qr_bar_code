import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'aztec.dart';
import 'barcode_exception.dart';
import 'barcode_operations.dart';
import 'code_generate_type.dart';
import 'codebar.dart';
import 'code128.dart';
import 'code39.dart';
import 'code93.dart';
import 'datamatrix.dart';
import 'ean13.dart';
import 'ean2.dart';
import 'ean5.dart';
import 'ean8.dart';
import 'isbn.dart';
import 'itf.dart';
import 'itf14.dart';
import 'itf16.dart';
import 'pdf417.dart';
import 'qrcode.dart';
import 'rm4scc.dart';
import 'telepen.dart';
import 'upca.dart';
import 'upce.dart';

/// Barcode generation class
@immutable
abstract class CodeType {
  /// Abstract constructor
  const CodeType();

  /// Create a specific [CodeType] instance based on the [CodeGenerateType]
  /// this uses only the default barcode settings.
  /// For finer-grained usage, use the static methods:
  /// * Barcode.code39()
  /// * Barcode.code93()
  /// * Barcode.code128()
  /// * ...
  factory CodeType.fromType(CodeGenerateType type) {
    switch (type) {
      case CodeGenerateType.code39:
        return CodeType.code39();
      case CodeGenerateType.code93:
        return CodeType.code93();
      case CodeGenerateType.code128:
        return CodeType.code128();
      case CodeGenerateType.gs128:
        return CodeType.gs128();
      case CodeGenerateType.itf:
        return CodeType.itf();
      case CodeGenerateType.codeITF14:
        return CodeType.itf14();
      case CodeGenerateType.codeITF16:
        return CodeType.itf16();
      case CodeGenerateType.codeEAN13:
        return CodeType.ean13();
      case CodeGenerateType.codeEAN8:
        return CodeType.ean8();
      case CodeGenerateType.codeEAN5:
        return CodeType.ean5();
      case CodeGenerateType.codeEAN2:
        return CodeType.ean2();
      case CodeGenerateType.codeISBN:
        return CodeType.isbn();
      case CodeGenerateType.codeUPCA:
        return CodeType.upcA();
      case CodeGenerateType.codeUPCE:
        return CodeType.upcE();
      case CodeGenerateType.telepen:
        return CodeType.telepen();
      case CodeGenerateType.codeBar:
        return CodeType.codeBar();
      case CodeGenerateType.rm4scc:
        return CodeType.rm4scc();
      case CodeGenerateType.qrCode:
        return CodeType.qrCode();
      case CodeGenerateType.pdf417:
        return CodeType.pdf417();
      case CodeGenerateType.dataMatrix:
        return CodeType.dataMatrix();
      case CodeGenerateType.aztec:
        return CodeType.aztec();
    }
  }

  /// Code 39 [CodeType]
  ///
  /// The Code 39 specification defines 43 characters, consisting of uppercase
  /// letters (A through Z), numeric digits (0 through 9) and a number of special
  /// characters (-, ., \$, /, +, %, and space).
  ///
  /// An additional character (denoted '*') is used for both start and stop
  /// delimiters.
  ///
  static CodeType code39() => const BarcodeCode39();

  /// Code 93 [CodeType]
  ///
  /// Code 93 is a barcode symbology designed in 1982 by Intermec to provide
  /// a higher density and data security enhancement to Code 39.
  ///
  /// It is an alphanumeric, variable length symbology.
  ///
  /// Code 93 is used primarily by Canada Post to encode supplementary
  /// delivery information.
  ///

  static CodeType code93() => const BarcodeCode93();

  /// Code128 [CodeType]
  ///
  /// Code 128 is a high-density linear barcode symbology defined in
  /// ISO/IEC 15417:2007. It is used for alphanumeric or numeric-only barcodes.
  ///
  /// It can encode all 128 characters of ASCII and, by use of an extension
  /// symbol, the Latin-1 characters defined in ISO/IEC 8859-1.
  ///
  /// [useCode128A], [useCode128B], [useCode128C] specify what code tables are
  /// allowed. The library will optimize the code to minimize the number of bars
  /// depending on the available tables.
  ///
  /// When [escapes] is enabled, special function codes are accepted in the data
  /// for application-defined meaning.
  /// Use `"{1}"` for FNC1, `"{2}"` for FNC2, `"{3}"` for FNC3, `"{4}"` for FNC4.
  /// Example: `"Test{1}1233{3}45"` will be equivalent to `Test FNC1 1233 FNC3 45`
  /// for the reader application.
  static CodeType code128({
    bool useCode128A = true,
    bool useCode128B = true,
    bool useCode128C = true,
    bool escapes = false,
  }) => BarcodeCode128(useCode128A, useCode128B, useCode128C, false, escapes);

  /// GS1-128 [CodeType]
  ///
  /// The GS1-128 is an application standard of the GS1.
  ///
  /// It uses a series of Application Identifiers to include additional data
  /// such as best before dates, batch numbers, quantities, weights and many
  /// other attributes needed by the user.
  ///
  /// the data may contain parenthesis to separate Application Identifiers.
  /// Example: Use `"(420)22345(56780000000001)"` to generate the following barcode.
  /// For the reader application, this will be equivalent to
  /// `420 FNC1 22345 FNC1 56780000000001`.
  ///
  /// [useCode128A], [useCode128B], [useCode128C] specify what code tables are
  /// allowed. The library will optimize the code to minimize the number of bars
  /// depending on the available tables.
  ///
  /// When [escapes] is enabled, special function codes are accepted in the data
  /// for application-defined meaning.
  /// Use `"{1}"` for FNC1, `"{2}"` for FNC2, `"{3}"` for FNC3, `"{4}"` for FNC4.
  /// Example: `"Test{1}1233{3}45"` will be equivalent to `Test FNC1 1233 FNC3 45`
  /// for the reader application.
  static CodeType gs128({
    bool useCode128A = true,
    bool useCode128B = true,
    bool useCode128C = true,
    bool escapes = false,
  }) => BarcodeCode128(useCode128A, useCode128B, useCode128C, true, escapes);

  /// ITF-14 Barcode
  ///
  /// ITF-14 is the GS1 implementation of an Interleaved 2 of 5 (ITF) bar code
  /// to encode a Global Trade Item Number. ITF-14 symbols are generally used
  /// on packaging levels of a product, such as a case box of 24 cans of soup.
  /// The ITF-14 will always encode 14 digits.
  ///
  /// [drawBorder] draws a black border around the barcode
  ///
  /// [borderWidth] specify the width of the border around the barcode
  ///
  /// [quietWidth] defines the width of the quiet zone before and after
  /// the barcode, inside the border
  static CodeType itf14({
    bool drawBorder = true,
    double? borderWidth,
    double? quietWidth,
  }) => BarcodeItf14(drawBorder, borderWidth, quietWidth);

  /// ITF-16 Barcode
  ///
  /// ITF-16 is a standardized version of the Interleaved 2 of 5 barcode,
  /// also known as UPC Shipping Container Symbol. It is used to mark cartons,
  /// cases, or pallets that contain products. It containins 16 digits, the last
  /// being a check digit.
  ///
  /// [drawBorder] draws a black border around the barcode
  ///
  /// [borderWidth] specify the width of the border around the barcode
  ///
  /// [quietWidth] defines the width of the quiet zone before and after
  /// the barcode, inside the border
  static CodeType itf16({
    bool drawBorder = true,
    double? borderWidth,
    double? quietWidth,
  }) => BarcodeItf16(drawBorder, borderWidth, quietWidth);

  /// 2 of 5 Barcode
  ///
  /// Interleaved 2 of 5 (ITF) is a continuous two-width barcode symbology
  /// encoding digits. It is used commercially on 135 film, for ITF-14 barcodes,
  /// and on cartons of some products, while the products inside are labeled
  /// with UPC or EAN.
  ///
  /// [addChecksum] add Modulo 10 checksum
  ///
  /// [zeroPrepend] Prepend with a '0' if the length is not odd
  ///
  /// [drawBorder] draws a black border around the barcode
  ///
  /// [borderWidth] specify the width of the border around the barcode
  ///
  /// [quietWidth] defines the width of the quiet zone before and after
  /// the barcode, inside the border
  ///
  /// [fixedLength] defines the barcode length if the length is to be fixed.
  /// Set to null for not fixed length.
  static CodeType itf({
    bool addChecksum = false,
    bool zeroPrepend = false,
    bool drawBorder = false,
    double? borderWidth,
    double? quietWidth,
    int? fixedLength,
  }) => BarcodeItf(
    addChecksum,
    zeroPrepend,
    drawBorder,
    borderWidth,
    quietWidth,
    fixedLength,
  );

  /// EAN 13 Barcode
  ///
  /// The International Article Number is a standard describing a barcode
  /// symbology and numbering system used in global trade to identify a specific
  /// retail product type, in a specific packaging configuration,
  /// from a specific manufacturer.
  ///
  /// [drawEndChar] draws the end char '>' in the right margin
  static CodeType ean13({bool drawEndChar = false}) =>
      BarcodeEan13(drawEndChar);

  /// EAN 8 Barcode
  ///
  /// An EAN-8 is an EAN/UPC symbology barcode and is derived from the longer
  /// International Article Number code. It was introduced for use on small
  /// packages where an EAN-13 barcode would be too large; for example on
  /// cigarettes, pencils, and chewing gum packets. It is encoded identically
  /// to the 12 digits of the UPC-A barcode, except that it has 4 digits in
  /// each of the left and right halves.
  ///
  /// [drawSpacers] draws the start '<' and end '>' chars in the left and right margins
  static CodeType ean8({bool drawSpacers = false}) => BarcodeEan8(drawSpacers);

  /// EAN 5 Barcode
  ///
  /// The EAN-5 is a 5-digit European Article Number code, and is a supplement
  /// to the EAN-13 barcode used on books. It is used to give a suggestion
  /// for the price of the book.
  static CodeType ean5() => const BarcodeEan5();

  /// EAN 2 Barcode
  ///
  /// The EAN-2 is a supplement to the EAN-13 and UPC-A barcodes.
  /// It is often used on magazines and periodicals to indicate an issue number.
  static CodeType ean2() => const BarcodeEan2();

  /// ISBN Barcode
  ///
  /// The International Standard Book Number is a numeric commercial book
  /// identifier which is intended to be unique. Publishers purchase ISBNs
  /// from an affiliate of the International ISBN Agency.
  ///
  /// [drawEndChar] draws the end char '>' in the right margin
  ///
  /// [drawIsbn] draws the ISBN number as text on the top of the barcode
  static CodeType isbn({bool drawEndChar = false, bool drawIsbn = true}) =>
      BarcodeIsbn(drawEndChar, drawIsbn);

  /// UPC-A Barcode
  ///
  /// The Universal Product Code is a barcode symbology that is widely used in
  /// the United States, Canada, Europe, Australia, New Zealand, and other
  /// countries for tracking trade items in stores. UPC consists of 12 numeric
  /// digits that are uniquely assigned to each trade item.
  static CodeType upcA() => const BarcodeUpcA();

  /// UPC-E Barcode
  ///
  /// The Universal Product Code is a barcode symbology that is widely used in
  /// the United States, Canada, Europe, Australia, New Zealand, and other
  /// countries for tracking trade items in stores. To allow the use of UPC
  /// barcodes on smaller packages, where a full 12-digit barcode may not fit,
  /// a zero-suppressed version of UPC was developed, called UPC-E, in which
  /// the number system digit, all trailing zeros in the manufacturer code,
  /// and all leading zeros in the product code, are suppressed.
  ///
  /// [fallback] fallback to UPC-A if the code cannot be converted to UPC-E
  static CodeType upcE({bool fallback = false}) => BarcodeUpcE(fallback);

  /// Telepen Barcode
  ///
  /// Telepen is a barcode designed in 1972 in the UK to express all 128 ASCII
  /// characters without using shift characters for code switching, and using
  /// only two different widths for bars and spaces.
  static CodeType telepen() => const BarcodeTelepen();

  /// QR Code
  ///
  /// QR code (abbreviated from Quick Response code) is the trademark for a
  /// type of matrix barcode (or two-dimensional barcode) first designed in 1994
  /// for the automotive industry in Japan.
  ///
  /// [typeNumber] QR code version number 1 to 40
  ///
  /// [errorCorrectLevel] is the QR Code Correction Level
  static CodeType qrCode({
    int? typeNumber,
    BarcodeQRCorrectionLevel errorCorrectLevel = BarcodeQRCorrectionLevel.low,
  }) => BarcodeQR(typeNumber, errorCorrectLevel);

  /// PDF417
  ///
  /// PDF417 is a stacked linear barcode format used in a variety of applications
  /// such as transport, identification cards, and inventory management.
  ///
  /// [securityLevel] is the error recovery level
  ///
  /// [moduleHeight] defines the height of the bars
  ///
  /// [preferredRatio] defines the width to height ratio
  static CodeType pdf417({
    Pdf417SecurityLevel securityLevel = Pdf417SecurityLevel.level2,
    double moduleHeight = 2.0,
    double preferredRatio = 3.0,
  }) => BarcodePDF417(securityLevel, moduleHeight, preferredRatio);

  /// Code Bar Barcode
  ///
  /// Code Bar was designed to be accurately read even when printed on dot-matrix
  /// printers for multi-part forms such as FedEx airbills and blood bank forms,
  /// where variants are still in use as of 2007.
  ///
  /// [start] is the start symbol to use
  ///
  /// [stop] is the stop symbol to use
  ///
  /// [printStartStop] outputs the Start and Stop characters as text under the
  /// barcode
  ///
  /// [explicitStartStop] explicitly specify the Start and Stop characters
  /// as letters (ABCDETN*) in the data. In this case, start and stop
  /// settings are ignored
  static CodeType codeBar({
    BarcodeCodeBarStartStop start = BarcodeCodeBarStartStop.A,
    BarcodeCodeBarStartStop stop = BarcodeCodeBarStartStop.B,
    bool printStartStop = false,
    bool explicitStartStop = false,
  }) => BarcodeCodeBar(start, stop, printStartStop, explicitStartStop);

  /// RM4SCC Barcode
  ///
  /// The RM4SCC is used for the Royal Mail Cleanmail service. It enables UK
  /// postcodes as well as Delivery Point Suffixes (DPSs) to be easily read by
  /// a machine at high speed.
  static CodeType rm4scc() => const BarcodeRm4scc();

  /// Data Matrix
  ///
  /// A Data Matrix is a two-dimensional barcode consisting of black and white
  /// "cells" or modules arranged in either a square or rectangular pattern, also
  /// known as a matrix.
  ///
  /// Use [DataMatrixEncoder] to generate GS1 codes.
  static CodeType dataMatrix() => const BarcodeDataMatrix();

  /// Aztec
  ///
  /// Named after the resemblance of the central finder pattern to an
  /// Aztec pyramid.
  ///
  /// [minECCPercent] defines the error correction percentage
  ///
  /// [userSpecifiedLayers] defines the number of layers
  static CodeType aztec({
    int minECCPercent = BarcodeAztec.defaultEcPercent,
    int userSpecifiedLayers = BarcodeAztec.defaultLayers,
  }) => BarcodeAztec(minECCPercent, userSpecifiedLayers);

  /// Main method to produce the barcode graphic description.
  /// Returns a stream of drawing operations required to properly
  /// display the barcode as a UTF-8 string.
  ///
  /// Use it with:
  /// ```dart
  /// for (var op in Barcode.code39().make('HELLO', width: 200, height: 300)) {
  ///   print(op);
  /// }
  /// ```
  Iterable<BarcodeElement> make(
    String data, {
    required double width,
    required double height,
    bool drawText = false,
    double? fontHeight,
    double? textPadding,
  }) => makeBytes(
    utf8.encoder.convert(data),
    width: width,
    height: height,
    drawText: drawText,
    fontHeight: fontHeight,
    textPadding: textPadding,
  );

  /// Generate the barcode graphic description like [make] but takes a
  /// Uint8List data.
  Iterable<BarcodeElement> makeBytes(
    Uint8List data, {
    required double width,
    required double height,
    bool drawText = false,
    double? fontHeight,
    double? textPadding,
  });

  /// Check if the Barcode is valid
  @nonVirtual
  bool isValid(String data) {
    try {
      verify(data);
    } catch (_) {
      return false;
    }

    return true;
  }

  /// Check if the Barcode is valid
  @nonVirtual
  bool isValidBytes(Uint8List data) {
    try {
      verifyBytes(data);
    } catch (_) {
      return false;
    }

    return true;
  }

  /// Check if the Barcode is valid. Throws [BarcodeException] with a proper
  /// message in case of error
  void verify(String data) => verifyBytes(utf8.encoder.convert(data));

  /// Check if the Barcode is valid. Throws [BarcodeException] with a proper
  /// message in case of error
  void verifyBytes(Uint8List data) {
    if (data.length > maxLength) {
      throw BarcodeException(
        'Unable to encode "$data", maximum length is $maxLength for $name Barcode',
      );
    }

    if (data.length < minLength) {
      throw BarcodeException(
        'Unable to encode "$data", minimum length is $minLength for $name Barcode',
      );
    }

    final chr = charSet.toSet();

    for (var code in data) {
      if (!chr.contains(code)) {
        throw BarcodeException(
          'Unable to encode "${String.fromCharCode(code)}" to $name Barcode',
        );
      }
    }
  }

  /// Create an SVG file with this Barcode from String data
  @nonVirtual
  String toSvg(
    String data, {
    double x = 0,
    double y = 0,
    double width = 200,
    double height = 80,
    bool drawText = true,
    String fontFamily = 'monospace',
    double? fontHeight,
    double? textPadding,
    int color = 0x000000,
    bool fullSvg = true,
    double baseline = .75,
  }) {
    fontHeight ??= height * 0.2;
    textPadding ??= height * 0.05;

    final recipe = make(
      data,
      width: width.toDouble(),
      height: height.toDouble(),
      drawText: drawText,
      fontHeight: fontHeight,
      textPadding: textPadding,
    );

    return _toSvg(
      recipe,
      x,
      y,
      width,
      height,
      fontFamily,
      fontHeight,
      textPadding,
      color,
      fullSvg,
      baseline,
    );
  }

  /// Create an SVG file with this Barcode from Uint8List data
  @nonVirtual
  String toSvgBytes(
    Uint8List data, {
    double x = 0,
    double y = 0,
    double width = 200,
    double height = 80,
    bool drawText = true,
    String fontFamily = 'monospace',
    double? fontHeight,
    double? textPadding,
    int color = 0x000000,
    bool fullSvg = true,
    double baseline = .75,
  }) {
    fontHeight ??= height * 0.2;
    textPadding ??= height * 0.05;

    final recipe = makeBytes(
      data,
      width: width.toDouble(),
      height: height.toDouble(),
      drawText: drawText,
      fontHeight: fontHeight,
      textPadding: textPadding,
    );

    return _toSvg(
      recipe,
      x,
      y,
      width,
      height,
      fontFamily,
      fontHeight,
      textPadding,
      color,
      fullSvg,
      baseline,
    );
  }

  String _d(double d) {
    assert(d != double.infinity);
    return d.toStringAsFixed(5);
  }

  String _s(String s) {
    const esc = HtmlEscape();
    return esc.convert(s);
  }

  String _c(int c) {
    return '#${(c & 0xffffff).toRadixString(16).padLeft(6, '0')}';
  }

  String _toSvg(
    Iterable<BarcodeElement> recipe,
    double x,
    double y,
    double width,
    double height,
    String fontFamily,
    double fontHeight,
    double textPadding,
    int color,
    bool fullSvg,
    double baseline,
  ) {
    final path = StringBuffer();
    final tSpan = StringBuffer();

    // Draw the barcode
    for (var elem in recipe) {
      if (elem is BarcodeBar) {
        if (elem.black) {
          path.write('M ${_d(x + elem.left)} ${_d(y + elem.top)} ');
          path.write('h ${_d(elem.width)} ');
          path.write('v ${_d(elem.height)} ');
          path.write('h ${_d(-elem.width)} ');
          path.write('z ');
        }
      } else if (elem is BarcodeText) {
        final lY = y + elem.top + elem.height * baseline;

        final double lX;
        String anchor;
        switch (elem.align) {
          case BarcodeTextAlign.left:
            lX = x + elem.left;
            anchor = 'start';
            break;
          case BarcodeTextAlign.center:
            lX = x + elem.left + elem.width / 2;
            anchor = 'middle';
            break;
          case BarcodeTextAlign.right:
            lX = x + elem.left + elem.width;
            anchor = 'end';
            break;
        }

        tSpan.write(
          '<tspan style="text-anchor: $anchor" x="${_d(lX)}" y="${_d(lY)}">${_s(elem.text)}</tspan>',
        );
      }
    }

    final output = StringBuffer();
    if (fullSvg) {
      output.write(
        '<svg viewBox="${_d(x)} ${_d(y)} ${_d(width)} ${_d(height)}" xmlns="http://www.w3.org/2000/svg">',
      );
    }

    output.write('<path d="$path" style="fill: ${_c(color)}"/>');
    output.write(
      '<text style="fill: ${_c(color)}; font-family: &quot;${_s(fontFamily)}&quot;; font-size: ${_d(fontHeight)}px" x="${_d(x)}" y="${_d(y)}">$tSpan</text>',
    );

    if (fullSvg) {
      output.write('</svg>');
    }

    return output.toString();
  }

  /// Returns the list of accepted codePoints for this [CodeType]
  Iterable<int> get charSet;

  /// Returns the name of this [CodeType]
  String get name;

  static const int _infiniteMaxLength = 1000;

  /// Returns maximum number of characters this [CodeType] can encode
  int get maxLength => _infiniteMaxLength;

  /// Returns minimum number of characters this [CodeType] can encode
  int get minLength => 1;

  @override
  String toString() => 'Barcode $name';
}
