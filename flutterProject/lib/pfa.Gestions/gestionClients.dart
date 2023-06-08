
import 'package:mongo_dart/mongo_dart.dart';

const String MONGO_CONN_URL =
    "mongodb+srv://PFAY2Ai:MvqdYN84OGYYtO8D@pfa.clt7gyd.mongodb.net/WasteToxique?retryWrites=true&w=majority";
const String USER_COLLECTION = "Client";

class GestionClient {
  List<Map<String, dynamic>> clients = [];
  GestionClient({required this.clients});
  bool isLoading = true;

  void connectToMongoDB() async {
    try {
      final db = await Db.create(MONGO_CONN_URL);
      await db.open();

      final collection = db.collection(USER_COLLECTION);

      final fetchedClients = await collection.find().toList();
      
      clients = fetchedClients.map((clients) => clients).toList();
      isLoading = false;
      db.close();

      // print('Connected to MongoDB successfully!');
      // print('Employee Data: $employees');
    } catch (error) {
       print('Error connecting to MongoDB: $error');
    }
  }

  




}


