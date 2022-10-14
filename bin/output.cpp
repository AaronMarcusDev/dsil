#include <iostream>
#include <vector>
using namespace std;

int main(int argc, char* argv[]) {
    vector<string> stack;
// push
    stack.push_back("34");
// push
    stack.push_back("1");
// slash / divide
    int a = stoi(stack.back());
    stack.pop_back();
    int b = stoi(stack.back());
    stack.pop_back();
    stack.push_back(to_string(b / a));
// puts
    cout << stack.back() << endl;
    stack.pop_back();
    return 0;
}