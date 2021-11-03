
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home:HomePage() ,
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
 
  Future pickImage(ImageSource source) async{
    try {
    final image= await ImagePicker().pickImage(source: source);
    if(image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);

    } on PlatformException catch(e){
      print('failew to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.amber.shade300,
     body: Container(
       padding: EdgeInsets.all(32),
       child: Column(
         children: [
           Spacer(),
            image!= null ? Image.file(image!,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
            )
            :FlutterLogo(size: 160),
           const SizedBox(height: 24),
           Text('Image Picker',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
           ),
           const SizedBox(height:48),
          buildButton( //METODO PRA PEGAR FOTOS NA GALERIA/ CRIANDO UM BOTÃO
            title: 'pick Gallrey',
            icon: Icons.image_outlined,
            onCliked: () => pickImage(ImageSource.gallery),
          ),
          const SizedBox(height:  24),
          buildButton( //METODO PARA TIRAR FOTOS/ CRIANDO UM BOTÃO
            title:  'pick Camera',
            icon: Icons.camera_alt_outlined,
            onCliked: () =>pickImage(ImageSource.camera),
          ),
          Spacer(),
         ],
       ),
     ),
   );
  
  }

  //METODO DE CRIAÇÃO DO BOTÃO
  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onCliked,
  }) => 
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(56),
        primary: Colors.white,
        onPrimary: Colors.black,
        textStyle: TextStyle(fontSize: 20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 16),
          Text(title),
        ],
      ),
      onPressed: onCliked,
    );
}

