import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_app_proyecto_flutter/aprendiendo.dart';
import 'animales.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'transiciones.dart';

class Galeria extends StatefulWidget {
  String tipo;
  Galeria(this.tipo);
  @override
  _GaleriaState createState() => _GaleriaState(tipo);
}

class _GaleriaState extends State<Galeria> {
  FlutterTts fluttertts = FlutterTts();
  Timer timer;
  _GaleriaState(this.tipo);
  AudioPlayer advancePlayer;
  AudioCache audioCache;
  String tipo;
  void initState(){
    super.initState();
    advancePlayer= AudioPlayer();
    audioCache= AudioCache(fixedPlayer: advancePlayer);
    speak("Esta es la galería de los animales ${tipo}, arrastra las imágenes y presiona en los animales para aprender.");
  }
  speak(String mensaje) async{
    await fluttertts.stop();
    await fluttertts.setPitch(0.7);
    await fluttertts.setLanguage("es-US");
    await fluttertts.setSpeechRate(1.0);
    await fluttertts.setVolume(0.2);
    await fluttertts.speak(mensaje);
  }
  List animalesGranja=[
    Animales('Vaca','La vaca come pasto. Ella nos da carne y leche','assets/vaca.png','sonido_vaca.mp3'),
    Animales('Perro','El perro es el mejor amigo del hombre','assets/perro.png','sonido_perro.mp3'),
    Animales('Gato','Los gatos son mamiferos que poseen garras y colmillos','assets/gato.png','sonido_gato.mp3'),
    Animales('Gallina','Las gallinas son aves con un cuerpo cubierto de plumas','assets/gallina.png','sonido_gallina.mp3'),
    Animales('Cerdo','Los cerdos son animales domesticos muy amigables','assets/cerdo.png','sonido_cerdo.mp3'),
    Animales('Caballo','El caballo es un animal que puede correr muy rápido','assets/caballo_2.png','sonido_caballo.mp3')];
  List animalesSelva=[
    Animales('Leon','El leon es un animal carnivoro con una melena grande','assets/leon.png','sonido_leon.mp3'),
    Animales('Canguro','El canguro comen pasto y raices, tienen patas traseras fuertes lo que le permite saltar alto','assets/canguro.png','assets/sonido_canguro.mp3'),
    Animales('Hipopotamo','El hipopotamo tiene un cuerpo grande, diantes grandes y boca grande','assets/hipopotamo_2.png','assets/sonido_hipopotamo.mp3'),
    Animales('Jirafa','La jirafa es el animal mas alto del mundo, tienen cuernos, son mamiferos','assets/jirafa.png','assets/sonido_jirafa.mp3'),
    Animales('Mono','Los monos son animales mamiferos que tienen una gran inteligencia','assets/mono.png','sonido_mono.mp3'),
    Animales('Tigre','Los tigres se alimentan de carne y tienen enormes colmillos','assets/tigre_sin_fondo.png','sonido_tigre.mp3'),];
  List animalesAcuaticos=[
    Animales('Pulpo','El pulpo es un animal acuatico, invertebrados y carnivoros. Tienen ocho brazos largos','assets/pulpo.png','sonido_pulpo.mp3'),
    Animales('Tortuga','La tortuga es una animal acuatico, es un reptil. Tienen un ancho caparazon','assets/tortuga.png','assets/sonido_tortuga.mp3'),
    Animales('Delfin','Los delfines no son peces, son mamiferos marinos. Son grandes nadadores','assets/delfin.png','assets/sonido_delfin.mp3'),
    Animales('Cangrejo','Los cangrejos son crustaceos tienen un caparazon que les cubre el cuerpo','assets/cangrejo.png','assets/sonido_cangrejo.mp3'),
    Animales('Ballena','Las ballenas son los mamiferos mas grandes. Las ballenas tienen sangre caliente','assets/whale.png','assets/sonido_ballena.mp3'),];
  Map fondoGaleria={
    'de granja':'fondo_granja.jpg',
    'acuaticos':'oceano_fondo.jpg',
    'salvajes':'imagen_selva_2.jpg'
  };
  /*Map<dynamic,dynamic> nombreImagenesGranja={
    'vaca':Animales('Vaca','','assets/vaca.jpg','assets/sonido_vaca.mp3'),
    'perro':Animales('Perro','','assets/perro.jpg','assets/sonido_perro.mp3'),
    'gato':Animales('Gato','','assets/gato.jpg','assets/sonido_gato.mp3'),
    'gallina':Animales('Gallina','','assets/gallina.jpg','assets/sonido_gallina.mp3'),
    'cerdo':Animales('Cerdo','','assets/cerdo.jpg','assets/sonido_cerdo.mp3'),
    'caballo':Animales('Caballo','','assets/caballo.jpg','assets/sonido_caballo.mp3'),
  };
  Map<dynamic,dynamic> nombreImagenesSelva={
    'canguro':Animales('Canguro','','assets/canguro.jpg','assets/sonido_canguro.mp3'),
    'hipopotamo':Animales('Hipopotamo','','assets/hipopotamo.jpg','assets/sonido_hipopotamo.mp3'),
    'jirafa':Animales('Jirafa','','assets/jirafa.jpg','assets/sonido_jirafa.mp3'),
    'leon':Animales('Leon','','assets/leon.jpg','assets/sonido_leon.mp3'),
    'mono':Animales('Mono','','assets/mono.jpg','assets/sonido_mono.mp3'),
    'tigre':Animales('Tigre','','assets/tigre.jpg','assets/sonido_tigre.mp3'),
  };
  Map<dynamic,dynamic> nombreImagenesAcuaticos={
    'tortuga':Animales('Tortuga','','assets/tortuga.jpg','assets/sonido_tortuga.mp3'),
    'pulpo':Animales('Pulpo','','assets/pulpo.jpg','assets/sonido_pulpo.mp3'),
    'mono':Animales('Mono','','assets/mono.jpg','assets/sonido_mono.mp3'),
    'delfin':Animales('Delfin','','assets/delfin.jpg','assets/sonido_delfin.mp3'),
    'cangrejo':Animales('Cangrejo','','assets/cangrejo.jpg','assets/sonido_cangrejo.mp3'),
    'ballena':Animales('Ballena','','assets/ballena.jpg','assets/sonido_ballena.mp3'),
  };*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RaisedButton(
        onPressed: (){
          Navigator.pop(context);
          Navigator.push(context,FadeRoute(page: Aprendiendo() ));
        },
        child: Text('Volver'),
      ),
      appBar: AppBar(title: Text('Galeria'),),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/${fondoGaleria[tipo]}'),
            fit: BoxFit.fill,
          ),
          color: Colors.blue,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              width:double.infinity,
              height: 50,
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text('Animales ${tipo}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,fontFamily:(tipo=="de granja" || tipo=="acuaticos")?"fuente_uno":"fuente_indie",color: (tipo=="acuaticos")?Colors.blueAccent:(tipo=="salvajes")?Colors.brown:Colors.redAccent),),
            ),
            SizedBox(height: 15.0),
            CarouselSlider(
              height: 500.0,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
              items: listaWidgetsAnimales(),
            ),
          ],
        ),
      ),
    );
  }
  List listaWidgetsAnimales(){
    List <Widget>animalesWidgets=List<Widget>();
    List animales=List();
    switch(this.tipo){
      case 'de granja':
        animales=animalesGranja;
        break;
      case 'salvajes':
        animales=animalesSelva;
        break;
      case 'acuaticos':
        animales=animalesAcuaticos;
        break;
    }
    for(Animales a in animales){
      animalesWidgets.add(
        Column(
          children: [
            Container(
              child: Text(a.nombre,style: TextStyle(fontFamily: "fuente_indie", fontSize: 30,color:(tipo=="acuaticos")?Colors.white:Colors.brown,fontWeight:FontWeight.w800),),
              color: Colors.transparent,
            ),
            GestureDetector(
              onTap: (){
                print('Ontap='+a.sonido);
                audioCache.play(a.sonido);
                Future.delayed(Duration(milliseconds: 2000),(){
                  setState(() {
                    advancePlayer.stop();
                    speak(a.descripcion);
                  });
                  print("speak ${a.descripcion}");
                });
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                height: 200,
                child: Image(
                  image: AssetImage(a.imagen),
                  fit: BoxFit.fill,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                /*child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Usable Flower for Health',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Lorem Ipsum is simply dummy text use for printing and type script',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),*/
              ),
            ),
          ],
        ),
      );
    }
    return animalesWidgets;
  }
}

/*class Galeria extends StatelessWidget {
  AudioPlayer advancePlayer= AudioPlayer();;
  AudioCache audioCache= AudioCache(fixedPlayer: advancePlayer);
  String tipo;
  Galeria(this.tipo);
  List animalesGranja=[Animales('Vaca','','assets/vaca.jpg','assets/sonido_vaca.mp3'),Animales('Perro','','assets/perro.jpg','assets/sonido_perro.mp3'),Animales('Gato','','assets/gato.jpg','assets/sonido_gato.mp3'),Animales('Gallina','','assets/gallina.jpg','assets/sonido_gallina.mp3'),Animales('Cerdo','','assets/cerdo.jpg','assets/sonido_cerdo.mp3'),Animales('Caballo','','assets/caballo.jpg','assets/sonido_caballo.mp3')];
  List animalesSelva=[
    Animales('Leon','','assets/leon.jpg','assets/sonido_leon.mp3'),
    Animales('Canguro','','assets/canguro.jpg','assets/sonido_canguro.mp3'), Animales('Hipopotamo','','assets/hipopotamo.jpg','assets/sonido_hipopotamo.mp3'),
    Animales('Jirafa','','assets/jirafa.jpg','assets/sonido_jirafa.mp3'),
    Animales('Leon','','assets/leon.jpg','assets/sonido_leon.mp3'),
    Animales('Mono','','assets/mono.jpg','assets/sonido_mono.mp3'),
    Animales('Tigre','','assets/tigre.png','assets/sonido_tigre.mp3'),];
  List animalesAcuaticos=[
    Animales('Pulpo','','assets/pulpo.jpg','assets/sonido_pulpo.mp3'),
    Animales('Tortuga','','assets/tortuga.jpg','assets/sonido_tortuga.mp3'),
    Animales('Delfin','','assets/delfin.jpg','assets/sonido_delfin.mp3'),
    Animales('Cangrejo','','assets/cangrejo.jpg','assets/sonido_cangrejo.mp3'),
    Animales('Ballena','','assets/ballena.jpg','assets/sonido_ballena.mp3'),];
  Map fondoGaleria={
    'granja':'granja_fondo.jpg',
    'acuaticos':'oceano_fondo.jpg',
    'salvajes':'selva_fondo.jpg'
  };
  /*Map<dynamic,dynamic> nombreImagenesGranja={
    'vaca':Animales('Vaca','','assets/vaca.jpg','assets/sonido_vaca.mp3'),
    'perro':Animales('Perro','','assets/perro.jpg','assets/sonido_perro.mp3'),
    'gato':Animales('Gato','','assets/gato.jpg','assets/sonido_gato.mp3'),
    'gallina':Animales('Gallina','','assets/gallina.jpg','assets/sonido_gallina.mp3'),
    'cerdo':Animales('Cerdo','','assets/cerdo.jpg','assets/sonido_cerdo.mp3'),
    'caballo':Animales('Caballo','','assets/caballo.jpg','assets/sonido_caballo.mp3'),
  };
  Map<dynamic,dynamic> nombreImagenesSelva={
    'canguro':Animales('Canguro','','assets/canguro.jpg','assets/sonido_canguro.mp3'),
    'hipopotamo':Animales('Hipopotamo','','assets/hipopotamo.jpg','assets/sonido_hipopotamo.mp3'),
    'jirafa':Animales('Jirafa','','assets/jirafa.jpg','assets/sonido_jirafa.mp3'),
    'leon':Animales('Leon','','assets/leon.jpg','assets/sonido_leon.mp3'),
    'mono':Animales('Mono','','assets/mono.jpg','assets/sonido_mono.mp3'),
    'tigre':Animales('Tigre','','assets/tigre.jpg','assets/sonido_tigre.mp3'),
  };
  Map<dynamic,dynamic> nombreImagenesAcuaticos={
    'tortuga':Animales('Tortuga','','assets/tortuga.jpg','assets/sonido_tortuga.mp3'),
    'pulpo':Animales('Pulpo','','assets/pulpo.jpg','assets/sonido_pulpo.mp3'),
    'mono':Animales('Mono','','assets/mono.jpg','assets/sonido_mono.mp3'),
    'delfin':Animales('Delfin','','assets/delfin.jpg','assets/sonido_delfin.mp3'),
    'cangrejo':Animales('Cangrejo','','assets/cangrejo.jpg','assets/sonido_cangrejo.mp3'),
    'ballena':Animales('Ballena','','assets/ballena.jpg','assets/sonido_ballena.mp3'),
  };*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Galeria'),),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/${fondoGaleria[tipo]}'),
            fit: BoxFit.fill,
          ),
          color: Colors.blue,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              width:double.infinity,
              height: 50,
              alignment: Alignment.center,
              child: Text('ANIMALES DE GRANJA',style: TextStyle(fontSize: 25),),
            ),
            SizedBox(height: 15.0),
            CarouselSlider(
              height: 500.0,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 1.0,
              items: listaWidgetsAnimales(),
            ),
          ],
        ),
      ),
    );
  }
  List listaWidgetsAnimales(){
    List <Widget>animalesWidgets=List<Widget>();
    List animales=List();
    switch(this.tipo){
      case 'granja':
        animales=animalesGranja;
        break;
      case 'salvajes':
        animales=animalesSelva;
        break;
      case 'acuaticos':
        animales=animalesAcuaticos;
        break;
    }
    for(Animales a in animales){
      animalesWidgets.add(
        Column(
          children: [
            Container(
              child: Text(a.nombre),
              color: Colors.amber,
            ),
            GestureDetector(
              onTap: (){
                audioCache.play(a.sonido);
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: Image(
                  image: AssetImage(a.imagen),
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                /*child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Usable Flower for Health',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Lorem Ipsum is simply dummy text use for printing and type script',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),*/
              ),
            ),
          ],
        ),
      );
    }
    return animalesWidgets;
  }
}
*/

/*class Galeria extends StatefulWidget {
  String opcion;
  Galeria(this.opcion);
  @override
  _GaleriaState createState() => _GaleriaState(opcion);
}

class _GaleriaState extends State<Galeria> {
  String opcion;
  _GaleriaState(this.opcion);
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: AnimalGaleria('gallina'),
        nextScreen: AnimalGaleria('vaca'),
        splashTransition: SplashTransition.fadeTransition,
        duration: 1000,
    );
  }
}
class AnimalGaleria extends StatefulWidget {
  String nombre;
  AnimalGaleria(this.nombre);
  @override
  _AnimalGaleriaState createState() => _AnimalGaleriaState(nombre);
}

class _AnimalGaleriaState extends State<AnimalGaleria> {
  String nombre;
  _AnimalGaleriaState(this.nombre);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Trasiciones")),
      body: Container(
        child: Center(child: Text(nombre)),
      ),
    );
  }
}

/*class AnimalGaleria extends StatelessWidget {
  String nombre;
  AnimalGaleria(this.nombre);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Trasiciones")),
      body: Container(
        child: Center(child: Text(nombre)),
      ),
    );
  }
}
*/
*/