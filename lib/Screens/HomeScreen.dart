import 'package:budget_app_ui/Data/data.dart';
import 'package:budget_app_ui/Helpers/colorChange.dart';
import 'package:budget_app_ui/Models/category_model.dart';
import 'package:budget_app_ui/Models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CategoryExpense.dart';
import 'ChartBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _categoryBar(Category category, double totalAmountSpent) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryScreen(category)));
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10.0)],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category.name,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)}/ \$${category.maxAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                final maxBarWidth = constraints.maxWidth;
                final percent = (category.maxAmount - totalAmountSpent) /
                    category.maxAmount;
                var barWidth = percent * maxBarWidth;

                if (barWidth < 0) {
                  barWidth = 0;
                }

                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5.0)
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    Container(
                      width: barWidth,
                      height: 20,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: getColor(percent),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5.0)
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {}),
            expandedHeight: 100,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Simple budget',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: null)
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5.0)
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ChartBar(expenses: weeklySpending),
                  );
                } else {
                  final Category category = categories[index - 1];
                  double totalAmountSpent = 0;
                  category.expenses.forEach((Expense expense) {
                    totalAmountSpent += expense.cost;
                  });

                  return _categoryBar(category, totalAmountSpent);
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
