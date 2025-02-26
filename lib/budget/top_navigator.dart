import 'package:app/budget/age_of_money_label.dart';
import 'package:app/budget/filter_list_view.dart';
import 'package:app/budget/month_navigator.dart';
import 'package:app/budget/ready_to_assign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class BudgetTopNavigator extends StatelessWidget {
  const BudgetTopNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Gutter(),
            BudgetMonthNavigator(),
            Gutter(),
            Padding(
              padding: EdgeInsets.all(8),
              child: BudgetReadyToAssign(),
            ),
            Gutter(),
            Flexible(child: BudgetAgeOfMoneyLabel()),
          ],
        ),
        SizedBox(
          height: 48,
          child: BudgetFilterListView(),
        ),
      ],
    );
  }
}
