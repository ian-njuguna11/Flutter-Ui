import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2.5,
            decoration: BoxDecoration(
              color: Color.fromRGBO(111, 127, 243, 1),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 30),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                InkWell(
                    child: ProfileCircle(),
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DD()));
                  },
                ),
                Text(
                  'Sample Name',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor*21,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ProfileCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/3,
      height: MediaQuery.of(context).size.height/6,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 140,
                height:140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(135, 149, 255, 1),
                ),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: ExactAssetImage('assets/g1.jpg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
              Positioned(
                right: 1,
                bottom: 1,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(width: 3,color: Color.fromRGBO(135, 149, 255, 1),),
                      shape: BoxShape.circle,
                      color: Colors.white
                  ),
                  child: Center(
                    child: Text(
                      '23',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

class DD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawing Paths',
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                width: 200,
                height: 200,
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                  border: Border.all(width: 1)
//                ),
              child: CustomPaint(
                painter: CurvePainter(),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {

  int percentage = 10;
  double textScaleFactor = 1.0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap =StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth =50;

    double radius = min(size.width, size.height);
    Offset center = Offset(size.width/2, size.height/2);

    canvas.drawCircle(center, radius, paint);
    double arcAngle = 2 * pi * (percentage /100); //호의 각도를 정함

    paint..color = Colors.deepPurpleAccent;//호를 ㅡ를때는 색을 바꿔줌
    canvas.drawArc(Rect.fromCircle(center: center,radius: radius), -pi /2, arcAngle, false, paint);


    drawText(canvas, size, "$percentage / 100");
  }

  void drawText(Canvas canvas, Size size, String text){
    double fontSize = getFontSize(size,text);

    TextSpan sp = TextSpan(style: TextStyle(fontSize:fontSize, fontWeight: FontWeight.bold, color: Colors.black), text: text);
    TextPainter tp = TextPainter(text: sp , textDirection: TextDirection.ltr);

    tp.layout();

    double dx = size.width /2 - tp.width /2;
    double dy = size.height /2 - tp.height /2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);


  }

  double getFontSize(Size size, String text){
    return size.width / text.length * textScaleFactor;
  }


//  _paintRightLine(Canvas canvas, Size size, Paint paint){
//    Offset p1 = Offset(0,0);
//    Offset p2 = Offset(size.width/2, size.height/2);
//    canvas.drawLine(p1, p2, paint);
//    print(size.width);
//    print(size.height);
//  }
//
//
//  _paintLeftLine(Canvas canvas, Size size, Paint paint){
//    Offset p1 = Offset(size.width, 0);
//    Offset p2 = Offset(size.width/2, size.height/2);
//    canvas.drawLine(p1, p2, paint);
//  }


  @override
  bool shouldRepaint(CurvePainter old) {
    return old.percentage != percentage;
  }
}