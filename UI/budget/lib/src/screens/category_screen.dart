import 'dart:math';

import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoryScreen extends StatelessWidget {
  final Category category;

  const CategoryScreen({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    category.expenses.forEach((exp) {
      totalAmountSpent += exp.cost;
    });
    double amountLeft = category.maxAmount - totalAmountSpent;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 32,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomPaint(
              painter: RadialPainter(
                percent: totalAmountSpent / category.maxAmount,
                bgColor: Colors.grey[200],
                lineColor:
                    getColor(context, totalAmountSpent / category.maxAmount),
                width: 12,
              ),
              child: Center(
                child: Text(
                  '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          ...buildItems(),
        ],
      ),
    );
  }

  getColor(BuildContext context, double percent) {
    if (percent > 0.5) return Theme.of(context).primaryColor;
    if (percent > 0.25) return Colors.orange;
    return Colors.red;
  }

  Iterable<Widget> buildItems() sync* {
    for (int i = 0; i < category.expenses.length; i++) {
      final expense = category.expenses[i];
      yield Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '- ${expense.name}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '- \$${expense.cost.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    }
  }
}

class RadialPainter extends CustomPainter {
  final double percent;
  final Color bgColor;
  final double width;
  final Color lineColor;

  RadialPainter({this.percent, this.bgColor, this.width, this.lineColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = bgColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint completePaint = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        2 * pi * percent, false, completePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
