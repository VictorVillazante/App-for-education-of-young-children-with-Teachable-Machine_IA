import 'package:flutter/material.dart';
import 'dart:async';

  import 'package:flutter_tts/flutter_tts.dart';
class IdentificaElAnimal extends StatefulWidget {
  @override
  _IdentificaElAnimalState createState() => _IdentificaElAnimalState();
}

class _IdentificaElAnimalState extends State<IdentificaElAnimal> {
  @override
  FlutterTts fluttertts = FlutterTts();
  speak(String mensaje) async{
    await fluttertts.setPitch(0.8);
    await fluttertts.setLanguage("es-US");
    await fluttertts.setSpeechRate(1.0);
    await fluttertts.setVolume(0.2);
    await fluttertts.speak(mensaje);
  }
  bool comienzaJuego=false;
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          (!comienzaJuego)?RaisedButton(
            onPressed: (){
              speak("Bienvenido, este juego consiste en elegir a que animal corresponde la siguiente descripción");
              Future.delayed(Duration(seconds: 8),(){
                speak("Bien ahora dime, cual es el ${elementoCorrecto}");
              });
              setState(() {
                comienzaJuego=true;
              });
              comienzaGuia();
            },
            child: Text("Empezar juego"),
          ):RaisedButton(
            onPressed: (){

            },
            color: (mostrarElemento)?Colors.blue:Colors.greenAccent,
            child: Text("Siguiente",style: TextStyle(color: (mostrarElemento)?Colors.white:Colors.black),),
          )
        ]
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/fondo_identifica_animal.jpg')
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Bienvenido, que animal es este"),
                  width: 200,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    opcionEleccion("leon.jpg"),
                    SizedBox(width: 10,),
                    opcionEleccion("perro.jpg")
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String elementoCorrecto="leon";
  bool mostrarElemento=false;
  opcionEleccion(String imagen) {
    return GestureDetector(
      onTap: (){
        if(elementoCorrecto+".jpg"==imagen){
          speak("felicidades el animal que elegista es el correcto, este es el ${elementoCorrecto}");
          mostrarPuntuacion();
        }
      },
      child: Container(
        width: 120,
        height: 120,
        child: Image(
            fit: BoxFit.cover,
            image: AssetImage("assets/${imagen}")
        ),
      ),
    );
  }

  void mostrarPuntuacion() {
    print("winner");
  }
  Timer guia;
  bool finalGuia=false;
  void comienzaGuia() {
    guia=Timer.periodic(Duration(seconds: 25), (timer) {
      (finalGuia)?guia.cancel()://El timer.cancel tiene que estar adentro del timer y si esta al inicio permite no repetir mas el timer asi sea el ultimo
      speak("recuerda presiona este boton para pasar a la siguiente pregunta");
    });
    guia=Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        (finalGuia)?guia.cancel():
        mostrarElemento=!mostrarElemento;
      });
    });
  }
  void dispose(){
    guia.cancel();
    finalGuia=true;
    print("dispose elegir animal");
    super.dispose();
  }
}
