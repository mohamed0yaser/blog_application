class Failure{
  final String message;

  Failure([this.message= 'an unexpected error occurred. Please try again later!']);

  @override
  String toString() => message;
}