import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypayments/models/contact.dart';
import 'package:mypayments/utils/text_data.dart';
import 'package:mypayments/widgets/bottom_sheet_title.dart';
import 'package:mypayments/widgets/custom_form_field.dart';
import 'package:mypayments/widgets/recharge_widget/bloc/recharge_bloc.dart';
import 'package:mypayments/widgets/recharge_widget/bloc/state.dart';

class RechargeWidget extends StatefulWidget {
  final Contact contact;
  const RechargeWidget({super.key, required this.contact});

  @override
  State<RechargeWidget> createState() => _RechargeWidgetState();
}

class _RechargeWidgetState extends State<RechargeWidget> {
  late final RechargeBloc bloc;
  final formKey = GlobalKey<FormState>();
  final totalValueController = TextEditingController();
  String subValue = "";

  @override
  void initState() {
    bloc = RechargeBloc(contact: widget.contact);
    super.initState();
  }

  @override
  void dispose() {
    totalValueController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RechargeBloc, RechargeState>(
      bloc: bloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const BottomSheetTitle(title: TextData.mobileRecharge),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: CustomFormField(
                        label: TextData.valueToBeRechaged,
                        controller: totalValueController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return TextData.numberRequired;
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    const Text(
                      TextData.chargeValue,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Wrap(
                children: [
                  RechageSuggestionChip(
                    value: 5,
                    onSelect: onSelectChip,
                  ),
                  RechageSuggestionChip(
                    value: 10,
                    onSelect: onSelectChip,
                  ),
                  RechageSuggestionChip(
                    value: 20,
                    onSelect: onSelectChip,
                  ),
                  RechageSuggestionChip(
                    value: 30,
                    onSelect: onSelectChip,
                  ),
                  RechageSuggestionChip(
                    value: 50,
                    onSelect: onSelectChip,
                  ),
                  RechageSuggestionChip(
                    value: 75,
                    onSelect: onSelectChip,
                  ),
                  RechageSuggestionChip(
                    value: 100,
                    onSelect: onSelectChip,
                  ),
                ],
              ),
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    state.error!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 12),
                child: ElevatedButton(
                  onPressed: () {
                    if (state.isLoading) return;
                    if (formKey.currentState!.validate()) {
                      bloc
                          .recharge(
                        double.parse(totalValueController.text) + 1,
                      )
                          .then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text(TextData.contactRechargedSuccessfully),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      });
                    }
                  },
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          TextData.rechargeNow,
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void onSelectChip(double value) {
    totalValueController.text =
        double.tryParse(totalValueController.text) != null
            ? ((double.tryParse(totalValueController.text) ?? 0.0) + value)
                .toStringAsFixed(2)
            : value.toStringAsFixed(2);
  }
}

class RechageSuggestionChip extends StatelessWidget {
  final double value;
  final Function(double) onSelect;
  const RechageSuggestionChip({
    super.key,
    required this.value,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ChoiceChip(
        shape: const StadiumBorder(),
        backgroundColor: Colors.blue.shade800,
        label: Text(
          '+${value.toStringAsFixed(2)}',
          style: const TextStyle(color: Colors.white),
        ),
        onSelected: (_) {
          onSelect(value);
        },
        selected: false,
      ),
    );
  }
}
