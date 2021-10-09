import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:likk_picker/likk_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:expense_app/blocs/app_blocs.dart';
import 'package:expense_app/extensions/extensions.dart';
import 'package:expense_app/models/models.dart';

enum NewTransactionState {
  edit,
  add,
}

class NewTransaction extends StatefulWidget {
  final NewTransactionState state;
  final Transaction transaction;

  NewTransaction.add({
    Key key,
  })  : this.state = NewTransactionState.add,
        this.transaction = null,
        super(key: key);

  NewTransaction.edit({
    Key key,
    @required this.transaction,
  })  : this.state = NewTransactionState.edit,
        super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _pickedDate;
  File _imageFile;
  Directory _appLibraryDirectory;
  GalleryController _controller;

  @override
  void initState() {
    super.initState();
    _updateDirectory();
    _controller = GalleryController(
      gallerySetting: GallerySetting(
        enableCamera: true,
        maximum: 1,
        requestType: RequestType.image,
        onItemClick: (entity, list) async {
          if (list.isNotEmpty) {
            final file = await list[0].entity.file;
            _updateImage(file);
            Navigator.pop(context);
          }
        },
      ),
    );

    if (widget.state == NewTransactionState.edit) {
      _titleController.text = widget.transaction.title;
      _amountController.text = widget.transaction.amount.toString();
      _pickedDate = widget.transaction.date;
      _dateController.text = DateFormat.yMMMd().format(_pickedDate);
      widget.transaction.imagePath.isNotEmpty
          ? _imageFile = File(widget.transaction.imagePath)
          : _imageFile = null;
    }
  }

  Future<void> _updateDirectory() async {
    _appLibraryDirectory = await getApplicationDocumentsDirectory();
    _appLibraryDirectory = await _appLibraryDirectory.create();
  }

  void _updateImage(File image) {
    final fileExtension = image.path.split('.').last;
    if (fileExtension == 'jpg' ||
        fileExtension == 'jpeg' ||
        fileExtension == 'png') {
      setState(() {
        _imageFile = image;
      });
    }
  }

  void _onSubmit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    File writtenFile;
    if (_imageFile != null) {
      final imageFilePath = '${_appLibraryDirectory.path}/${Uuid().v4()}.png';
      final emptyFile = await File(imageFilePath).create();
      writtenFile = await emptyFile.writeAsBytes(_imageFile.readAsBytesSync());
    }
    final tBloc = context.read<TransactionsBloc>();
    final transaction = Transaction(
      id: widget.state == NewTransactionState.add
          ? Uuid().v4()
          : widget.transaction.id,
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      date: _pickedDate,
      imagePath: _imageFile == null ? '' : writtenFile.path,
      createdOn: DateTime.now(),
    );
    if (widget.state == NewTransactionState.add) {
      tBloc.add(
        AddTransaction(transaction: transaction),
      );
    } else {
      tBloc.add(
        UpdateTransaction(transaction: transaction),
      );
    }
    Navigator.of(context).pop(transaction);
  }

  void _startDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.parse("2020-01-01 00:00:01Z"),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      _pickedDate = value;
      _dateController.text = DateFormat.yMMMd().format(_pickedDate);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
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
                  controller: _amountController,
                  onFieldSubmitted: (_) => _startDatePicker(),
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
                          controller: _dateController,
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
                        onPressed: _startDatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
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
                        final entity = await _controller.pick(context);
                        if (entity.isNotEmpty) {
                          final file = await entity[0].entity.file;
                          _updateImage(file);
                        }
                      },
                      icon: Icon(Icons.image),
                    ),
                    if (_imageFile != null)
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.file(_imageFile),
                      ),
                    Spacer(),
                    FlatButton(
                      onPressed: _onSubmit,
                      child: Text(
                        widget.state == NewTransactionState.add
                            ? 'Add Transaction'
                            : 'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
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
