import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class CreateRequestScreen extends StatelessWidget {
  const CreateRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Request')),
      body: Center(
        child: FilledButton(
          onPressed: () => context.pop(),
          child: const Text('Submit & Back'),
        ),
      ),
    );
  }
}