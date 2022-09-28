import 'package:dsil/lexer.dart';
import 'package:dsil/token.dart';
import 'package:dsil/preprocessor.dart';
import 'package:dsil/compiler.dart';
import "dart:io";

Lexer lexer = Lexer();
Preprocessor preprocessor = Preprocessor();
Compiler compiler = Compiler();

String program = """

"Hello, world!" puts

""";
void main(List<String> args) {
  compiler.generate(lexer.lex("test", program));
}
