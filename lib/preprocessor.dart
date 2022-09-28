import 'package:dsil/token.dart';
import 'package:dsil/error.dart';
import 'dart:io';

ErrorReporter report = ErrorReporter();

class Preprocessor {
  process(List<Token> tokens) {
    List<Token> stack = [];
    int errors = 0;

    _pop() => stack.removeLast();
    _push(Token token) => stack.add(token);

    for (int i = 0; i < tokens.length; i++) {
      TokenType type = tokens[i].type;
      dynamic value = tokens[i].value;
      String file = tokens[i].file;
      int line = tokens[i].line;

      if (type == TokenType.KEYWORD) {
        if (value == 'pop') {
          _pop();
        } else if (value == 'dup') {
          _push(stack[stack.length - 1]);
        } else if (value == "con") {
          _push(Token(file, TokenType.STRING, line, tokens[i].pos,
              "${_pop().value}${_pop().value}"));
        } else if (value == "clear") {
          stack.clear();
        } else if (type == TokenType.STRING) {
          _push(tokens[i]);
        }
      }
      for (var item in stack) {
        print(item.value);
      }
      if (errors > 0) {
        print(
            "\x1B[34m[INFO] $errors error(s) found. Preprocessing failed.\x1B[0m");
        exit(1);
      }
    }
  }
}
