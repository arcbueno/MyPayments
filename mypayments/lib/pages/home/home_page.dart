import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypayments/pages/home/bloc/home_bloc.dart';
import 'package:mypayments/pages/home/bloc/home_state.dart';
import 'package:mypayments/utils/text_data.dart';
import 'package:mypayments/widgets/add_contact/add_contact.dart';
import 'package:mypayments/widgets/contact_list_item.dart';
import 'package:mypayments/widgets/recharge_widget/recharge_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;

  @override
  void initState() {
    bloc = HomeBloc();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(TextData.myPayments),
              ),
              body: Stack(
                children: [
                  if (state.user == null)
                    Text(
                      TextData.userNotFound,
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 24, left: 24, right: 24),
                            child: RichText(
                              text: TextSpan(
                                  text: '${TextData.balance}:  ',
                                  style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: state.user!.balance
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                        color: Colors.blue.shade900,
                                        fontSize: 24,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 24, left: 24, right: 24),
                            child: Text(
                              TextData.mobileRecharge,
                              style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height / 5,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ListView.builder(
                                    padding: const EdgeInsets.only(left: 24),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemExtent:
                                        MediaQuery.sizeOf(context).width / 2.40,
                                    itemCount: state.user!.contacts.length,
                                    itemBuilder: (context, index) {
                                      return ContactListItem(
                                        contact: state.user!.contacts[index],
                                        onTapRecharge: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return Wrap(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: RechargeWidget(
                                                        contact: state.user!
                                                            .contacts[index]),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                          bloc.updateContacts();
                                        },
                                      );
                                    },
                                  ),
                                  if (state.user!.contacts.length < 5)
                                    IconButton(
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.blue.shade800,
                                        shadowColor: Colors.transparent,
                                      ),
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return Wrap(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: const AddContact(),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                        bloc.updateContacts();
                                      },
                                      icon: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (state.isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          },
          bloc: bloc,
        ),
      ),
    );
  }
}
