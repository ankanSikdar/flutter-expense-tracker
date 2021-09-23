import 'dart:io';

import 'package:expense_app/blocs/transactions/transactions_bloc.dart';
import 'package:expense_app/extensions/currency_extension.dart';
import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:likk_picker/likk_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTransaction extends StatefulWidget {
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime pickedDate;
  File imageFile;
  Directory appLibraryDirectory;
  GalleryController controller;

  @override
  void initState() {
    super.initState();
    updateDirectory();
    controller = GalleryController(
      gallerySetting: GallerySetting(
        enableCamera: true,
        maximum: 1,
        requestType: RequestType.image,
        onItemClick: (entity, list) async {
          if (list.isNotEmpty) {
            final file = await list[0].entity.file;
            updateImage(file);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Future<void> updateDirectory() async {
    appLibraryDirectory = await getApplicationDocumentsDirectory();
    appLibraryDirectory = await appLibraryDirectory.create();
  }

  void updateImage(File image) {
    final fileExtension = image.path.split('.').last;
    if (fileExtension == 'jpg' ||
        fileExtension == 'jpeg' ||
        fileExtension == 'png') {
      setState(() {
        imageFile = image;
      });
    }
  }

  void onSubmit() async {
    if (!formKey.currentState.validate()) {
      return;
    }
    File writtenFile;
    if (imageFile != null) {
      final imageFilePath = '${appLibraryDirectory.path}/${Uuid().v4()}.png';
      final emptyFile = await File(imageFilePath).create();
      writtenFile = await emptyFile.writeAsBytes(imageFile.readAsBytesSync());
    }
    final tBloc = context.read<TransactionsBloc>();
    tBloc.add(
      AddTransaction(
        transaction: Transaction(
          id: Uuid().v4(),
          title: titleController.text,
          amount: double.parse(amountController.text),
          date: pickedDate,
          imagePath: imageFile == null ? '' : writtenFile.path,
          createdOn: DateTime.now(),
        ),
      ),
    );
    Navigator.pop(context);
  }

  void startDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.parse("2020-01-01 00:00:01Z"),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      pickedDate = value;
      dateController.text = DateFormat.yMMMd().format(pickedDate);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                    prefixText: getCurrencySymbol(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  onFieldSubmitted: (_) => startDatePicker(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Amount cannot be empty';
                    }
                    final price = double.tryParse(value);
                    if (price == null) {
                      return 'Please enter numbers only';
                    }
                    if (price <= 0) {
                      return 'Price must be greater than 0';
                    }
                    if (price >= 1000000) {
                      return 'Price must be less than 100,00,00';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 30,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: dateController,
                          decoration: InputDecoration(labelText: 'Date'),
                          enableInteractiveSelection: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please pick a date';
                            }
                            return null;
                          },
                        ),
                      ),
                      FlatButton(
                        onPressed: startDatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final entity = await controller.pick(context);
                        if (entity.isNotEmpty) {
                          final file = await entity[0].entity.file;
                          updateImage(file);
                        }
                      },
                      icon: Icon(Icons.image),
                    ),
                    if (imageFile != null)
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.file(imageFile),
                      ),
                    Spacer(),
                    FlatButton(
                      onPressed: onSubmit,
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      color: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
