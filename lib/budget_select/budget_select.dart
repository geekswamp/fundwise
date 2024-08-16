import 'package:app/budget_select/budget_select_bloc.dart';
import 'package:app/repository/currency_format_model.dart';
import 'package:app/repository/formatter.dart';
import 'package:app/router/router.dart';
import 'package:duck_router/duck_router.dart';
import 'package:flailwind/flailwind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:intl/intl.dart';

class BudgetSelectPage extends StatelessWidget {
  const BudgetSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BudgetSelectView();
  }
}

class BudgetSelectView extends StatelessWidget {
  const BudgetSelectView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BudgetSelectBloc, BudgetSelectState>(
      bloc: budgetSelectBloc$,
      listener: (context, state) {
        if (state is DefaultBudgetSelected) {
          DuckRouter.of(context)
              .navigate(to: BudgetLocation(id: state.budget.id));
        }
      },
      builder: (context, state) {
        if (state is InitialBudgetSelectState ||
            state is DefaultBudgetSelected) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is ListBudgetSelection || state is InitialBudgetSelectState) {
          return ListView.builder(
            itemCount: state.budgets.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card.outlined(
                  color: context.primaryContainer,
                  child: InkWell(
                    onTap: () => DuckRouter.of(context)
                        .navigate(to: const BudgetNewPageLocation()),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New Budget',
                                style: context.h3,
                              ),
                              Row(
                                children: [
                                  const Text('budget.owner'),
                                  const Gutter(),
                                  Text(
                                    DateFormat('MM.d.y').format(DateTime.now()),
                                  ),
                                  const Gutter(),
                                  Text(
                                    currencyFormatter(
                                      milliunits: 10000,
                                      format: CurrencyFormatModel(
                                        decimalSeparator: '.',
                                        groupSeparator: ',',
                                        symbol: r'$',
                                        groupSize: 3,
                                        decimalDigits: 2,
                                        displaySymbol: true,
                                        symbolFirst: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.add,
                            size: 48,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              final budget = state.budgets[index - 1];
              return Card.outlined(
                key: ValueKey(budget.id),
                color: context.secondaryContainer,
                child: InkWell(
                  onTap: () {
                    context
                        .read<BudgetSelectBloc>()
                        .add(SelectBudgetEvent(budget));
                    DuckRouter.of(context)
                        .navigate(to: BudgetLocation(id: budget.id));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              budget.name,
                              style: context.h3,
                            ),
                            Row(
                              children: [
                                Text(budget.owner),
                                const Gutter(),
                                Text(
                                  DateFormat(budget.dateFormat)
                                      .format(DateTime.now()),
                                ),
                                const Gutter(),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right,
                          size: 48,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: Text("Oops! Something went wrong :'["),
        );
      },
    );
  }
}
