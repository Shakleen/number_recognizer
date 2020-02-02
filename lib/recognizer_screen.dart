import 'package:flutter/material.dart';
import 'package:number_recognizer/constant.dart';
import 'package:number_recognizer/drawing_painter.dart';

class RecognizerScreen extends StatefulWidget {
  RecognizerScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RecognizerScreen createState() => _RecognizerScreen();
}

class _RecognizerScreen extends State<RecognizerScreen> {
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.red,
                alignment: Alignment.center,
                child: Text('Header'),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 3.0, color: Colors.blue),
              ),
              padding: EdgeInsets.all(16),
              child: Builder(builder: _buildCanvas),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text('Footer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCanvas(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject();
          points.add(
            renderBox.globalToLocal(details.globalPosition),
          );
        });
      },
      onPanStart: (DragStartDetails details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject();
          points.add(
            renderBox.globalToLocal(details.globalPosition),
          );
        });
      },
      onPanEnd: (DragEndDetails details) {
        setState(() {
          points.add(null);
        });
      },
      child: ClipRect(
        child: CustomPaint(
          size: Size(kCanvasSize, kCanvasSize),
          painter: DrawingPainter(offsetPoints: points),
        ),
      ),
    );
  }
}