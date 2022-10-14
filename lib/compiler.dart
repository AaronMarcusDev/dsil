// ignore_for_file: non_constant_identifier_names
import 'dart:io';
import 'package:dsil/token.dart';

class Compiler {
  void generate(List<Token> tokens) {
    List<String> code = [];

    bool include_iostream = false;

    code.add("#include <iostream>");
    code.add("#include <vector>");
    code.add("using namespace std;");
    code.add("\nint main(int argc, char* argv[]) {");
    code.add("    vector<string> stack;");

    for (Token token in tokens) {
      _pop() => code.add("    stack.pop_back();");
      _push(Token token) =>
          code.add("    stack.push_back(\"${token.value}\");");

      TokenType type = token.type;
      dynamic value = token.value;
      String file = token.file;
      int line = token.line;
      int pos = token.pos;

      if (type == TokenType.KEYWORD) {
      } else if (type == TokenType.OPERATOR) {
        if (value == Tokens.PLUS) {
          code.add("// plus");
          code.add("    int a = stoi(stack.back());");
          code.add("    stack.pop_back();");
          code.add("    int b = stoi(stack.back());");
          code.add("    stack.pop_back();");
          code.add("    stack.push_back(to_string(a + b));");
        } else if (value == Tokens.MINUS) {
          code.add("// minus");
          code.add("    int a = stoi(stack.back());");
          code.add("    stack.pop_back();");
          code.add("    int b = stoi(stack.back());");
          code.add("    stack.pop_back();");
          code.add("    stack.push_back(to_string(b - a));");
        } else if (value == Tokens.STAR) {
          code.add("// star / times");
          code.add("    int a = stoi(stack.back());");
          code.add("    stack.pop_back();");
          code.add("    int b = stoi(stack.back());");
          code.add("    stack.pop_back();");
          code.add("    stack.push_back(to_string(a * b));");
        } else if (value == Tokens.SLASH) {
          code.add("// slash / divide");
          code.add("    int a = stoi(stack.back());");
          code.add("    stack.pop_back();");
          code.add("    int b = stoi(stack.back());");
          code.add("    stack.pop_back();");
          code.add("    stack.push_back(to_string(b / a));");
        }
      } else if (type == TokenType.LANGUAGE) {
      } else if (type == TokenType.RAW_STRING) {
        code.add(value);
      } else {
        code.add("// push");
        _push(token);
      }
    }
    code.add("    return 0;");
    code.add("}");
    File("output.cpp").writeAsStringSync(code.join("\n"));
  }
}
