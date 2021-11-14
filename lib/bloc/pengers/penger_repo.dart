import 'package:pengo/bloc/pengers/penger_api_provider.dart';
import 'package:pengo/models/penger_model.dart';

class PengerRepo {
  factory PengerRepo() {
    return _instance;
  }

  PengerRepo._constructor();

  static final PengerRepo _instance = PengerRepo._constructor();
  final PengerApiProvider _pengerApiProvider = PengerApiProvider();

  Future<List<Penger>> fetchPengers({
    int? sortDate,
    int? sortDistance,
    int? km,
    int? limit,
    String? name,
    bool? searchKeywordOnly,
  }) async =>
      _pengerApiProvider.fetchPengers(
        sortDistance: sortDistance,
        sortDate: sortDate,
        km: km,
        limit: limit,
        name: name,
        searchKeywordOnly: searchKeywordOnly,
      );
  Future<Penger> fetchPenger({required int id}) async =>
      _pengerApiProvider.fetchPenger(id: id);

  Future<List<Penger>> fetchNearestPengers({int? limit, int? pageNum}) async =>
      _pengerApiProvider.fetchNearestPengers(limit: limit, pageNum: pageNum);
  Future<List<Penger>> fetchPopularPengers({int? limit, int? pageNum}) async =>
      _pengerApiProvider.fetchPopularPengers(limit: limit, pageNum: pageNum);
}
