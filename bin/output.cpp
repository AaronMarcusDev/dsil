#include <iostream>
#include <vector>
using namespace std;

int main(int argc, char* argv[]) {
    vector<string> stack;
// push
    stack.push_back("34");
// push
    stack.push_back("35");
// push
    stack.push_back("Tokens.PLUS");
// puts
    cout << stack.back() << endl;
    stack.pop_back();
    return 0;
}