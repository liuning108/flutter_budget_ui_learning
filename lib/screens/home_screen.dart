import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/helpers/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/category_screen.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/widgets/bar_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          floating: true,
          forceElevated: true,
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
          flexibleSpace: const FlexibleSpaceBar(
            title: Text("Simple Budget"),
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.add), iconSize: 30.0),
          ],
        ),
        SliverToBoxAdapter(
            child: Container(
          margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0)
          ]),
          child: BarChart(weeklySpending),
        )),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          final Category category = categories[index];
          double totalAmountSpent = 0;
          category.expenses.forEach((Expense expense) {
            totalAmountSpent += expense.cost;
          });
          return _buildCategory(category, totalAmountSpent);
        }, childCount: categories.length - 1))
      ],
    ));
  }

  Widget _buildCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () {
        print(11);
        Navigator.push(context,
            MaterialPageRoute(
                builder: (_)=>CategoryScreen(category: category,)
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                ),
              )
            ]),
            const SizedBox(height: 18.0,),
            LayoutBuilder(
              builder: (context ,constraints){
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent) /
                    category.maxAmount;
                double barWidth = percent * maxBarWidth;
                if (barWidth < 0) {
                  barWidth = 0;
                }

                return Stack(
                  children: [
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                    ),
                    Container(
                      height: 20.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                        color: getColor(context,percent),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                );
              },

            )

          ],
        ),
      ),
    );
  }
}
