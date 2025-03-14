import 'api_repository.dart';
import 'local_repository.dart';

class Repository {
  final LocalRepository localRepository;
  final ApiRepository apiRepository;

  Repository({required this.localRepository, required this.apiRepository});
}
