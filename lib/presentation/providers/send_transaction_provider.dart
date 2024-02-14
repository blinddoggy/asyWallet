import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradex_wallet_3/application/dto/portfolio_dto.dart';
import 'package:tradex_wallet_3/application/dto/send_transaction_dto.dart';
import 'package:tradex_wallet_3/domain/entities/transaction.dart';
import 'package:tradex_wallet_3/domain/response_entities/send_transaction_response_entity.dart';
import 'package:tradex_wallet_3/presentation/providers/porfolio_provider.dart';

final sendTranactionStateNotifierProvider = StateNotifierProvider.autoDispose<
    SendTranactionNotifier,
    SendTransactionDTO>((ref) => SendTranactionNotifier(ref));

class SendTranactionNotifier extends StateNotifier<SendTransactionDTO> {
  // ignore: unused_field
  final StateNotifierProviderRef _ref;
  final PageController pageController = PageController();

  SendTranactionNotifier(this._ref)
      : tradexData = _ref.watch(portfolioStateNotifierProvider),
        super(SendTransactionDTO());
  final PortfolioDTO tradexData;

  void setTransaction(Transaction transaction) {
    state = state.copyWith(transaction: transaction);
  }

  void setTransactionResponse(SendTransactionResponseEntity response) {
    state = state.copyWith(transactionResponse: response);
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
