

import 'package:flutter/material.dart';
import 'package:flutter_app_proyecto_flutter/aprendiendo.dart';
import 'package:flutter_app_proyecto_flutter/transiciones.dart';

import 'coloreando.dart';
import 'fotos.dart';
import 'jugando.dart';
import 'musicas.dart';
import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';


class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  List muestreoOpciones=[false,false,false,false,false];
  FlutterTts fluttertts = FlutterTts();
  bool cambioInterfaz=false;
  Timer timer;
  @override
  List oraciones;
  void dispose() {
    // TODO: implement dispose
    print("dispose");
    setState(() {
      //timer.cancel();
    });
    super.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    ("inicia estado");
    mostrarOpciones();
  }
  void mostrarOpciones(){
    oraciones=[
      "Bienvenido, selecciona las opciones para divertirte aprendiendo",
      "Aprende observando animales, escucha sus sonidos, escucha sus nombres",
      "Aprende tomando fotos y descubre que animal es",
      "Aprende coloreando animales",
      "Aprende escuchando musicas",
      "Aprende jugando"
    ];
    muestreoOpciones=[false,false,false,false,false];
    cambioInterfaz=false;
    print("mostrar opciones");
    speak(oraciones[0]);
    listadoDeOpciones();
    //Solo cuando se a dado un pop al elemento en navegacion el timer es destruido
    timer=Timer.periodic(Duration(seconds: 70), (timer) {//cuando eliminar un timer este ejecuta su ultimo loop, y si vas a cambiar algun valor booleano pensando que ya lo eliminaste y no lo tomara en cuenta estas mal poque si lo tomara en cuenta y puede haber dos timers hasta que el primer timer eliminado termine su ultimo loop
      setState(() {
        //speak("elige una de las opciones");
        listadoDeOpciones();
      });
    });
  }
  listadoDeOpciones(){
    (cambioInterfaz)?print('timer1'):describeOpcion(7,4,0,1);
    (cambioInterfaz)?print('timer1'):describeOpcion(14,0,1,2);
    (cambioInterfaz)?print('timer1'):describeOpcion(21,1,2,3);
    (cambioInterfaz)?print('timer1'):describeOpcion(28,2,3,4);
    (cambioInterfaz)?print('timer1'):describeOpcion(35,3,4,5);
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
    await fluttertts.setPitch(0.8);
    await fluttertts.setLanguage("es-US");
    await fluttertts.setSpeechRate(1.0);
    await fluttertts.setVolume(0.2);
    await fluttertts.speak(mensaje);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/nf.jpg'),
          fit: BoxFit.cover
        ),
        color: Colors.blue,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top:30),
                width: 340,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/animales_granja.jpg")
                  )
                ),
                child: Container(
                  width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/pasto.jpg")
                      )
                    ),
                    child: Text("WAWA LEARNING",style: TextStyle(fontFamily: "fuente_uno", color: Colors.white,fontSize: 30),textAlign: TextAlign.center,)),
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        opcionesMenuPrincipal(0,'assets/animales_granja.jpg','APRENDE OBSERVANDO','EMPEZAR',(){
                          setState(() {
                            //timer.cancel();
                            //cambioInterfaz=true;
                          });
                          //Navigator.popAndPushNamed(context, FadeRoute(page: Aprendiendo() ))
                          Navigator.pop(context);//por ser una pila de interfaces primero es el pop y luego el push
                          Navigator.push(context,FadeRoute(page: Aprendiendo() ));//primero el push y luego el pop no sirve
                          /*.then((value){
                            setState(() {
                              cambioInterfaz=false;
                              Future.delayed(Duration(seconds: 70),(){
                                setState(() {
                                  //print("otra mostrar opciones");
                                  //mostrarOpciones();
                                });
                              });
                            });
                          });*/
                        },),
                        SizedBox(width: 5),
                        opcionesMenuPrincipal(1,'assets/img_niño_tomando_fotos.jpg','DESCUBRE TU ENTORNO','Tomar fotos',(){
                          Navigator.pop(context);
                          Navigator.push(context,FadeRoute(page: Fotos() ));
                        },),
                        /*Expanded(
                          flex: 1,
                          child: Card(
                            color:Colors.red,
                            elevation: 10,
                            child: Container(
                              height: 300,
                            ),
                          ),
                        )*/
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          opcionesMenuPrincipal(2,'assets/cmp.jpg','APRENDE COLOREANDO','Pintar',(){
                            Navigator.pop(context);
                            Navigator.push(context,FadeRoute(page: Coloreando() ));
                          },),
                          SizedBox(width: 5),
                          opcionesMenuPrincipal(3,'assets/niño_esc_mus.jpg','APRENDE ESCUCHANDO','Escuchar',(){
                            Navigator.pop(context);
                            Navigator.push(context,FadeRoute(page: Musicas() ));
                          },),
                        ]
                    ),
                    Row(
                      children:[
                        SizedBox(width: 15),
                        opcionesMenuPrincipal(4,'assets/img_aprende_jugando.jpg','APRENDE JUGANDO','Puzzles',(){
                          Navigator.pop(context);
                          Navigator.push(context,FadeRoute(page: Jugando() ));
                        },),
                      ]
                    )
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget opcionesMenuPrincipal(int numeroElemento,String ubicacion_img,String texto_card,String texto_btn,VoidCallback onPressed){
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: (muestreoOpciones[numeroElemento])?40:5,
        color: Color.fromRGBO(189, 143, 53, 0.5),
        child: AnimatedContainer(
          width: (muestreoOpciones[numeroElemento])?160:140,
          duration: Duration(milliseconds: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: (muestreoOpciones[numeroElemento])?DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/pasto.jpg")
            ):null,
            borderRadius: BorderRadius.circular(50)
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image(image: AssetImage(ubicacion_img)),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(189, 143, 53, 0.5),
                    image: (!muestreoOpciones[numeroElemento])?DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/pasto.jpg")
                  ):null
                ),
                child: Text(texto_card,style: TextStyle(color:Colors.white,fontSize: (!muestreoOpciones[numeroElemento])?15:18,fontFamily: "fuente_indie", fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
              ),
              /*Builder(
                builder: (context)=> RaisedButton(
                  onPressed: onPressed,
                  color: Colors.greenAccent,
                  child: Text(texto_btn,style:TextStyle(fontFamily: "fuente_uno")),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
