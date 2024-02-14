part of 'sign_up_web_3_notifier.dart';

class SignUpWeb3State extends Equatable {
  static const int validationsAmount = 2;
  final bool isBlurWallActive;
  final String? mnemonic;

  final List<int> mnemonicIndexToValidate;
  final List<List<String>>? posibleResponses;
  final List<int> userResponses;

  final CreateMnemonicAndAccountsResponseEntity? mnemonicUseCaseResponse;

  SignUpWeb3State({
    this.mnemonic,
    this.isBlurWallActive = true,
    this.mnemonicUseCaseResponse,
    this.posibleResponses,
    List<int>? userResponses,
    List<int>? mnemonicIndexToValidate,
  })  : mnemonicIndexToValidate = mnemonicIndexToValidate ??
            _initializeMnemonicIndexToValidate(validationsAmount),
        userResponses = userResponses ?? _initializeUserResponses();

  List<String> get mnemonicArray => mnemonicToArray(mnemonic);

  List<String> mnemonicToArray(String? mnemonic) {
    return mnemonic?.split(' ') ?? [];
  }

  List<String> get sortedMnemonicArray {
    List<String> sorted = List.from(mnemonicArray);
    sorted.sort();
    return sorted;
  }

  SignUpWeb3State copyWith({
    int? page,
    String? mnemonic,
    List<int>? mnemonicIndexToValidate,
    List<List<String>>? posibleResponses,
    bool? isBlurWallActive,
    List<int>? userResponses,
    CreateMnemonicAndAccountsResponseEntity? mnemonicUseCaseResponse,
  }) {
    return SignUpWeb3State(
      mnemonic: mnemonic ?? this.mnemonic,
      mnemonicUseCaseResponse:
          mnemonicUseCaseResponse ?? this.mnemonicUseCaseResponse,
      mnemonicIndexToValidate:
          mnemonicIndexToValidate ?? this.mnemonicIndexToValidate,
      posibleResponses: posibleResponses ?? this.posibleResponses,
      isBlurWallActive: isBlurWallActive ?? this.isBlurWallActive,
      userResponses: userResponses ?? this.userResponses,
    );
  }

  @override
  List<Object> get props => [
        mnemonic ?? '',
        posibleResponses ?? [],
        userResponses,
        mnemonicIndexToValidate,
      ];

  static List<int> _initializeMnemonicIndexToValidate(int validationAmount) {
    assert(validationAmount > 0, 'debe validar al menos una palabra');
    assert(validationAmount <= 12, "no se pueden validar más de 12 palabras");
    final List<int> wordIndexs = List<int>.generate(12, (index) => index);

    wordIndexs.shuffle();
    return wordIndexs.sublist(0, validationAmount);
  }

  static List<int> _initializeUserResponses() {
    return List<int>.filled(validationsAmount, -1);
  }

  List<List<String>>? _initializePosibleAnswers(String? mnemonic) {
    if (mnemonic == null || mnemonic.isEmpty) return null;
    List<List<String>> responses = [];
    for (int i = 0; i < mnemonicIndexToValidate.length; i++) {
      responses.insert(i, generatePosibleAnswer(i, mnemonic));
    }

    return responses;
  }

  List<String> generatePosibleAnswer(int validationStep, String mnemonic) {
    final mnemonicIndex = mnemonicIndexToValidate[validationStep];
    final mnemonicAsArray = mnemonicToArray(mnemonic);

    final wrongAnswers = List.of(mnemonicAsArray);
    wrongAnswers.removeAt(mnemonicIndex);
    wrongAnswers.shuffle();

    final List<String> posibleAnswers = [
      ...wrongAnswers.sublist(0, 5),
      mnemonicAsArray[mnemonicIndex],
    ];
    posibleAnswers.shuffle();
    return posibleAnswers;
  }
}
