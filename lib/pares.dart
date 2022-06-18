import 'dart:async';
import 'dart:math';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:flutter/material.dart';
class Pares extends StatefulWidget {
  @override
  _ParesState createState() => _ParesState();
}

class _ParesState extends State<Pares> {
  @override
  initState(){
    // TODO: implement initState
    //_initialValues();
    super.initState();
    print("define cartas delanteras");
    definirCartasDelanteras();
    definirPosiciones();
    definirImagenes();
    //Es la unica parte donde solo se define una vez y en las declaracion afuerda de los Widgets en ahi puede variar la informacion
  }
  Map datos_juego_cabezera={
    "aciertos":0,
    "puntos":0,
    "tiempo":"00:00",
  };
  Map datos_cuerpo_juego={
    "filas":2,
    "columnas":3,
    "imagenes_elegidas":["","",""],
    "elementos_mostrados":[false,false,false,false,false,false],
    "posicion_pares":[],
    "lista_cartas_delanteras":[],
    "numero_elementos":6
  };
  Timer timer;
  bool habilitarJuego=false;
  int minuto=1;
  int segundo=0;
  String tiempo="00:00";
  empezarCronometro(){
    timer=Timer.periodic(Duration(seconds: 1), (timer) {//cuando eliminar un timer este ejecuta su ultimo loop, y si vas a cambiar algun valor booleano pensando que ya lo eliminaste y no lo tomara en cuenta estas mal poque si lo tomara en cuenta y puede haber dos timers hasta que el primer timer eliminado termine su ultimo loop
      setState(() {
        if(segundo==0 && reset){
          minuto--;
          segundo+=59;
        }else{
          minuto=5;
        }
        (!reset)?segundo--:segundo=59;
        datos_juego_cabezera["tiempo"]="0"+minuto.toString()+":"+((segundo<10)?"0"+segundo.toString():segundo.toString());
        if(segundo==0 && minuto==0){
          //timer.cancel();
          String informacionVictoria=calcularPuntos();
          mostrarMensajeVictoriaPasarSiguienteRonda(informacionVictoria);
          print("Tiempo finalizado respuesta final");
        }
      });
    });
  }
  int elementosVistos=0;
  bool empezarJuego=false;
  int numeroRonda=0;
  List datos_cuerpo_ronda=[
    {
      "filas":2,
      "columnas":3,
      "imagenes_elegidas":["","",""],
      "elementos_mostrados":[false,false,false,false,false,false],
      "posicion_pares":[],
      "lista_cartas_delanteras":[],
      "numero_elementos":6
    },
    {
      "filas":3,
      "columnas":4,
      "imagenes_elegidas":["","","","","","","","","","","",""],
      "elementos_mostrados":[false,false,false,false,false,false,false,false,false,false,false,false],
      "posicion_pares":[],
      "lista_cartas_delanteras":[],
      "numero_elementos":12
    },
    {
      "filas":4,
      "columnas":6,
      "imagenes_elegidas":["","","","","","","","","","","","","","","","","","","","","","","",""],
      "elementos_mostrados":[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
      "posicion_pares":[],
      "lista_cartas_delanteras":[],
      "numero_elementos":24
    }
  ];
  List rutas_imagenes=["animales.jpg","animales_acuaticos.jpg","animales_granja.jpg","animales_salvajes.jpg","ballena.jpg","caballo.jpg","cangrejo.jpg","canguro.jpg","cerdo.jpg","delfin.jpg","gallina.jpg","gato.jpg","hipopotamo.jpg","jirafa.jpg","leon.jpg","mono.jpg","perro.jpg","pulpo.jpg","serpiente.png","tigre.png","tortuga.jpg","vaca.jpg"];
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        children: [
          (!empezarJuego)?RaisedButton(
            child: Text("Empieza el juego"),
            onPressed: (){
              setState(() {
                print(empezarJuego);
                habilitarJuego=true;
                empezarCronometro();
                empezarJuego=true;
              });
            },
          ):RaisedButton(
            child: Text("Siguiente"),
            onPressed: (){
              setState(() {
                numeroRonda++;
                (numeroRonda>3)?numeroRonda=0:null;
                datos_cuerpo_juego=datos_cuerpo_ronda[numeroRonda];
                definirCartasDelanteras();
                definirPosiciones();
                definirImagenes();
                empezarJuego=false;
              });
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/fondo_juego_pares.jpg')
              )
            ),
          ),
          Align(
            alignment: Alignment(0,0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                datosJuego(),
                cuerpoJuego()
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget datosJuego(){
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green,width: 2.0,style: BorderStyle.solid),
        color: Color.fromRGBO(189, 143, 53, 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Aciertos"),
          campoDato(datos_juego_cabezera["aciertos"].toString()),
          Text("Puntos"),
          campoDato(datos_juego_cabezera["puntos"].toString()),
          Text("Tiempo"),
          campoDato(datos_juego_cabezera["tiempo"].toString()),
        ],
      ),
    );
  }
  Widget campoDato(String dato){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 50,
      height:40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green,
      ),
      child: Center(child: Text((dato))),
    );
  }
  Widget cuerpoJuego(){
    return cardListMethod();
  }
  Widget cardListMethod() {
    return Container(
      height: 400,
      //color: Colors.blue,
      margin: EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: datos_cuerpo_juego["columnas"],//El ancho definido antes
        childAspectRatio: (80 / 130),//Relacion ancho/alto del grid
        children: List.generate(datos_cuerpo_juego["posicion_pares"].length, (index) {
          return Center(
              child: Container(
                margin: EdgeInsets.all(.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  color: Colors.white,
                  onPressed: () => !datos_cuerpo_juego["elementos_mostrados"][index] && habilitarJuego? _onClick(index) : () {},
                  child: Container(
                    child: datos_cuerpo_juego["lista_cartas_delanteras"][index],
                    decoration: BoxDecoration(
                      image:  DecorationImage(//Aqui es encuentra la imagen de fondo del pokemon
                          image: AssetImage((habilitarJuego)?"assets/" + datos_cuerpo_juego["imagenes_elegidas"][datos_cuerpo_juego["posicion_pares"][index]]:"assets/incognita.jpg"),
                          fit: BoxFit.contain
                      )
                    ),
                  )
                ),//Se coloca la animacion que le toca ya asignada
              )
          );
        }),
      ),
    );
  }
  retornaImagen(int index) {
    Future.delayed(Duration(milliseconds: 1),(){
      return DecorationImage(//Aqui es encuentra la imagen de fondo del pokemon
          image: AssetImage("assets/" + datos_cuerpo_juego["imagenes_elegidas"][datos_cuerpo_juego["posicion_pares"][index]]),
          fit: BoxFit.contain
      );
    });
  }
  List elementosParaVerificarComunes=[];
  _onClick(int index) {//Este metodo se asegura que no haya sido procesado, si no se dio la vuelta se establece una animacion
    print("onclick");
    setState(() {
      print(index);
      datos_cuerpo_juego["lista_cartas_delanteras"][index] = elegirTipoAnimacion("card_animation_left");
      datos_cuerpo_juego["elementos_mostrados"][index] = true;
      print(datos_cuerpo_juego["elementos_mostrados"]);
      elementosParaVerificarComunes.add(index);
      elementosVistos++;
    });
    if(elementosVistos==2){
      setState(() {
        elementosVistos=0;
      });
      print(datos_cuerpo_juego["elementos_mostrados"]);
      print("elementos vistos 2 buscar abiertos");
      buscarAbiertos();
    }
  }
  buscarAbiertos() async {
    print("buscr abiertos");
    if(datos_cuerpo_juego["posicion_pares"][elementosParaVerificarComunes[0]]!=datos_cuerpo_juego["posicion_pares"][elementosParaVerificarComunes[1]]){
      //volver a tapar imagenes
      print(elementosParaVerificarComunes[0].toString()+" "+elementosParaVerificarComunes[1].toString());
      await Future.delayed(Duration(milliseconds: 1000),(){});//Colocar el setState de forma general puede ser muy diferente a colocarlo donde se necesita es mejor colocar donde es necesario.
      setState(() {
        datos_cuerpo_juego["lista_cartas_delanteras"][elementosParaVerificarComunes[0]] = elegirTipoAnimacion("card_animation_right");
        datos_cuerpo_juego["lista_cartas_delanteras"][elementosParaVerificarComunes[1]] = elegirTipoAnimacion("card_animation_right");
        datos_cuerpo_juego["elementos_mostrados"][elementosParaVerificarComunes[1]]=false;
        datos_cuerpo_juego["elementos_mostrados"][elementosParaVerificarComunes[0]]=false;
        print(datos_cuerpo_juego["elementos_mostrados"]);
      });
      //
    }else{
      print(elementosParaVerificarComunes[0].toString()+" "+elementosParaVerificarComunes[1].toString());
      print(datos_cuerpo_juego["elementos_mostrados"]);
      alterarPuntajeBuscarVictoria();
    }
    elementosParaVerificarComunes=[];
  }
  bool reset;
  //Recorre todo el codigo pero sin ejecutar la mayoria de las funciones
  alterarPuntajeBuscarVictoria() async {
    print("es victoria");
    print(datos_cuerpo_juego["elementos_mostrados"]);
    if(esVictoria()){
      String informacionVictoria=calcularPuntos();
      await Future.delayed(Duration(seconds: 2),(){});
      mostrarMensajeVictoriaPasarSiguienteRonda(informacionVictoria);
      setState(() {
        definirCartasDelanteras();
        habilitarJuego=false;
        reset=true;
      });
      Future.delayed(Duration(seconds: 8),(){
        setState(() {

        });
      });
    }else{
      sumarPuntajes();
    }
  }
  void ocultarTodasCartas(){
    print("ocultar cartas");
    int elementos=datos_cuerpo_juego["numero_elementos"];
    print("ocultar cartas"+elementos.toString());
    for(int i=0;i<elementos;i++){
      setState(() async {
        await Future.delayed(Duration(milliseconds: 1000),(){});
        datos_cuerpo_juego["lista_cartas_delanteras"][elementosParaVerificarComunes[i]] = elegirTipoAnimacion("card_animation_right");
        datos_cuerpo_juego["elementos_mostrados"][elementosParaVerificarComunes[i]]=false;
      });
    }
  }
  FlutterTts fluttertts = FlutterTts();
  speak(String mensaje) async{
    await fluttertts.setPitch(0.8);
    await fluttertts.setLanguage("es-US");
    await fluttertts.setSpeechRate(1.0);
    await fluttertts.setVolume(0.2);
    await fluttertts.speak(mensaje);
  }
  calcularPuntos(){
    print("calcular puntos");
    int numeroAciertos=obtenerNumeroAciertos();
    print("asiertos obtenidos");
    double puntosAcumulados=numeroAciertos.toDouble()*300;
    puntosAcumulados+=(minuto*60*2)+(segundo*2);
    speak("Juego Finalizado. Tiempo es 0:0${minuto}:${(segundo<10)?"0${segundo}":segundo}. Tienes ${puntosAcumulados} puntos acumulados. El numero aciertos es ${numeroAciertos}. Felicidades sigue participando");
    print("Esto es interrumpido");
    print("Juego Finalizado n Tiempo:0${minuto}:${(segundo<10)?"0${segundo}":segundo} Puntos:${puntosAcumulados} Numero aciertos:${numeroAciertos}");
    return "Juego Finalizado\nTiempo:0${minuto}:${(segundo<10)?"0${segundo}":segundo}\nPuntos:${puntosAcumulados}\nNumero aciertos:${numeroAciertos}";
  }
  obtenerNumeroAciertos(){
    int numero=0;
    int elementos=(datos_cuerpo_juego["columnas"]*datos_cuerpo_juego["filas"]);
    print(elementos);
    for(int i=0;i<elementos;i++){
      if(datos_cuerpo_juego["elementos_mostrados"][i]){
        numero++;
      }
      print(numero);
    }
    print(numero);
    int numeroAciertos=(numero/2).toInt();
    return (numeroAciertos);
  }
  mostrarMensajeVictoriaPasarSiguienteRonda(String informacionVictoria){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text("Informacion ronda"),
            content: Text(informacionVictoria),
            actions: [
              FlatButton(onPressed: (){Navigator.pop(context);}, child: Text("Aceptar")),
              FlatButton(onPressed: (){
                Navigator.pop(context);
              },
                child: Text("Guardar y terminar"),
              )
            ],
          );
        }
    );
  }
  sumarPuntajes(){

  }
  esVictoria(){
    int numeroElementos=datos_cuerpo_juego["numero_elementos"];
    bool victoria=true;
    for(int i=0;i<numeroElementos;i++){
      print(datos_cuerpo_juego["elementos_mostrados"][i]);
      if(!datos_cuerpo_juego["elementos_mostrados"][i]){
        victoria=false;
      }
    }
    print(victoria);
    return victoria;
  }
  Widget elegirTipoAnimacion(String name) {
    return FlareActor("assets/card_joker.flr",
        shouldClip: false,
        alignment: Alignment.center,
        fit: BoxFit.fill,
        animation: name);
  }
  void definirCartasDelanteras(){
    int numeroElementos=(datos_cuerpo_juego["columnas"]*datos_cuerpo_juego["filas"]);
    datos_cuerpo_juego["lista_cartas_delanteras"]=[];
    for(int i=0;i<numeroElementos;i++){
      datos_cuerpo_juego["lista_cartas_delanteras"].add(elegirTipoAnimacion("card_animation_right"));
    }//

  }
  void definirPosiciones(){
    int numeroElementos=(datos_cuerpo_juego["columnas"]*datos_cuerpo_juego["filas"]);
    double numeroPares=numeroElementos/2;
    datos_cuerpo_juego["posicion_pares"]=[];
    for(int i=0;i<numeroPares;i++){
      print(i);
      datos_cuerpo_juego["posicion_pares"].add(i);
      datos_cuerpo_juego["posicion_pares"].add(i);
    }//[0,0,1,1,2,2...]
    print(datos_cuerpo_juego["posicion_pares"]);
    int pos=0;
    while(numeroElementos>0){
      pos = Random().nextInt(datos_cuerpo_juego["posicion_pares"].length-1);
      int aux=datos_cuerpo_juego["posicion_pares"][pos];
      datos_cuerpo_juego["posicion_pares"][pos]=datos_cuerpo_juego["posicion_pares"][numeroElementos-1];
      datos_cuerpo_juego["posicion_pares"][numeroElementos-1]=aux;
      numeroElementos--;
    }
    print(datos_cuerpo_juego["posicion_pares"]);
  }

  void definirImagenes() {
    double numeroImagenes=(datos_cuerpo_juego["columnas"]*datos_cuerpo_juego["filas"])/2;//divisiones flutter supone el resultado double sino dara error
    int pos=0;
    int idx=0;
    List numerosRandomicos=[];
    while(numeroImagenes>0){
      //print(rutas_imagenes.length);
      pos = Random().nextInt(rutas_imagenes.length-1);

      /*datos_cuerpo_juego["imagenes_elegidas"][idx]=rutas_imagenes[pos];
        numeroImagenes--;
        idx++;
        numerosRandomicos.add(pos);
      */
      if(!estaRandomico(pos,numerosRandomicos) && numerosRandomicos.length>0){
        datos_cuerpo_juego["imagenes_elegidas"][idx]=rutas_imagenes[pos];
        numeroImagenes--;
        idx++;
        numerosRandomicos.add(pos);
      }else{
        pos = Random().nextInt(rutas_imagenes.length-1);
      }
      (numerosRandomicos.length==0)?numerosRandomicos.add(pos):null;
      print(pos);
      //print("loop");
      //print(pos);
      //print(datos_cuerpo_juego["imagenes_elegidas"][idx]);
    }
    //print(datos_cuerpo_juego["imagenes_elegidas"]);
  }
  bool estaRandomico(int rand,List numerosRandomicos){
    for(int i=0;i<numerosRandomicos.length;i++ ){
      if(numerosRandomicos[i]==rand){
        return true;
      }
    }
    return false;
  }
}
