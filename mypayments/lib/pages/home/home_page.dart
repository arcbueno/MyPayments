import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypayments/models/contact.dart';
import 'package:mypayments/pages/home/bloc/home_bloc.dart';
import 'package:mypayments/pages/home/bloc/home_state.dart';
import 'package:mypayments/utils/text_data.dart';
import 'package:mypayments/widgets/contact_list_item.dart';

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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        var contactListTemp = [
          Contact(id: 0, name: 'John', history: [], number: '+915255219205'),
          Contact(id: 0, name: 'Peter', history: [], number: '+915255219205'),
          Contact(id: 0, name: 'Clara', history: [], number: '+915255219205'),
          Contact(id: 0, name: 'Mary', history: [], number: '+915255219205'),
          Contact(id: 0, name: 'James', history: [], number: '+915255219205'),
        ];
        return Scaffold(
          appBar: AppBar(
            title: const Text(TextData.myPayments),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          TextData.mobileRecharge,
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: contactListTemp.length,
                          itemBuilder: (context, index) {
                            return ContactListItem(
                                contact: contactListTemp[index]);
                          }),
                    ],
                  ),
                if (state.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        );
      },
      bloc: bloc,
    );
  }
}
