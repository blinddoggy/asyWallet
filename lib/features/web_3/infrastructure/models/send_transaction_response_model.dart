class SendTransactionResponseModel {
  final bool isSuccess;
  final String? transactionHash;
  final String? errorMessage;

  SendTransactionResponseModel({
    required this.isSuccess,
    this.transactionHash,
    this.errorMessage,
  });
}
