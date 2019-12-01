import 'dart:convert';
import 'dart:io';

List<int> getLinesOfMass() {
  List<int> lines = new List();
  var encoding = Encoding.getByName('utf-8');

  while (true){
    var line = stdin.readLineSync(encoding: encoding);
    if (line == null) {
      break;
    } else {
      var lineAsInt = int.parse(line);
      lines.add(lineAsInt);
    }
  }

  return lines;
}

int calculateFuel(int mass) {
  return (mass / 3).floor() - 2;
}

int getFuelRequired(List<int> linesOfMass) {
  var totalMass = 0;
  for (final mass in linesOfMass) {
    totalMass += calculateFuel(mass);
  }

  return totalMass;
}

void main() {
  var linesOfMass = getLinesOfMass();
  var fuelRequired = getFuelRequired(linesOfMass);
  print("Fuel Required: " + fuelRequired.toString());
}

