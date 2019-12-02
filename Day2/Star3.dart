import 'dart:convert';
import 'dart:io';

const ADD = 1;
const MULTIPLY = 2;
const STOP = 99;

String getRawOpCodeLine() {
  var encoding = Encoding.getByName('utf-8');
  return stdin.readLineSync(encoding: encoding);
}

List<int> parseOpCodes(String input) {
  var stringInput = input.split(',');
  return stringInput.map(int.parse).toList();
}

List<int> getOpCodes() {
  var rawOpCodes = getRawOpCodeLine();
  return parseOpCodes(rawOpCodes);
}

List<int> restoreGravityAssistProgram(List<int> opCodes) {
  opCodes[1] = 12;
  opCodes[2] = 2;

  return opCodes;
}

List<int> processOpCodes(List<int> opCodes) {
  for (int i = 0; i < opCodes.length; i += 4) {
    var opCode = opCodes[i];
    if (opCode == ADD) {
      opCodes[opCodes[i+3]] = opCodes[opCodes[i+1]] + opCodes[opCodes[i+2]];
    } else if (opCode == MULTIPLY) {
      opCodes[opCodes[i+3]] = opCodes[opCodes[i+1]] * opCodes[opCodes[i+2]];
    } else if (opCode == STOP) {
      break;
    } else {
      print("Unexpected opcode");
    }
  }

  return opCodes;
}

void main() {
  var opCodes = getOpCodes();
  var restoredOpCodes = restoreGravityAssistProgram(opCodes);
  var processedOpCodes = processOpCodes(restoredOpCodes);
  var result = processedOpCodes[0].toString();
  print("Final result: " + result);
}
