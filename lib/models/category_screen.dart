
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/helpers/color_helper.dart';
import 'package:flutter_budget_ui/widgets/radial_painter.dart';

import 'category_model.dart';
import 'expense_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key,required this.category}) : super(key: key);
  final Category category;
  @override
  _CateoryScreenState createState() => _CateoryScreenState();
}

class _CateoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    widget.category.expenses.forEach((Expense expense) {
      totalAmountSpent += expense.cost;
    });
    final double amountLeft = widget.category.maxAmount - totalAmountSpent;
    final double percent = amountLeft / widget.category.maxAmount;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.category.name),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250.0,
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ]
              ),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: Colors.grey.shade200,
                  lineColor: getColor(context, percent),
                  percent: percent,
                  width: 15.0
                ) ,

                child: Center(
                  child: Text(
                    '\$${amountLeft.toStringAsFixed(2)} / \$${widget.category.maxAmount}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )

            ),
            _buildExpenses(),
          ],
        ),
      ),
    );
  }

  _buildExpenses() {
    List<Widget> expenseLise = [];
    widget.category.expenses.forEach((Expense expense) {
        Widget item = Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0,2),
                blurRadius: 6.0
              )
            ]
          ),
          child:  Padding(
            padding: EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expense.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '-\$${expense.cost.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

          ),

        );
        expenseLise.add(item);
    });
    return Column(
      children: expenseLise,
    );
  }

}
