// ignore_for_file: constant_identifier_names

enum TokenType {
  LANGUAGE,
  KEYWORD,
  STRING,
  RAW_STRING,
  INTEGER,
  FLOAT,
  BOOLEAN,
  CHARACTER,
  OPERATOR,
  COMPARATOR,
  ASSIGN,
}

enum Tokens {
  // Single-character tokens.
  LEFT_PAREN,
  RIGHT_PAREN,
  LEFT_BRACE,
  RIGHT_BRACE,
  COMMA,
  DOT,
  MINUS,
  PLUS,
  SEMICOLON,
  SLASH,
  STAR,

  // Single-or-Double-character tokens.
  BANG,
  BANG_EQUAL,
  EQUAL,
  EQUAL_EQUAL,
  GREATER,
  GREATER_EQUAL,
  LESS,
  LESS_EQUAL,

  // Literals.
  STRING,
  NUMBER,

  //EOF
  EOF
}

class Token {
  final String file;
  final TokenType type;
  final int line;
  final int pos;
  final dynamic value;

  Token(this.file, this.type, this.line, this.pos, this.value);
}
