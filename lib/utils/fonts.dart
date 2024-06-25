// ignore_for_file: constant_identifier_names

class Font {
  static const Font urbanistMedium = Font("Urbanist_Medium");

  final String _fontName;

  const Font(this._fontName);

  String get value => _fontName;
}
