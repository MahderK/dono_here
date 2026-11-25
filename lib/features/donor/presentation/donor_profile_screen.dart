import 'package:material_ui/material_ui.dart';

class DonorProfileScreen extends StatelessWidget {
  const DonorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donor Profile')),
      body: const Center(
        child: Text('Donor Profile — blood type, area, availability'),
      ),
    );
  }
}