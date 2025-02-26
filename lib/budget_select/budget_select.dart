import 'dart:developer';

import 'package:app/budget/budget_location.dart';
import 'package:app/budget_new/budget_new_page_location.dart';
import 'package:app/budget_select/budget_select_bloc.dart';
import 'package:app/repository/repository.dart';
import 'package:app/router/router.dart';
import 'package:flailwind/flailwind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:intl/intl.dart';

class BudgetSelectPage extends StatelessWidget {
  const BudgetSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BudgetSelectBloc(context.read<BudgetRepository>())
        ..add(InitializeBudgetSelectEvent()),
      child: const BudgetSelectView(),
    );
  }
}

class BudgetSelectView extends StatelessWidget {
  const BudgetSelectView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BudgetSelectBloc, BudgetSelectState>(
      listenWhen: (prev, next) =>
          prev is! DefaultBudgetSelected && next is DefaultBudgetSelected,
      listener: (context, state) {
        if (state case DefaultBudgetSelected(:final budget)) {
          context.navigate(
            to: BudgetLocation(id: budget.id),
          );
        }
      },
      builder: (context, state) {
        if (state is InitialBudgetSelectState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is DefaultBudgetSelected) return const SizedBox.shrink();
        if (state is ListBudgetSelection || state is InitialBudgetSelectState) {
          return ListView.builder(
            itemCount: state.budgets.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card.outlined(
                  color: context.primaryContainer,
                  child: InkWell(
                    onTap: () {
                      log('$state');
                      context.router
                          .navigate(to: const BudgetNewPageLocation());
                    },
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
                    log('$state');
                    context.navigate(to: BudgetLocation(id: budget.id));
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
