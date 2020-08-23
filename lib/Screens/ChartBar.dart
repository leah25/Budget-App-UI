import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final List<double> expenses;

  ChartBar({this.expenses});

  @override
  Widget build(BuildContext context) {
    double _mostExpensive = 0;

    expenses.forEach((double _cost) {
      if (_cost > _mostExpensive) {
        _mostExpensive = _cost;
      }
    });
    return Column(
      children: [
        SizedBox(height:10.0),
        Text(
          'Weekly Spending',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            Text(
              ' August 8, 2020  & August 15, 2020',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                label: 'Sun',
                amountSpent: expenses[0],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Mon',
                amountSpent: expenses[1],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Tue',
                amountSpent: expenses[2],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Wed',
                amountSpent: expenses[3],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Thur',
                amountSpent: expenses[4],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Fri',
                amountSpent: expenses[5],
                mostExpensive: _mostExpensive,
              ),
              Bar(
                label: 'Sat',
                amountSpent: expenses[6],
                mostExpensive: _mostExpensive,
              ),
            ]),
      ],
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxHeight = 150.0;

  Bar({this.label, this.amountSpent, this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final double barHeight = ((amountSpent / mostExpensive) * _maxHeight);

    return Column(
      children: [
        Text('\$${amountSpent.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 4.0),
        Container(
          height: barHeight,
          width: 18.0,
          color: Colors.green,
        ),
        Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
