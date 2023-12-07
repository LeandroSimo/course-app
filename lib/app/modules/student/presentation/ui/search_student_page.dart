import 'package:flutter/material.dart';
import 'package:teste_vrsoft/app/modules/student/entities/student_entity.dart';
import 'package:teste_vrsoft/app/modules/student/presentation/widgets/student_card.dart';
import 'package:teste_vrsoft/app/modules/student/stores/student_store.dart';

class StudentSearchDelegate extends SearchDelegate<StudentEntity> {
  final StudentStore controller;
  StudentSearchDelegate({required this.controller});

  @override
  String? get searchFieldLabel => "Pesquisar aluno";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    String firstName = '';
    String lastName = '';

    if (controller.studentList.isNotEmpty) {
      final buildLeanding = controller.studentList
          .where((element) =>
              element.firstName.toLowerCase().contains(query.toLowerCase()) ||
              element.lastName.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (buildLeanding.isNotEmpty &&
          buildLeanding[0].firstName.isNotEmpty &&
          buildLeanding[0].lastName.isNotEmpty) {
        firstName = buildLeanding[0].firstName;
        lastName = buildLeanding[0].lastName;
      }
    }

    return IconButton(
      onPressed: () {
        close(context, StudentEntity(firstName: firstName, lastName: lastName));
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length >= 3) {
      return Container(
        padding: const EdgeInsets.only(top: 8),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: ListView.builder(
          itemCount: controller.studentList.length,
          itemBuilder: (_, index) {
            final student = controller.studentList[index];
            if (student.firstName.toLowerCase().contains(query.toLowerCase()) ||
                student.lastName.toLowerCase().contains(query.toLowerCase())) {
              return StudentCard(
                student: student,
                firstNameEditController: TextEditingController(),
                lastNameEditController: TextEditingController(),
                controller: controller,
                func: () {},
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      );
    }
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length >= 3) {
      final suggestionList = query.isEmpty
          ? controller.studentList
          : controller.studentList.where((element) {
              final fullName =
                  '${element.firstName} ${element.lastName}'.toLowerCase();
              final queryLower = query.toLowerCase();

              final filterList = queryLower.split(' ');

              return filterList.every((filter) => fullName.contains(filter));
            }).toList();

      return Container(
        padding: const EdgeInsets.only(top: 8),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (_, index) {
            final student = suggestionList[index];
            return StudentCard(
              student: student,
              firstNameEditController: TextEditingController(),
              lastNameEditController: TextEditingController(),
              controller: controller,
              func: () {},
            );
          },
        ),
      );
    }
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
