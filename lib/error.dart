class ErrorReporter {
  void error(file, line, message) {
    print("\x1B[31m[ERROR] $file:$line, $message\x1B[0m");
  }

  void emptyStack(file, line, command) {
    print(
        "\x1B[31m[ERROR] $file:$line, Cannot issue `$command` command. Stack is empty.\x1B[0m");
  }

  void tooLittleStackItems(file, line, command) {
    print(
        "\x1B[31m[ERROR] $file:$line, Cannot issue `$command` command. Stack has too little items.\x1B[0m");
  }
}
