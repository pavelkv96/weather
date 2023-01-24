// ignore_for_file: one_member_abstracts

abstract class UseCase<Input, Output> {
  Output call({required Input input});
}

abstract class VoidUseCase<Output> {
  Output call();
}
