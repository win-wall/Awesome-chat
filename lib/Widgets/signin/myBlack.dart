import 'package:awesome_chat_app/Widgets/signin/ui_signin.dart';
import 'package:flutter/material.dart';

class myBlack1 extends StatefulWidget {
  double par;
  myBlack1({Key key, @required this.par}) : super(key: key);
  @override
  _myBlackState createState() => _myBlackState(this.par);
}

class _myBlackState extends State<myBlack1> {
  double par;
  _myBlackState(this.par);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BackgroundClipper_1(par),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            //backgroundBlendMode: BlendMode.exclusion,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(60, 59, 45, 1),
              Color.fromRGBO(60, 59, 63, 1)
            ])),
      ),
    );
  }
}

class BackgroundClipper_1 extends CustomClipper<Path> {
  double par;
  BackgroundClipper_1(this.par);

  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    if (par >= 0 && par < 0.6) {
      path_0.moveTo(size.width, size.height);
      if (par == 0) {
        path_0.lineTo(0, size.height);
      }
      path_0.quadraticBezierTo(
          size.width * 0.95 * par,
          size.height * 0.91 * (1.11 - par),
          size.width * 0.76 * par,
          size.height * 0.83 * (1.11 - par));
      path_0.cubicTo(
          size.width * 0.66 * par,
          size.height * 0.79 * (1.1 - par),
          size.width * 0.62 * par,
          size.height * 0.78 * (1.1 - par),
          size.width * 0.50 * par,
          size.height * 0.75 * (1.1 - par));
      path_0.cubicTo(
          size.width * 0.36 * par,
          size.height * 0.72 * (1.1 - par),
          size.width * 0.19 * par,
          size.height * 0.67 * (1.1 - par),
          size.width * 0.12 * par,
          size.height * 0.63 * (1.1 - par));
      path_0.cubicTo(
          size.width * 0.03 * par,
          size.height * 0.57 * (1.1 - par),
          size.width * 0.01 * par,
          size.height * 0.54 * (1.1 - par),
          size.width * -0.00 * par,
          size.height * 0.48 * (1.1 - par));
      path_0.cubicTo(
          size.width * 0.01 * par,
          size.height * 0.41 * (1 - par),
          size.width * 0.05 * par,
          size.height * 0.37 * (1 - par),
          size.width * 0.10 * par,
          size.height * 0.33 * (1 - par));
      path_0.quadraticBezierTo(
          size.width * 0.12 * par,
          size.height * 0.30 * (1 - par),
          size.width * 0.19 * par,
          size.height * 0.25 * (1 - par));
      path_0.quadraticBezierTo(
          size.width * 0.36 * par,
          size.height * 0.15 * (1 - par),
          size.width * 0.43 * par,
          size.height * 0.13 * (1 - par));
      path_0.cubicTo(
          size.width * 0.48 * par,
          size.height * 0.10 * (1 - par),
          size.width * 0.60 * par,
          size.height * 0.07 * (1 - par),
          size.width * 0.67 * par,
          size.height * 0.05 * (1 - par));
      path_0.quadraticBezierTo(size.width * 0.75 * par,
          size.height * 0.03 * par, size.width * 1.00 * par, size.height * 0.0);
      path_0.lineTo(size.width, 0);
      return path_0;
    } else {
      path_0.moveTo(size.width, size.height);
      path_0.quadraticBezierTo(
          size.width * 0.95 * par,
          size.height * 0.91 * par,
          size.width * 0.76 * par,
          size.height * 0.83 * par);
      path_0.cubicTo(
          size.width * 0.66 * par,
          size.height * 0.79 * par,
          size.width * 0.62 * par,
          size.height * 0.78 * par,
          size.width * 0.50 * par,
          size.height * 0.75 * par);
      path_0.cubicTo(
          size.width * 0.36 * par,
          size.height * 0.72 * par,
          size.width * 0.19 * par,
          size.height * 0.67 * par,
          size.width * 0.12 * par,
          size.height * 0.63 * par);
      path_0.cubicTo(
          size.width * 0.03 * par,
          size.height * 0.57 * par,
          size.width * 0.01 * par,
          size.height * 0.54 * par,
          size.width * -0.00 * par,
          size.height * 0.48 * par);
      path_0.cubicTo(
          size.width * 0.01 * par,
          size.height * 0.41 * par,
          size.width * 0.05 * par,
          size.height * 0.37 * par,
          size.width * 0.10 * par,
          size.height * 0.33 * par);
      path_0.quadraticBezierTo(
          size.width * 0.12 * par,
          size.height * 0.30 * par,
          size.width * 0.19 * par,
          size.height * 0.25 * par);
      path_0.quadraticBezierTo(
          size.width * 0.36 * par,
          size.height * 0.15 * par,
          size.width * 0.43 * par,
          size.height * 0.13 * par);
      path_0.cubicTo(
          size.width * 0.48 * par,
          size.height * 0.10 * par,
          size.width * 0.60 * par,
          size.height * 0.07 * par,
          size.width * 0.67 * par,
          size.height * 0.05 * par);
      path_0.quadraticBezierTo(size.width * 0.75 * par,
          size.height * 0.03 * par, size.width * 1.00 * par, size.height * 0.0);
      path_0.lineTo(size.width, 0);
      if (par >= 0.6) return path_0;
    }
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
