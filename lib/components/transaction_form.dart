import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptative_button.dart';
import 'adaptative_datepicker.dart';
import 'adaptative_textfield.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  final FocusNode _titleFocus = FocusNode();

  final FocusNode _valueFocus = FocusNode();

  _submitForm([BuildContext context, currentFocus]) {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(_titleFocus);
      return;
    }

    if (value <= 0) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(_valueFocus);
      return;
    }

    if (_selectedDate == null) return;

    //if (title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding:
            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0), // content padding
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: <Widget>[
                AdaptativeTextField(
                  textEditingController: _titleController,
                  label: 'Título',
                  focusNode: _titleFocus,
                  onSubmitted: _submitForm,
                ),
                AdaptativeTextField(
                  textEditingController: _valueController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  label: 'Valor (R\$)',
                  focusNode: _valueFocus,
                  onSubmitted: _submitForm,
                ),
                AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChanged: (value) {
                    setState(() {
                      _selectedDate = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    AdaptativeButton(
                      label: 'Nova Transação',
                      onPress: () => _submitForm(context, _titleFocus),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
