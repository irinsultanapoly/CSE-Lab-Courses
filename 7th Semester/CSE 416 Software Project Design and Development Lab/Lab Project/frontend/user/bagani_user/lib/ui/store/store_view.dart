import 'package:bagani/config/providers.dart';
import 'package:bagani/ui/store/store_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StoreView extends ConsumerStatefulWidget {
  final int userId;

  StoreView({required this.userId});

  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends ConsumerState<StoreView> {
  @override
  void initState() {
    super.initState();
    // Initialize the ViewModel and call the method to fetch plants
    Future.delayed(Duration.zero, () {
      ref
          .read(storeViewModelProvider.notifier)
          .getPlantsByUserId(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final plantState = ref.watch(storeViewModelProvider);

    return Column(
      children: [
        const SizedBox(height: 50),
        Text("My Listed Plant"),
        // Loading state
        if (plantState.isLoading)
          const Center(child: CircularProgressIndicator()),

        // Error state
        if (plantState.hasError)
          Center(child: Text('Error: ${plantState.error}')),

        // List of plants if data is available
        if (plantState.hasValue && plantState.value!.plants.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: plantState.value!.plants.length,
              itemBuilder: (context, index) {
                final plant = plantState.value!.plants[index];
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      plant.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    plant.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    plant.species,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onTap: () {
                    // Handle plant details page navigation or action
                    print('Plant tapped: ${plant.name}');
                    context.push('/plant-details/${plant.id}');
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          )
        else if (plantState.hasValue && plantState.value!.plants.isEmpty)
          const Center(child: Text('No plants available.')),
      ],
    );
  }

  _fetchData() {
    ref.read(storeViewModelProvider.notifier).getPlantsByUserId(widget.userId);
  }
}
