import 'package:flutter/cupertino.dart';

class LinePath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    var path = Path();
    path.lineTo(0, size.height/4 * 3);
   
    var firstControlPoint = Offset(size.width/2 , size.height);
    var firstEndPoint = Offset(size.width,size.height/4 * 3);
    
    
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
     firstEndPoint.dx, firstEndPoint.dy); 
    path.lineTo(size.width, 0.0);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {

    return false;
  }

}

class LinePathSmall extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    var path = Path();
    path.lineTo(0, size.height/2);
   
    var firstControlPoint = Offset(size.width/2 , size.height);
    var firstEndPoint = Offset(size.width, size.height/2);
    
    
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
     firstEndPoint.dx, firstEndPoint.dy); 
    path.lineTo(size.width, 0.0);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}