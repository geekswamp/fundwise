import 'package:app/components/context_extension.dart';
import 'package:app/components/positioned_overlay_builder.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedOverlayBuilder(
      debugLabel: 'logout',
      anchorBuilder: (context, controller, child) {
        return TextButton(onPressed: controller.toggle, child: child);
      },
      anchorChild: const Text('logout'),
      overlayBuilder: (context, controller) {
        return Card(
          elevation: 20,
          borderOnForeground: false,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Are you sure?'),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: context.supabase.auth.signOut,
                    child: const Text('logout'),
                  ),
                  TextButton(
                    onPressed: controller.hide,
                    child: const Text('cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
