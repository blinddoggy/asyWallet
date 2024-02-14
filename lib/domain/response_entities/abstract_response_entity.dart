abstract class ResponseEntity {
  final bool isSuccess;
  final String? errorMessage;

  ResponseEntity({required this.isSuccess, this.errorMessage});
}
