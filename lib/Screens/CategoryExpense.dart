import 'package:budget_app_ui/Helpers/colorChange.dart';
import 'package:budget_app_ui/Models/category_model.dart';
import 'package:budget_app_ui/Models/expense_model.dart';
import 'package:budget_app_ui/Screens/CircularPainter.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  CategoryScreen(this.category);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  _buildExpenses() {
    List<Widget> expenseList = [];

    widget.category.expenses.forEach((Expense expense) {
      expenseList.add(Container(
        height: 80,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.green, offset: Offset(1, 0), blurRadius: 2.0)
        ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${expense.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                      fontSize: 20),
                ),
                Text(
                  '\$${expense.cost.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ));
    });
    return Column(
      children: expenseList,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountSpent = 0;
    widget.category.expenses.forEach((Expense expense) {
      totalAmountSpent += expense.cost;
    });
    double amountLeft = widget.category.maxAmount - totalAmountSpent;

    double percentage = amountLeft / widget.category.maxAmount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text(widget.category.name)),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              color: Colors.white,
              child: CustomPaint(
                foregroundPainter: CircularPainter(
                  bgColor: Colors.grey.shade200,
                  fillColor: getColor(percentage),
                  percent: percentage,
                  width: 15.0,
                ),
                child: Center(
                  child: Text(
                    '\$${amountLeft.toStringAsFixed(2)}/ \$${widget.category.maxAmount}',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _buildExpenses(),
          ],
        ),
      ),
    );
  }
}
