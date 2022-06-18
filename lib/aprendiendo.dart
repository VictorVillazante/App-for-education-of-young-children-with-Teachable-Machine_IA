import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_proyecto_flutter/1menu_principal.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'galeria.dart';
import 'transiciones.dart';
class Aprendiendo extends StatefulWidget {
  @override
  _AprendiendoState createState() => _AprendiendoState();
}

class _AprendiendoState extends State<Aprendiendo> {
  List muestreoOpciones=[false,false,false,false,false];
  FlutterTts fluttertts;
  bool cambioInterfaz=false;
  Timer timer;
  List oraciones;
  void dispose() {
    // TODO: implement dispose
    /*setState(() {
      timer.cancel();
    });*/
    super.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    print("inicia estado");
    mostrarOpciones();
  }
  void mostrarOpciones(){
    fluttertts = FlutterTts();
    oraciones=[
      "Bienvenido selecciona un tipo de animal",
      " Estos son los animales de granja ",
      " Estos son los animales salvajes",
      " Estos son animales acuaticos ",
    ];
    muestreoOpciones=[false,false,false];
    cambioInterfaz=false;
    print("mostrar opciones");
    speak(oraciones[0]);
    listadoDeOpciones();
    timer=Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        speak("elige una de las opciones");
        listadoDeOpciones();
      });
    });
  }
  listadoDeOpciones(){
    (cambioInterfaz)?null:describeOpcion(7,2,0,1);
    (cambioInterfaz)?null:describeOpcion(14,0,1,2);
    (cambioInterfaz)?null:describeOpcion(21,1,2,3);
  }
  describeOpcion(int segundos,int elementoUltimo, int elementoNuevo,int numOracion){
    Future.delayed(Duration(seconds: segundos),(){
      setState(() {
        muestreoOpciones[elementoUltimo]=false;
        muestreoOpciones[elementoNuevo]=true;
      });
      (cambioInterfaz)?null:speak(oraciones[numOracion]);
      //print(muestreoOpciones[0]);
    });
  }
  speak(String mensaje) async{
    await fluttertts.setPitch(0.7);
    await fluttertts.setLanguage("es-US");
    await fluttertts.setSpeechRate(1.0);
    await fluttertts.setVolume(0.2);
    await fluttertts.speak(mensaje);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aprendiendo'),
      ),
      floatingActionButton: RaisedButton(
        onPressed: (){
          Navigator.pop(context);
          Navigator.push(context,FadeRoute(page: MenuPrincipal() ));
        },
        child: Text('Volver'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/fondo_eleccion_tipo_animal.jpg")
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              opcionMenu(1,'assets/animales_granja.jpg','Animales de granja',(){
                setState(() {
                  //timer.cancel();
                  cambioInterfaz=true;
                });
                Navigator.pop(context);
                Navigator.push(context,FadeRoute(page: Galeria('de granja') )).then((value){
                  setState(() {
                    cambioInterfaz=false;
                    Future.delayed(Duration(seconds: 21),(){
                      setState(() {
                        print("otra mostrar opciones");
                        //mostrarOpciones();
                      });
                    });
                  });
                });
              }),
              SizedBox(height: 10,),
              opcionMenu(2,'assets/animales_salvajes.jpg','Animales salvajes',(){
                Navigator.pop(context);
                Navigator.push(context,FadeRoute(page: Galeria('salvajes') ));
              }),
              SizedBox(height: 10,),
              opcionMenu(3,'assets/animales_acuaticos.jpg','Animales acuaticos',(){
                Navigator.pop(context);
                Navigator.push(context,FadeRoute(page: Galeria('acuaticos') ));
              }),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
  GestureDetector opcionMenu(int elemento,String imagen,String titulo,VoidCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 20,
        child: Container(
          height: 60,
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.blue,
                  height: 150,
                  child: Image(
                    image: AssetImage(imagen),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1),
                  height: 160,
                  color: (muestreoOpciones[elemento-1])?Colors.blueAccent:Color.fromRGBO(82, 177, 255, 0.3    ),
                  alignment: Alignment.center,
                  child: Text(titulo,style: TextStyle(color:(muestreoOpciones[elemento-1])?Colors.white:Colors.black ),),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
