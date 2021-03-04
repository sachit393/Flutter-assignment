import 'package:flutter/material.dart';
// import 'package:flutterapp/pages/choose_location.dart';
// import 'package:flutterapp/pages/home.dart';

// import 'package:flutterapp/pages/loading.dart';

// void main() => runApp(MaterialApp(
//       initialRoute: '/home',
//       routes: {
//         '/': (context) => Loading(),
//         '/home': (context) => Home(),
//         '/location': (context) => ChooseLoctaion(),
//       },
//     ));

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => Home(),
        '/Drawing1': (context) => HomePage(),
        '/Drawing2': (context) => HomePage(),
        '/Drawing3': (context) => HomePage(),
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
  List<String> drawings = ["Drawing 1", "Drawing 2", "Drawing 3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("My drawings"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: drawings
            .map((drawing) => RaisedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/Drawing1');
                },
                label: Text(drawing),
                icon: Icon(Icons.account_box)))
            .toList(),
      ),
      floatingActionButton: RaisedButton.icon(
        icon: Icon(Icons.add),
        label: Text("New"),
      ),
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
