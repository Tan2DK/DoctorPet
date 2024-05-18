import 'package:dartz/dartz.dart';

import '../data/request/degree_request.dart';
import '../data/response/degree_response.dart';

abstract class DegreeRepo {
  Future<Either<String, String>> createDegree({
    required DegreeRequest degreeRequest,
  });
  Future<Either<String, List<DegreeResponse>?>> getDegree();
}
