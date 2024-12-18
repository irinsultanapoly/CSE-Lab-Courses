import 'package:bagani/config/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PlantDetailsScreen extends ConsumerWidget {
  final int id;

  PlantDetailsScreen({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantState = ref.watch(plantByIdProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop(); // GoRouter's built-in method to go back
          },
        ),
      ),
      body: plantState.when(
        data: (response) {
          final plant = response.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    'https://media-hosting.imagekit.io//05683e9d58da4523/playstore.png?Expires=1734647077&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=2hGgx-BdfrBsMYCQA2uHUxq3IMK~9cc9PsOh8Ij41yqlV6wDx78H-QJR9NyZUB2dxGH0RTpSTHKCmz7g-MashatP3OV~La657wUIQ0pZzt5ffHQKF1rR6kJeoC9Zu8DsNjzOUkazbeQ-m1OTqY8TeYy72sWruNTaUfUabMu9dd-1sppD1T1m0fCIxrDdfg9jd5mAPS0ugbgtgMZQTc93B80MF3227xPSI~~PHAR-dXMQoY4Q3WB0x7DXdlmkkNbEbtBJt9vjLrbQLvSpH~1uM8qqjsY5FqiK7jywaUc~hcHedx4tcZT4L~M2Dzd7i3Ch~OEYhvHZAdu1Rf2Z5PcJKQ__'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    plant?.name ?? '',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Species: ${plant?.species}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Description: ${plant?.description ?? 'No description available.'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Created At: ${plant?.createdAt}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Status: ${plant?.status}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
