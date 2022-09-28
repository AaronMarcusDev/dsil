// ignore_for_file: non_constant_identifier_names
import 'package:dsil/token.dart';

class Compiler {
  void generate(List<Token> tokens) {
    List<String> code = [];
    List<Token> stack = [];

    bool include_iostream = false;

    code.add("#include <iostream>");
    code.add("using namespace std;");
    code.add("\nint main(int argc, char* argv[) {");
    code.add("    vector<string> stack;\n");

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
        if (value == "pop") {
          _pop();
        } else if (value == "dup") {
          _push(stack[stack.length - 1]);
        } else if (value == "swap") {
        } else if (value == "clear") {
          stack.clear();
        }
      } else {
        _push(token);
      }
    }
    code.add("    return 0;");
    code.add("}");
    for (String line in code) {
      print(line);
    }
  }
}
