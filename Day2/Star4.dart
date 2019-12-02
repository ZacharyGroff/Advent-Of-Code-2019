import 'dart:convert';
import 'dart:io';

const ADD = 1;
const MULTIPLY = 2;
const STOP = 99;
const LOWER_BOUND = 0;
const UPPER_BOUND = 99;
const DESIRED_OUTPUT = 19690720;

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

List<int> restoreGravityAssistProgram(List<int> opCodes, input1, input2) {
  opCodes[1] = input1;
  opCodes[2] = input2;

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

List<int> getRequiredInputs() {
  var opCodes = getOpCodes();

  for (var input1 = LOWER_BOUND; input1 <= UPPER_BOUND; input1++) {
    for (var input2 = LOWER_BOUND; input2 <= UPPER_BOUND; input2++) {
      var newOpCodes = List<int>.from(opCodes);
      var restoredOpCodes = restoreGravityAssistProgram(newOpCodes, input1, input2);
      var processedOpCodes = processOpCodes(restoredOpCodes);

      var result = processedOpCodes[0];
      if (result == DESIRED_OUTPUT) {
        return [input1, input2];
      }
    }
  }

  return [0, 0];
}

int calculateResult(int noun, int verb) {
  return 100 * noun + verb;
}

void main() {
  var inputs = getRequiredInputs();
  var result = calculateResult(inputs[0], inputs[1]);
  print("Final Result: " + result.toString());
}
