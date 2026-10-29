// EXPERIMENT 1(b): Simple Dart program to understand language basics.
// Run separately with: dart run lib/dart_basics.dart
// ignore_for_file: avoid_print

// A simple class to demonstrate OOP basics in Dart.
class Student {
  String name;
  int year;
  List<String> subjects;

  Student(this.name, this.year, this.subjects);

  void showDetails() {
    print('Name: $name');
    print('Year: $year');
    print('Subjects: ${subjects.join(", ")}');
  }
}

// A simple function with a default parameter.
String greet(String name, {String greeting = 'Hello'}) {
  return '$greeting, $name! Welcome to Flutter Lab.';
}

// A function demonstrating control flow.
String gradeFor(int marks) {
  if (marks >= 90) {
    return 'A+';
  } else if (marks >= 75) {
    return 'A';
  } else if (marks >= 60) {
    return 'B';
  } else {
    return 'C';
  }
}

void main() {
  // Variables and basic types
  String appName = 'Campus Connect';
  int semester = 5;
  double gpa = 8.7;
  bool isActive = true;

  print('App: $appName | Semester: $semester | GPA: $gpa | Active: $isActive');

  // Using the greet function
  print(greet('Aarav'));
  print(greet('Meera', greeting: 'Hi'));

  // Collections: List and Map
  List<int> marksList = [95, 82, 67, 40];
  for (int m in marksList) {
    print('Marks: $m -> Grade: ${gradeFor(m)}');
  }

  Map<String, String> clubRoles = {
    'President': 'Aarav',
    'Vice President': 'Meera',
    'Treasurer': 'Kiran',
  };
  clubRoles.forEach((role, person) {
    print('$role: $person');
  });

  // Using the Student class
  var student = Student('Aarav', 3, ['Flutter', 'DBMS', 'OS']);
  student.showDetails();
}
