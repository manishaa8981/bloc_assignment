import 'package:bloc_project/bloc/student_bloc.dart';
import 'package:bloc_project/bloc/student_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentBlocView extends StatelessWidget {
  StudentBlocView({super.key});

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Bloc"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocConsumer<StudentBloc, StudentState>(
          listener: (context, state) {
            // You could show a success message or perform some action when state updates
          },
          builder: (context, state) {
            return Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Name"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(hintText: "Age"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(hintText: "Address"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final name = _nameController.text;
                      final age = int.tryParse(_ageController.text) ?? 0;
                      final address = _addressController.text;

                      context
                          .read<StudentBloc>()
                          .add(AddStudentEvent(name, age, address));
                    },
                    child: const Text("Submit"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state.lstStudents.isEmpty
                      ? const Text("No students have been added")
                      : Expanded(
                          child: ListView.builder(
                            itemCount: state.lstStudents.length,
                            itemBuilder: (context, index) {
                              final student = state.lstStudents[index];
                              return ListTile(
                                title: Text(student.name),
                                subtitle: Text(
                                    'Age: ${student.age}, Address: ${student.address}'),
                              );
                            },
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
