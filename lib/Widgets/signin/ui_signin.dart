import 'package:flutter/material.dart';

class UI_One extends StatefulWidget {
  UI_One({Key key}) : super(key: key);

  @override
  UI_OneState createState() => UI_OneState();
}

class UI_OneState extends State<UI_One> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        Align(
          child: Container(
              alignment: Alignment.topLeft,
              child: ClipPath(
                clipper: BackgroundClipper2(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topLeft,
                          colors: [
                        const Color.fromRGBO(41, 128, 185, 1),
                        const Color.fromRGBO(109, 213, 250, 1),
                        const Color.fromRGBO(255, 255, 255, 1)
                      ])),
                ),
              )),
        ),
        Align(
            child: Container(
                alignment: Alignment.topLeft,
                child: ClipPath(
                    clipper: BackgroundClipper1(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                            const Color.fromRGBO(44, 62, 80, 1),
                            const Color.fromRGBO(189, 195, 199, 1),
                          ])),
                    )))),
        Align(
            alignment: Alignment.topLeft,
            child: Container(
                child: ClipPath(
              clipper: BackgroundClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.16,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.3, 0.0),
                      colors: [
                        const Color.fromRGBO(255, 210, 0, 1),
                        const Color.fromRGBO(247, 151, 30, 0.8),
                      ]),
                ),
              ),
            ))),
      ]),
    );
  }
}

class BackgroundClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    print(size);
    var round = 50.0;
    path.moveTo(0, size.height * 0.85);
    path.cubicTo(size.width * 0.76, size.height * 1.25, size.width * 0.577,
        size.height * 0.669, size.width * 0.6304, size.height * 0.5289);
    path.quadraticBezierTo(size.width * 0.63, size.height * 0.53,
        size.width * 0.64, size.height * 0.5);
    path.cubicTo(size.width * 0.868, size.height * 0.207, size.width * 1.219,
        size.height * 0.2409, size.width, 0);

    path.lineTo(0, 0);
    //path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BackgroundClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(
        size.width * 0.3506, size.height * 0.9258, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    print(size);
    var round = 50.0;
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.12, size.height, size.width * 0.23, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.23, size.height * 0.7,
        size.width * 0.3, size.height * 0.54);
    //path.quadraticBezierTo(size.width*0.56, size.height*0.2, size.width*0.42, size.height*0.34);
    //path.quadraticBezierTo(size.width*0.3, size.height*0.54, size.width*0.42, size.height*0.34);
    path.quadraticBezierTo(size.width * 0.42, size.height * 0.34,
        size.width * 0.75, size.height * 0.14);
    path.quadraticBezierTo(
        size.width * 0.86, size.height * 0.08, size.width, 0);
    path.lineTo(0, 0);

    //path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
