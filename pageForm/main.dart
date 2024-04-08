import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Form',
      home: AppBarForm(),
    );
  }
}

class AppBarForm extends StatelessWidget {
  const AppBarForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              const Text('Application', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.grey,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
        body: ListView(
          children: const <Widget>[
            PersonalInfo(),
            ResidenceAddress(),
            ButtonSend(),
          ],
        ));
  }
}

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Personal info',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'First name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Last name',
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Birthday',
                      ),
                    ),
                    const Text(
                      'MM/DD/YYYY',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Social Security',
                      ),
                    ),
                    const Text(
                      '###-##-####',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResidenceAddress extends StatelessWidget {
  const ResidenceAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Residence Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Address',
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'City',
                  ),
                ),
              ),
              const SizedBox(width: 10), // Add this line
              Expanded(
                child: DropdownButton<String>(
                  value: null,
                  isExpanded: true,
                  underline: Container(),
                  hint: const Text('State'),
                  onChanged: (_) {},
                  items: const [
                    DropdownMenuItem<String>(value: "State 1", child: Text("State 1")),
                    DropdownMenuItem<String>(value: "State 2", child: Text("State 2")),
                  ],
                 ),
                ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'ZIP Code',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButton<String>(
                  value: null,
                  isExpanded: true,
                  underline: Container(),
                  hint: const Text('Country'),
                  onChanged: (_) {},
                  items: const [
                    DropdownMenuItem<String>(value: "Country 1", child: Text("Country 1")),
                    DropdownMenuItem<String>(value: "Country 2", child: Text("Country 2")),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonSend extends StatelessWidget {
  const ButtonSend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {},
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}