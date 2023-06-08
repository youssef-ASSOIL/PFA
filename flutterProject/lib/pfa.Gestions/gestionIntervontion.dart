import '../pfa.classes/Intervention.dart';

class GestionIntervontion {
  List<Intervention> intervontions;

  GestionIntervontion({required this.intervontions});

  void addIntervontion(Intervention intervontion) {
    intervontions.add(intervontion);
  }

  void deleteIntervontion(int id) {
    intervontions.removeWhere((Intervention) => Intervention.id == id);
  }
  
}
 
