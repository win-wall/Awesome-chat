import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_chat_app/Screens/signin_improve.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  void _togglePlay() {
    setState(() => _controller.isActive = !_controller.isActive);
  }

  bool get isPlaying => _controller?.isActive ?? false;
  Artboard _riveArtboard;
  RiveAnimationController _controller;

  final double MaxSlide = 1;
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4500));
    toogle();
    rootBundle.load('assets/welcome1.riv').then((data) async {
      final file = RiveFile();
      if (file.import(data)) {
        final artbroad = file.mainArtboard;
        artbroad.addController(_controller = SimpleAnimation('Untitled 1'));
        setState(() {
          _riveArtboard = artbroad;
        });
      }
    });
  }

  void toogle() => _animationController.forward();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
            child: _riveArtboard == null
                ? const SizedBox()
                : Rive(
                    artboard: _riveArtboard,
                    fit: BoxFit.cover,
                  )),
        AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              if (_animationController.value == 1) {
                return Stack(
                  children: [
                    Container(
                        alignment: Alignment(0, -0.4),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: AutoSizeText(
                            'Chat every where at any time with your love one\n -Awesome chat',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    Container(
                        alignment: Alignment(0, 0.8),
                        child: FlatButton(
                          child: Text('Get Started'),
                          color: Colors.purple,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignIn_Improve()));
                          },
                        ))
                  ],
                );
              } else {
                return Text('');
              }
            }),
      ]),
    );
  }
}
