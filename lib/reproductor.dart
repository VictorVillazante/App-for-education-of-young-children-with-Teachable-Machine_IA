import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
class Reproductor extends StatefulWidget {
  @override
  String musica="";
  Reproductor(String musica){
    this.musica=musica;
    print("constructor"+musica);
    print("this"+this.musica);

  }
  set musicas(String musica){
    print("set"+musica);
    this.musica=musica;
  }
  _ReproductorState createState() => _ReproductorState();
}

class _ReproductorState extends State<Reproductor> {
  Duration _duration=Duration();//estas lineas de codigo solo definen una vez
  Duration _position=Duration();
  AudioPlayer advancePlayer;
  AudioCache audioCache;
  String audioName;
  final musicName="animales de la granja";
  final imageName="animales.jpg";
  double volumen=1,currentVolumen=0;
  /*_ReproductorState(String nombre){
    this._audioName=nombre;
    print(this._audioName);
  }*/
  void initState(){
    super.initState();
    audioName=this.widget.musica;//define al inicio el valor
    print(audioName);
    initPlayer();
  }
  void initPlayer(){
    advancePlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancePlayer);
    advancePlayer.durationHandler = (d) => setState((){
      _duration = d;
    });

    advancePlayer.positionHandler = (p) => setState((){
      _position = p;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:listaControlMusica(),
              ),
            ),
            Container(
              width: double.infinity,
              height: 120,
              child: Image(
                image: AssetImage('assets/animales.jpg'),
              ),
            ),
            Slider(
              activeColor: Colors.yellowAccent,
              value: _position.inSeconds.toDouble(),
              max: _duration.inSeconds.toDouble(),
              onChanged: (double segundosActuales){
                setState(() {
                  advancePlayer.seek(Duration(seconds: segundosActuales.toInt()));
                });
              },
            )
          ]
      ),
    );
  }
  List <Widget> listaControlMusica(){
    return [
      iconoParaMusica(Icons.play_arrow, Colors.teal, (){
        print(audioName);
        audioCache.play(this.widget.musica);//Llamando a atributos de la anterior clase podemos recibir el valor de un atributo modificado
      }),
      iconoParaMusica(Icons.stop, Colors.redAccent, () {
        advancePlayer.stop();
      }),
      iconoParaMusica(Icons.pause, Colors.redAccent, () {
        advancePlayer.pause();
      }),
      iconoParaMusica(Icons.volume_up, Colors.teal, () {
        if(volumen<1){
          volumen+=0.1;
          advancePlayer.setVolume(volumen);
        }
      }),
      iconoParaMusica(Icons.volume_down, Colors.teal, () {
        if(volumen!=0){
          volumen-=0.1;
          advancePlayer.setVolume(volumen);
        }
      }),
      iconoParaMusica(Icons.volume_off, Colors.redAccent, () {
        if(volumen!=0){
          currentVolumen=volumen;
          volumen=0;
        }
        else{
          volumen=currentVolumen;
        }
        advancePlayer.setVolume(volumen);
      })
    ];
  }
  IconButton iconoParaMusica(IconData icono,Color color, VoidCallback onPressed){
    return IconButton(
        icon:Icon(icono),
        iconSize: 32,
        color:color,
        onPressed: onPressed
    );
  }

}
