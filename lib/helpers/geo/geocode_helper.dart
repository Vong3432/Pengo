import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_geocoding/google_geocoding.dart';

GoogleGeocoding getGeoCodingIns() {
  final String apiKey = dotenv.env["GEOCODING_API_KEY"] ?? '';
  return GoogleGeocoding(apiKey);
}
