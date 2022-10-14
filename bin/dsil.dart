import 'package:dsil/lexer.dart';
import 'package:dsil/preprocessor.dart';
import 'package:dsil/compiler.dart';
import "dart:io";

Lexer lexer = Lexer();
Preprocessor preprocessor = Preprocessor();
Compiler compiler = Compiler();

String program = "${File('./std.dsil').readAsStringSync()}\n";
void main(List<String> args) {
  compiler.generate(preprocessor.process(lexer.lex("test", program)));
}
