import 'package:bloc_project/bloc/area_of_circle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AreaCircleView extends StatelessWidget {
  AreaCircleView({super.key});

  final TextEditingController firstController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Area of Circle Bloc"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: firstController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Radius",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            BlocBuilder<AreaOfCircleBloc, double>(
              builder: (context, state) {
                return Text(
                  'Area: ${state.toStringAsFixed(2)}', // Format the area to 2 decimal places
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final double? radius = double.tryParse(firstController.text);

                if (radius != null && radius > 0) {
                  context
                      .read<AreaOfCircleBloc>()
                      .add(CalculateAreaEvent(radius));
                } else {
                  // Show error or do nothing if the radius is invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please enter a valid radius")),
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
