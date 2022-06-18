import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_proyecto_flutter/reproductor.dart';

import '1menu_principal.dart';
import 'transiciones.dart';
class Musicas extends StatefulWidget {
  @override
  _MusicasState createState() => _MusicasState();
}

class _MusicasState extends State<Musicas> {
  @override
  double w=0,h=0;
  bool flag=false;
  List listaMusicas=[
    ['assets/animales_granja.jpg','Musica: "Animales"','animales_granja.mp3'],
    ['assets/gallina.jpg','Musica: "Sonidos de animales"','cancion_2.m4a'],
    ['assets/perro.jpg','Musica: "Cancion de animales"','cancion_3.m4a'],
    ['assets/niño_esc_mus.jpg','Musica: "Cancion 2"','cancion_4.m4a'],
    ['assets/animales_granja.jpg','Musica: "Animales"','animales_granja.mp3'],

  ];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Musicas'),
          actions: [
            IconButton(icon: Icon(Icons.arrow_back,size: 40,), onPressed: (){
              Navigator.pop(context);
              Navigator.push(context,FadeRoute(page: MenuPrincipal() ));//primero el push y luego el pop no sirve
            }),
            SizedBox(width: 20,),
          ],
        ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/fondo_naturaleza_musicas.jpg"),
          )
        ),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context,pos){
                    return opcionMusica(listaMusicas[pos][0],listaMusicas[pos][1],listaMusicas[pos][2]);
                  }
              ),
            ),
            AnimatedContainer(
              color: Color.fromRGBO(105,240,174,0.25),
              width: double.infinity,
              height: h,
              duration: Duration(milliseconds: 1000),
              child: r
            ),
          ],
        ),
      )
    );
  }
  String nombreMs;
  Reproductor r;
  Widget opcionMusica(String rutaImagen,String nombre,String nombreMusica){
    return GestureDetector(
      onTap: (){
        setState(() {
          flag=!flag;
          w=300;
          h=300;
          print(nombreMusica);
          //print("gestureDetector"+nombreMs);
          r=Reproductor(nombreMusica);
          //r.musica=nombreMusica;
          //nombreMs=nombreMusica;
        });
        //Navigator.push(context, MaterialPageRoute(builder: (context) => Elegido(pos)));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(40, 196, 255, 0.2),
        ),
        child: Row(
            children:[
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.only(right: 20),
                child: Image(
                  image: AssetImage(rutaImagen),
                ),
              ),
              Container(
                width: 150,
                  child: Text('${nombre}',style: TextStyle(fontFamily: "fuente_dos"),)
              )
            ]
        ),
      ),
    );
  }
}
