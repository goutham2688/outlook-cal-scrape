import 'package:flutter/material.dart';
import 'package:flutter_application_1/modal/configs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cal_list_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to get input values
  final TextEditingController _binIdController = TextEditingController();
  final TextEditingController _accKeyController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _updateIntialValueInControllers() {
    BlocProvider.of<CalListCubit>(context).getConfigurationData().then(
      (value) {
        _binIdController.text = value.binId ?? '';
        _accKeyController.text = value.accessKey ?? '';
        _passController.text = value.fernetEncryptionKey ?? '';
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final configData = Configs(
          binId: _binIdController.text,
          accessKey: _accKeyController.text,
          fernetEncryptionKey: _passController.text);
      BlocProvider.of<CalListCubit>(context).saveConfigurationData(configData);
    }
  }

  @override
  void dispose() {
    _binIdController.dispose();
    _accKeyController.dispose();
    _passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateIntialValueInControllers();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Scraped Calendar'),
        backgroundColor: Colors.grey.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // binId Field
              TextFormField(
                controller: _binIdController,
                decoration: const InputDecoration(labelText: 'BIN_ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // access key Field
              TextFormField(
                controller: _accKeyController,
                decoration: const InputDecoration(labelText: 'X-Access-Key'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password Field
              TextFormField(
                controller: _passController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                  'BinID and AccessKey can be pulled from your jsonbin.io account. '
                  'Password is what you have set in the python side'),
            ],
          ),
        ),
      ),
    );
  }
}
