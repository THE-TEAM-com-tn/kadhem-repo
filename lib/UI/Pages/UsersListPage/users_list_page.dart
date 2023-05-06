import 'package:elearning_provider/UI/Pages/UsersListPage/users_list_model.dart';
import 'package:elearning_provider/UI/Widgets/assign_training_popup.dart';
import 'package:elearning_provider/UI/Widgets/delete_training_popup.dart';
import 'package:elearning_provider/UI/Widgets/edit_user_popup.dart';
import 'package:elearning_provider/models/UserModel.dart';
import 'package:elearning_provider/providers/users_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../Widgets/InputWidget.dart';
import '../../Widgets/confirmation_popup.dart';
import '../../Widgets/nav_bar.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  bool _nameSortAsc = true, asc = true, _idAsc = true;
  int sortedColumn = 0;
  bool status = false;
  late UsersListModel _model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = UsersListModel();
    _model.searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CustomNavBar(
          selectedIndex: 2,
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Consumer<UsersListProvider>(
                builder: (context, value, child) {
                  if (value.loading) {
                    value.getUsers();
                  }
                  return !value.loading
                      ? Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: InputWidget(
                                obcure: false,
                                validator: _model.SearchValidator,
                                model: _model.searchController,
                                text: 'Search for users by name',
                                initialValue: '',
                                enabled: true,
                                maxLines: 1,
                                onChanged: (query) {
                                  value.filterData(query);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Card(
                                elevation: 10.0,
                                child: DataTable(
                                  border: TableBorder.all(
                                    width: 2.0,
                                    color: Colors.grey,
                                  ),
                                  sortColumnIndex: sortedColumn,
                                  sortAscending: asc,
                                  dividerThickness: 2.0,
                                  columns: [
                                    DataColumn(
                                        onSort: (columnIndex, ascending) {
                                          setState(() {
                                            _idAsc = !_idAsc;
                                            asc = _idAsc;
                                            sortedColumn = columnIndex;
                                            value.users.sort((a, b) {
                                              if (_idAsc) {
                                                return a.firstname
                                                    .compareTo(b.firstname);
                                              } else {
                                                return b.firstname
                                                    .compareTo(a.firstname);
                                              }
                                            });
                                          });
                                        },
                                        label: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            child: const Text('First Name'))),
                                    DataColumn(
                                        onSort: (columnIndex, ascending) {
                                          setState(() {
                                            _nameSortAsc = !_nameSortAsc;
                                            asc = _nameSortAsc;
                                            sortedColumn = columnIndex;
                                            value.users.sort((a, b) {
                                              if (_nameSortAsc) {
                                                return a.lastname
                                                    .compareTo(b.lastname);
                                              } else {
                                                return b.lastname
                                                    .compareTo(a.lastname);
                                              }
                                            });
                                          });
                                        },
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: const Text('Last Name'),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05)),
                                    DataColumn(
                                        onSort: (columnIndex, ascending) {
                                          setState(() {
                                            _nameSortAsc = !_nameSortAsc;
                                            asc = _nameSortAsc;
                                            sortedColumn = columnIndex;
                                            value.users.sort((a, b) {
                                              if (_nameSortAsc) {
                                                return a.email
                                                    .compareTo(b.email);
                                              } else {
                                                return b.email
                                                    .compareTo(a.email);
                                              }
                                            });
                                          });
                                        },
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: const Text('Email'),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15)),
                                    DataColumn(
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: const Text('Role'),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1)),
                                    DataColumn(
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: const Text('Edit User'),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05)),
                                    DataColumn(
                                        label: Container(
                                            alignment: Alignment.center,
                                            child:
                                                const Text('Assign Trainings'),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1)),
                                    DataColumn(
                                        label: Container(
                                            alignment: Alignment.center,
                                            child:
                                                const Text('Delete Trainings'),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1)),
                                    DataColumn(
                                        label: Container(
                                            alignment: Alignment.center,
                                            child: const Text('Delete User'),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05)),
                                  ],
                                  rows: List.generate(
                                      value.searchedUsers.length, (index) {
                                    return DataRow(
      color: MaterialStateProperty.resolveWith<
                                          Color>((Set<MaterialState> states) {
                                        if (index % 2 == 0)
                                          return Colors.grey.withOpacity(0.1);
                                        return Colors.white;
                                      }) ,
                                      cells : getRows(value.searchedUsers[index],
                                        context, value, index));
                                  }),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Text('fetching');
                },
              ),
            ),
          )),
    );
  }

  List<DataCell> getRows(
      UserModel user, BuildContext cont, UsersListProvider provider,int index) {
    String role = user.role;
    return  [
      DataCell(
          Container(alignment: Alignment.center, child: Text(user.firstname))),
      DataCell(
          Container(alignment: Alignment.center, child: Text(user.lastname))),
      DataCell(Container(alignment: Alignment.center, child: Text(user.email))),
      DataCell(Container(
        child: DropdownButtonFormField<String>(
            value: role,
            items: <String>['user', 'admin', 'contentCreator', 'instructor']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (value) {
              role = value!;
              user.role = value;
              provider.updateRole(value, user.userId!);
            }),
      )),
      DataCell(Container(
          alignment: Alignment.center,
          child: IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyPopup(userModel: user);
                  },
                ).then((value) {
                  setState(() {
                    provider.users = [];
                    provider.loading = true;
                  });
                });
              },
              icon: const Icon(Icons.edit)))),
      DataCell(Container(
          alignment: Alignment.center,
          child: IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AssignTrainingPopup(
                      uid: user.userId!,
                    );
                  },
                );
              },
              icon: const Icon(Icons.assignment_add)))),
      DataCell(Container(
          alignment: Alignment.center,
          child: IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteTrainingsPopUp(uid: user.userId!);
                  },
                );
              },
              icon: const Icon(Icons.backspace)))),
      DataCell(Container(
          alignment: Alignment.center,
          child: IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content:
                          Column(mainAxisSize: MainAxisSize.min, children: [
                        const Text("Would you like to delete the user?"),
                        ElevatedButton(
                            onPressed: () async {
                              await provider.deleteUser(user);
                              Navigator.pop(context);
                            },
                            child: const Text('Yes')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Yes')),
                      ]),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.person_remove_alt_1_rounded,
                color: Colors.red,
              ))))
    ];
  }
}
