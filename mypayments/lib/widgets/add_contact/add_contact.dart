import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypayments/models/contact.dart';
import 'package:mypayments/utils/text_data.dart';
import 'package:mypayments/widgets/add_contact/bloc/add_contact_bloc.dart';
import 'package:mypayments/widgets/add_contact/bloc/state.dart';
import 'package:mypayments/widgets/bottom_sheet_title.dart';
import 'package:mypayments/widgets/custom_form_field.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  late final AddContactBloc bloc;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void initState() {
    bloc = AddContactBloc();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactBloc, AddContactState>(
      bloc: bloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  const BottomSheetTitle(title: TextData.addContact),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomFormField(
                          label: TextData.contactName,
                          controller: nameController,
                          maxLength: 20,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return TextData.nameRequired;
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 24),
                          child: CustomFormField(
                            label: TextData.contactNumber,
                            controller: numberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return TextData.numberRequired;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          bloc
                              .addContact(
                            Contact(
                              name: nameController.text,
                              number: numberController.text,
                              history: [],
                            ),
                          )
                              .then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text(TextData.contactCreatedWithSuccesss),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          });
                        }
                      },
                      child: const Text(
                        TextData.addContact,
                      ),
                    ),
                  )
                ],
              ),
              if (state.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
