import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/domain/repositories/auth_repository.dart';

import '../../../core/error/base_error.dart';
import '../../../core/result/result.dart';
import '../../../core/usecases/base_use_case.dart';

class GetUserUseCase
    extends UseCase<Future<Result<BaseError, UserModel>>, int> {
  final AuthRepository authRepository;

  GetUserUseCase({required this.authRepository});

  @override
  Future<Result<BaseError, UserModel>> call(int params) async {
    return authRepository.getUserById(params);
  }
}
