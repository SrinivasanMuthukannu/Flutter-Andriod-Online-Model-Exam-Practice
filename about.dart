import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
//syasan
  String Abouturl ="https://firebasestorage.googleapis.com/v0/b/onlinequiz-620e2.appspot.com/o/Syasan%2FSyasanAbout.jpg?alt=media&token=e777bfe4-c635-45e9-9e93-831437cc354c";
  //Golearn
  //String Abouturl  ="https://firebasestorage.googleapis.com/v0/b/onlinequiz-620e2.appspot.com/o/Golearn%2FGGLogo.jpg?alt=media&token=0b1827cf-7d1c-4d4e-9647-28809446c548";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('about'), backgroundColor: Colors.blue),
      body: Center(
          child: CachedNetworkImage(
            imageUrl: Abouturl,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          )
      ),
    );
  }
}