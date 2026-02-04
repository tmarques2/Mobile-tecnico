// comentario por barra barra
// blabla

//comece o codigo importando a biblioteca
import "dart:io";

//precisa da função principal
void main() {
  print("Olar");
  print("ds18");
  //stdout coloca o proximo comando na frente do anterior
  stdout.write("Olar");
  stdout.write(" ds18");
  print("");

  print("Insira o seu nome Champion: ");
  String? nome = stdin.readLineSync(); //como naosei se o usuario vai digitar
  //a variavel pode ser nula
  //a segunda forma é dizer que a varivel precisa ter dados
  // String nome = stdin.readLineSync()!;
  print("Olá champion $nome");
}
