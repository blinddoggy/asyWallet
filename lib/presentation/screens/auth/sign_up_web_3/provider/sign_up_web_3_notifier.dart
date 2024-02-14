import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/domain/response_entities/create_mnemonic_and_accounts_response_entity.dart';

part 'sign_up_web_3_state.dart';

class SignUpWeb3Notifier extends StateNotifier<SignUpWeb3State> {
  SignUpWeb3Notifier() : super(SignUpWeb3State());

  void setMnemonic(String mnemonic) {
    state = state.copyWith(mnemonic: mnemonic);
    state.posibleResponses;
  }

  void setMnemonicUseCaseResponse(
      CreateMnemonicAndAccountsResponseEntity response) {
    state = state.copyWith(
        mnemonic: response.mnemonic,
        mnemonicUseCaseResponse: response,
        posibleResponses: state._initializePosibleAnswers(response.mnemonic));
  }

  void setUserResponse(int validationStep, int userResponse) {
    final List<int> response = List.of(state.userResponses);
    response[validationStep] = userResponse;

    state = state.copyWith(userResponses: response);
  }

  String? getSelectedOptionWord(int stepValidation) {
    if (state.userResponses.isEmpty) return '';
    try {
      final index = state.userResponses[stepValidation];
      return state.posibleResponses?[stepValidation][index];
    } catch (e) {
      return null;
    }
  }

  bool validateMnemonicVerification() {
    if (state.mnemonicArray.isEmpty) return false;

    for (int i = 0; i < state.mnemonicIndexToValidate.length; i++) {
      final wordToVerify =
          state.mnemonicArray[state.mnemonicIndexToValidate[i]];
      final userWordResponse = getSelectedOptionWord(i);
      if (wordToVerify != userWordResponse) {
        return false;
      }
    }
    return true;
  }

  void turnOffBlurWall() {
    state = state.copyWith(isBlurWallActive: false);
    Future.delayed(
      const Duration(
        seconds: 10,
      ),
    ).then((value) {
      if (state.isBlurWallActive == false) {
        state = state.copyWith(isBlurWallActive: true);
      }
    });
  }
}
