import 'package:app/budget/ui/budget_page.dart';
import 'package:app/components/positioned_overlay_builder.dart';
import 'package:flailwind/flailwind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class BudgetReadyToAssign extends StatelessWidget {
  const BudgetReadyToAssign({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.primaryContainer,
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r(), style: context.p.xxl),
                  Text('Ready to assign', style: context.p.xl),
                ],
              ),
            ),
          ),
          const Gutter(),
          const BudgetAssignButton(),
          const Gutter(),
        ],
      ),
    );
  }
}

class BudgetAssignButton extends StatelessWidget {
  const BudgetAssignButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedOverlayBuilder(
      debugLabel: 'BudgetAssignButton',
      anchorBuilder: (context, controller) {
        return TextButton.icon(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16),
            foregroundColor: context.onTertiaryContainer,
            backgroundColor: context.colorScheme.inversePrimary,
          ),
          iconAlignment: IconAlignment.end,
          label: const Text('Assign'),
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: controller.toggle,
        );
      },
      overlayChildBuilder: (context, controller) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              for (var i = 0; i < 10; i++)
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('thing $i'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
