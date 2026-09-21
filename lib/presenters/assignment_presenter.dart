import '../models/assignment_model.dart';

class AssigmentPresenter {
  final List<Assignment> _assignments = [];

  List<Assignment> get assignments => _assignments;

  void addAssignment(String title) {
    _assignments.add(Assignment(tittle: title));
  }

  void toggleAssignmentCompletion(int index) {
    if (index >= 0 && index < _assignments.length) {
      _assignments[index].isCompleted = !_assignments[index].isCompleted;
    }
  }

  //void removeAssignment(int index) {
   // if (index >= 0 && index < _assignments.length) {
    //  _assignments.removeAt(index);
   // }
  //}
}