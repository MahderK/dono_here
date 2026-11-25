import 'package:material_ui/material_ui.dart';

class NearbyDonorsScreen extends StatelessWidget {
  const NearbyDonorsScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Donors')),
      body: Center(
        child: Text('Matching donors for request ID: $requestId'),
      ),
    );
  }
}