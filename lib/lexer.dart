import 'dart:io';
import 'package:dsil/token.dart';
import 'package:dsil/error.dart';

ErrorReporter error = ErrorReporter();

class Lexer {
  lex(file, source) {
    List<Token> tokens = [];
    int curr = 0;
    int line = 1;
    int errors = 0;
    List<String> chars = source.split("");

    bool _isAtEnd() {
      return (curr >= chars.length);
    }

    bool _isPeekAtEnd() {
      return (curr + 1 == chars.length);
    }

    peek(pos) {
      if (_isPeekAtEnd()) {
        return Token(file, TokenType.LANGUAGE, source.split("").length,
            chars.length, Tokens.EOF);
      } else {
        return chars[pos + 1];
      }
    }

    bool _isNumber(string) {
      return (string.contains(RegExp(r'[0-9]')));
    }

    bool _isLetter(string) {
      return (string.contains(RegExp(r'[A-Z]')) ||
          string.contains(RegExp(r'[a-z]')));
    }

    while (!_isAtEnd()) {
      switch (chars[curr]) {
        case '\r':
          break;
        case '\t':
          break;
        case ' ':
          break;
        case '\n':
          {
            // tokens.add({TokenType.LANGUAGE: Token.EOL});
            line++;
          }
          break;

        case '(':
          {
            // tokens.add({TokenType.CHARACTER: Token.LEFT_BRACE});
            tokens.add(Token(
                file, TokenType.CHARACTER, line, curr, Tokens.LEFT_PAREN));
          }
          break;

        case ')':
          {
            // tokens.add({TokenType.CHARACTER: Token.RIGHT_BRACE});
            tokens.add(Token(
                file, TokenType.CHARACTER, line, curr, Tokens.RIGHT_PAREN));
          }
          break;

        case '{':
          {
            // tokens.add({TokenType.CHARACTER: Token.LEFT_PAREN});
            tokens.add(Token(
                file, TokenType.CHARACTER, line, curr, Tokens.LEFT_BRACE));
          }
          break;

        case '}':
          {
            // tokens.add({TokenType.CHARACTER: Token.RIGHT_PAREN});
            tokens.add(Token(
                file, TokenType.CHARACTER, line, curr, Tokens.RIGHT_BRACE));
          }
          break;

        case '.':
          {
            // tokens.add({TokenType.CHARACTER: Token.DOT});
            tokens
                .add(Token(file, TokenType.CHARACTER, line, curr, Tokens.DOT));
          }
          break;

        case ',':
          {
            // tokens.add({TokenType.CHARACTER: Token.COMMA});
            tokens.add(
                Token(file, TokenType.CHARACTER, line, curr, Tokens.COMMA));
          }
          break;

        case ';':
          {
            // tokens.add({TokenType.CHARACTER: Token.SEMICOLON});
            tokens.add(
                Token(file, TokenType.CHARACTER, line, curr, Tokens.SEMICOLON));
          }
          break;

        case '+':
          {
            // tokens.add({TokenType.OPERATOR: Token.PLUS});
            tokens
                .add(Token(file, TokenType.OPERATOR, line, curr, Tokens.PLUS));
          }
          break;

        case '-':
          {
            // tokens.add({TokenType.OPERATOR: Token.MINUS});
            tokens
                .add(Token(file, TokenType.OPERATOR, line, curr, Tokens.MINUS));
          }
          break;

        case '*':
          {
            // tokens.add({TokenType.OPERATOR: Token.STAR});
            tokens
                .add(Token(file, TokenType.OPERATOR, line, curr, Tokens.STAR));
          }
          break;

        case '/':
          {
            if (peek(curr) == '/') {
              while (peek(curr) != '\n' && !_isAtEnd()) {
                curr++;
              }
            } else {
              // tokens.add({TokenType.OPERATOR: Token.SLASH});
              tokens.add(
                  Token(file, TokenType.OPERATOR, line, curr, Tokens.SLASH));
            }
          }
          break;

        case '=':
          {
            if (peek(curr) == '=') {
              // tokens.add({TokenType.COMPARATOR: Token.EQUAL_EQUAL});
              tokens.add(Token(
                  file, TokenType.COMPARATOR, line, curr, Tokens.EQUAL_EQUAL));
              curr++;
            } else {
              // tokens.add({TokenType.ASSIGN: Token.EQUAL});
              tokens
                  .add(Token(file, TokenType.ASSIGN, line, curr, Tokens.EQUAL));
            }
          }
          break;

        case '!':
          {
            if (peek(curr) == '=') {
              // tokens.add({TokenType.COMPARATOR: Token.BANG_EQUAL});
              tokens.add(Token(
                  file, TokenType.COMPARATOR, line, curr, Tokens.BANG_EQUAL));
              curr++;
            } else {
              // tokens.add({TokenType.CHARACTER: Token.BANG});
              tokens.add(
                  Token(file, TokenType.CHARACTER, line, curr, Tokens.BANG));
            }
          }
          break;

        case '<':
          {
            if (peek(curr) == '=') {
              // tokens.add({TokenType.COMPARATOR: Token.LESS_EQUAL});
              tokens.add(Token(
                  file, TokenType.COMPARATOR, line, curr, Tokens.LESS_EQUAL));
              curr++;
            } else {
              // tokens.add({TokenType.CHARACTER: Token.LESS});
              tokens.add(
                  Token(file, TokenType.COMPARATOR, line, curr, Tokens.LESS));
            }
          }
          break;

        case '>':
          {
            if (peek(curr) == '=') {
              // tokens.add({TokenType.COMPARATOR: Token.GREATER_EQUAL});
              tokens.add(Token(file, TokenType.COMPARATOR, line, curr,
                  Tokens.GREATER_EQUAL));
              curr++;
            } else {
              // tokens.add({TokenType.CHARACTER: Token.GREATER});
              tokens.add(Token(
                  file, TokenType.COMPARATOR, line, curr, Tokens.GREATER));
            }
          }
          break;

        case '"':
          {
            List<String> stringArray = [];
            int start = curr;
            curr++;
            while (true) {
              if (_isAtEnd()) {
                error.error(file, line, "Unterminated string.");
                errors++;
                break;
              } else if (chars[curr] == '\n') {
                error.error(file, line, "Unterminated string.");
                errors++;
                break;
              } else if (chars[curr] == '"') {
                // tokens.add({TokenType.STRING: stringArray.join("")});
                tokens.add(Token(
                    file, TokenType.STRING, line, start, stringArray.join("")));
                break;
              }
              stringArray.add(chars[curr]);
              curr++;
            }
          }
          break;

        case '`':
          {
            List<String> stringArray = [];
            int start = curr;
            curr++;
            while (true) {
              if (_isAtEnd()) {
                error.error(file, line, "Unterminated raw_string.");
                errors++;
                break;
              } else if (chars[curr] == '\n') {
                error.error(file, line, "Unterminated raw_string.");
                errors++;
                break;
              } else if (chars[curr] == '`') {
                // tokens.add({TokenType.STRING: stringArray.join("")});
                tokens.add(Token(file, TokenType.RAW_STRING, line, start,
                    stringArray.join("")));
                break;
              }
              stringArray.add(chars[curr]);
              curr++;
            }
          }
          break;

        default:
          {
            if (_isLetter(chars[curr])) {
              List<String> keywordArray = [];
              while (true) {
                if (_isAtEnd() || !_isLetter(chars[curr])) {
                  String value = keywordArray.join("");
                  if (value == "true" || value == "false") {
                    value == "true"
                        // ? tokens.add({TokenType.BOOLEAN: true})
                        ? tokens.add(
                            Token(file, TokenType.BOOLEAN, line, curr, true))
                        // : tokens.add({TokenType.BOOLEAN: false});
                        : tokens.add(
                            Token(file, TokenType.BOOLEAN, line, curr, false));
                  } else {
                    // tokens.add({TokenType.KEYWORD: keywordArray.join("")});
                    tokens.add(Token(file, TokenType.KEYWORD, line, curr,
                        keywordArray.join("")));
                  }
                  curr--;
                  break;
                }
                keywordArray.add(chars[curr]);
                curr++;
              }
            } else if (_isNumber(chars[curr])) {
              List<String> numberArray = [];
              while (true) {
                if (_isAtEnd() || !_isNumber(chars[curr])) {
                  // tokens.add({TokenType.NUMBER: int.parse(numberArray.join(""))});
                  tokens.add(Token(file, TokenType.INTEGER, line, curr,
                      int.parse(numberArray.join(""))));
                  curr--;
                  break;
                }
                numberArray.add(chars[curr]);
                curr++;
              }
            } else {
              error.error(file, line, "Illegal character: `${chars[curr]}`.");
              errors++;
            }
          }
      }
      curr++;
    }
    if (errors > 0) {
      print(
          "\x1B[34m[INFO] $errors error(s) found. Lexical analysis failed.\x1B[0m");
      exit(1);
    } else {
      // tokens.add({TokenType.LANGUAGE: Token.EOF});
      tokens.add(Token(file, TokenType.LANGUAGE, line, curr, Tokens.EOF));
      return tokens;
    }
  }
}
