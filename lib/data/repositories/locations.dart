import 'package:sendspace/data/models/location.dart';
import 'package:supabase/supabase.dart'; // Ensure you have the Supabase package imported

abstract class LocationRepository {
  Future<List<Location>> fetchLocations();
}

class LocationRepositoryImpl implements LocationRepository {
  final SupabaseClient _client;

  LocationRepositoryImpl(this._client);

  // TODO: create a SP on the backend that returns locations based
  // on the user's location. Right now, Chadison Heights is hard-coded
  @override
  Future<List<Location>> fetchLocations() async {
    try {
      final response = await _client.from('locations').select('*');

      if (response.isEmpty) {
        throw Exception('No locations found');
      }

      final value = response[0];

      return Future.value([Location.fromJson(value)]);
    } catch (e) {
      throw Exception('Failed to fetch locations: $e');
    }
  }
}
