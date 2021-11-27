import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  const BarChart(List<double> this.weeklySpending, {Key? key})
      : super(key: key);
  final List<double> weeklySpending;
  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    weeklySpending.forEach((double price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Text(
            "Weekly Spending",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
                iconSize: 20.0,
              ),
              const Text(
                'Nov 10, 2019 - Nov 16, 2019',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2),
              ),
              IconButton(
                  onPressed: () {},
                  iconSize: 20.0,
                  icon: Icon(Icons.arrow_forward))
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Bar(
                label: 'Su',
                amountSpent: weeklySpending[0],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Mo',
                amountSpent: weeklySpending[1],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Tu',
                amountSpent: weeklySpending[2],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'We',
                amountSpent: weeklySpending[3],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Th',
                amountSpent: weeklySpending[4],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: 'Fr',
                amountSpent: weeklySpending[5],
                mostExpensive: mostExpensive,
              ),

            ],
          ),
          const SizedBox(height: 20.0,)
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  Bar(
      {Key? key,
      required this.label,
      required this.amountSpent,
      required this.mostExpensive})
      : super(key: key);
  String label;
  double amountSpent;
  double mostExpensive;
  final double _maxBarHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;

    return Column(children: [
      Text(
        "\$${amountSpent.toStringAsFixed(2)}",
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 6.0,),
      Container(
        height: barHeight,
        width: 18.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6.0)
        ),
      ),
      SizedBox(height: 8.0,),
      Text(
        label,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600
        ),
      )

    ]);
  }
}
