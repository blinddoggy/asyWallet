import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradex_wallet_3/presentation/screens/account/import_account_business_logic.dart';

class ImportAccountScreen extends ConsumerWidget {
  const ImportAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bl = ImportAccountBusinessLogic(context: context, ref: ref);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    if (bl.isLoading) {
      return bl.loadingWidget;
    }

    final TextEditingController inputNameController = TextEditingController();
    final TextEditingController inputMnemonicController =
        TextEditingController();

    const vGap = SizedBox(height: 20);

    final minHeightConstraint = MediaQuery.sizeOf(context).height -
        (kBottomNavigationBarHeight + kToolbarHeight + 80);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Importar Cuenta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Container(
            constraints: BoxConstraints(minHeight: minHeightConstraint),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/image/wallet_3d.png',
                        height: 190,
                        fit: BoxFit.fitHeight,
                      ),
                      vGap,
                      TextFormField(
                        controller: inputNameController,
                        decoration: const InputDecoration(labelText: "Nombre"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa un nombre';
                          }

                          return null;
                        },
                      ),
                      vGap,
                      TextFormField(
                        maxLines: 3,
                        controller: inputMnemonicController,
                        decoration: const InputDecoration(
                          labelText: "Frase Mnemónica",
                          helperText: 'Las 12 palabras separadas por espacio.',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa la frase mnemónica';
                          }
                          RegExp regex = RegExp(r'^([\w,]+\s?){11}[\w,]+$');
                          if (!regex.hasMatch(value)) {
                            return 'La frase mnemónica debe tener exactamente 12 palabras';
                          }
                          return null;
                        },
                      ),
                      vGap,
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            bl.createAccount(
                              mnemonic: inputMnemonicController.text,
                              name: inputNameController.text,
                            );
                          }
                        },
                        child: const Row(
                          children: [
                            Text('Agregar Cuenta'),
                            SizedBox(width: 4),
                            Icon(Icons.add_task_outlined, size: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
