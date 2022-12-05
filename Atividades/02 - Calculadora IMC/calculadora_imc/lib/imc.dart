imcCalc(peso, altura) {
  double calc = peso / (altura * altura);
  String? imc;

  if (calc < 18.6) {
    imc = ' IMC: ${calc.toStringAsPrecision(3)} \n Situação: Abaixo do Peso ';
  } else if (calc >= 18.6 && calc < 24.9) {
    imc = ' IMC: ${calc.toStringAsPrecision(3)} \n Situação: Peso Ideal ';
  } else if (calc >= 24.9 && calc < 29.9) {
    imc = ' IMC: ${calc.toStringAsPrecision(3)} \n Situação: Levemente Acima do Peso';
  } else if (calc >= 29.9 && calc < 34.9) {
    imc = ' IMC: ${calc.toStringAsPrecision(3)} \n Situação: Obesidade Grau I';
  } else if (calc >= 34.9 && calc < 39.9) {
    imc = ' IMC: ${calc.toStringAsPrecision(3)} \n Situação: Obesidade Grau II';
  } else if (calc >= 40) {
    imc = ' IMC: ${calc.toStringAsPrecision(3)} \n Situação: Obesidade Grau III';
  }

  return imc;
}
