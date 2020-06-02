import 'package:flutter/cupertino.dart';

class LinePath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0.0, size.height);
    var firstEndPoint = Offset(size.width/2 ,size.height-20);
    var firstControlPoint = Offset(size.width/4 , size.height-40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
     firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height/4 * 3);
    var secondControlPoint = Offset(size.width/4 * 3, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
     secondEndPoint.dx, secondEndPoint.dy);

    
    path.lineTo(size.width, size.height/2);
    path.lineTo(size.width, 0.0);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}