import 'package:flutter/material.dart';

List<String> drawinglist = ["Drawing 1"];
String s;
TextEditingController controller = new TextEditingController();
void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => Home(),
        for (int i = 0; i < drawinglist.length; i++)
          '/${drawinglist[i]}': (context) => HomePage(),
      },
    ));

class Drawingsheet extends StatefulWidget {
  @override
  _DrawingsheetState createState() => _DrawingsheetState();
}

class _DrawingsheetState extends State<Drawingsheet> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("My drawings"),
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: drawinglist
              .map((drawing) => Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Dismissible(
                      key: Key(drawing),
                      onDismissed: (direction) {
                        setState(() {
                          drawinglist.remove(drawing);
                        });
                      },
                      child: RaisedButton.icon(
                          onPressed: () {
                            setState(() {
                              Navigator.pushNamed(context, '/${drawing}');
                            });
                          },
                          label: Text(
                            drawing,
                            style: TextStyle(
                              fontSize: 30,
                              letterSpacing: 3,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          icon: Icon(Icons.animation)),
                    ),
                  ))
              .toList(),
        ),
        TextField(
          onChanged: (String str) {
            setState(() {
              s = str;
            });
          },
        ),
      ]),
      floatingActionButton: RaisedButton.icon(
          icon: Icon(Icons.add),
          label: Text("New"),
          onPressed: () {
            setState(() {
              drawinglist.add(s);
              controller.text = "";
            });

            runApp(MaterialApp(
              routes: {
                '/': (context) => Home(),
                for (int i = 0; i < drawinglist.length; i++)
                  '/${drawinglist[i]}': (context) => HomePage(),
              },
            ));
          }),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('My drawing'),
        backgroundColor: Colors.black,
      ),
      body: new Container(
        child: new GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition =
                  object.globalToLocal(details.globalPosition);
              _points = new List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: new CustomPaint(
            painter: new Signature(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.clear),
        onPressed: () => _points.clear(),
      ),
    );
  }
}

class Signature extends CustomPainter {
  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}
