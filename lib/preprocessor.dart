import 'package:dsil/token.dart';
import 'package:dsil/error.dart';
import 'dart:io';

ErrorReporter report = ErrorReporter();

class Preprocessor {
  process(List<Token> tokens) {
    List<Token> macroresult = [];
    List<Token> result = [];
    int errors = 0;
    Map<String, List<Token>> macros = {};

    for (int i = 0; i < tokens.length; i++) {
      TokenType type = tokens[i].type;
      dynamic value = tokens[i].value;

      if (type == TokenType.KEYWORD) {
        if (value == "mac") {
          List<Token> macro = [];
          String name = tokens[i + 1].value;
          i += 2;
          while (true) {
            if (tokens[i].value == "end") {
              break;
            }
            macro.add(tokens[i]);
            i++;
          }
          macros[name] = macro;
        } else {
          macroresult.add(tokens[i]);
        }
      } else {
        macroresult.add(tokens[i]);
      }
      if (errors > 0) {
        print(
            "\x1B[34m[INFO] $errors error(s) found. Preprocessing failed.\x1B[0m");
        exit(1);
      }
    }

    for (Token token in macroresult) {
      if (token.type == TokenType.KEYWORD) {
        if (macros.containsKey(token.value)) {
          for (Token token in macros[token.value]!) {
            result.add(token);
          }
        } else {
          result.add(token);
        }
      } else {
        result.add(token);
      }
    }
    return result;
  }
}
