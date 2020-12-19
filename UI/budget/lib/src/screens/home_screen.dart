import 'package:budget/src/data/data.dart';
import 'package:budget/src/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            expandedHeight: 100,
            floating: true,
            leading: Icon(Icons.settings),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Budget'),
            ),
            actions: [
              Icon(
                Icons.add,
                size: 30,
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0)
                  return Card();
                else {
                  final category = categories[index - 1];
                  double totalAmount = 0;
                  category.expenses.forEach((expense) {
                    totalAmount += expense.cost;
                  });
                  return CategoryCard(category, totalAmount);
                }
              },
              childCount: 1 + categories.length,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final double totalAmount;
  final Category category;

  const CategoryCard(this.category, this.totalAmount);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/category', arguments: category);
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\$${(category.maxAmount - totalAmount).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            LayoutBuilder(builder: (context, constrins) {
              double percent =
                  ((category.maxAmount - totalAmount) / category.maxAmount);
              double width = constrins.maxWidth * percent;
              if (width < 0) width = 0;
              return Stack(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: width,
                    decoration: BoxDecoration(
                      color: getColor(context, percent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  getColor(BuildContext context, double percent) {
    if (percent > 0.5) return Theme.of(context).primaryColor;
    if (percent > 0.25) return Colors.orange;
    return Colors.red;
  }
}

class Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: BarChart(expenses: weeklySpending),
    );
  }
}

class BarChart extends StatelessWidget {
  final List<double> expenses;

  const BarChart({Key key, this.expenses}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            'Weekly Spending',
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                iconSize: 32,
                icon: Icon(Icons.arrow_back),
              ),
              IconButton(
                onPressed: () {},
                iconSize: 32,
                icon: Icon(Icons.arrow_forward),
              ),
              Text(
                'Nov 10 2020 - Dec 18 2020',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:
                buildBars(['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']).toList(),
          ),
        ],
      ),
    );
  }

  Iterable<Widget> buildBars(List<String> days) sync* {
    double mostExpensive = 0;
    expenses.forEach((price) {
      if (price > mostExpensive) mostExpensive = price;
    });
    for (int i = 0; i < days.length; i++) {
      yield Bar(
        label: days[i],
        amountSpent: expenses[i],
        mostExpensive: mostExpensive,
      );
    }
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;
  final double maxBarHeight = 150;

  const Bar({this.label, this.amountSpent, this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * maxBarHeight;
    return Column(
      children: [
        Text('\$${amountSpent.toStringAsFixed(2)}'),
        SizedBox(height: 6),
        Container(
          height: barHeight,
          width: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
