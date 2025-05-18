import 'package:dartz/dartz.dart';
import '../error/base_error.dart';
import '../result/result.dart';

abstract class Repository {
  Result<BaseError, Model> executeWithoutConvert<Model, Entity>({
    required Either<BaseError, Model> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(data: (remoteResult as Right<BaseError, Model>).value);
    } else {
      return Result(error: (remoteResult as Left<BaseError, Model>).value);
    }
  }
}
