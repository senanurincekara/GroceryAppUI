import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groceryapp/components/random_color.dart';
import 'package:groceryapp/screens/add_address_screen.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:groceryapp/components/userJsonFile.dart';

class AddressesPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const AddressesPage(
      {Key? key, required this.isDarkMode, required this.toggleTheme})
      : super(key: key);

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  late bool isDarkMode;
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
    loadJsonData();
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    widget.toggleTheme();
  }

  Future<void> loadJsonData() async {
    try {
      final String response = await rootBundle.loadString('assets/data.json');
      final data = json.decode(response);

      setState(() {
        user = User.fromJson(data['user']);
        isLoading = false;
      });
    } catch (e) {
      print('Error loading JSON data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateJsonFile() async {
    try {
      final path = 'assets/data.json';
      final file = File(path);

      final jsonData = {
        'user': {
          'id': user?.id,
          'name': user?.name,
          'email': user?.email,
          'phone': user?.phone,
          'ProfilImagePath': user?.ProfilImagePath,
          'address': user?.address
              .map((a) => {
                    'addressId': a.addressId,
                    'addressType': a.addressType,
                    'street': a.street,
                    'city': a.city,
                    'state': a.state,
                    'postalCode': a.postalCode,
                  })
              .toList()
        },
        'orders': [],
        'currentOrder': {}
      };

      await file.writeAsString(json.encode(jsonData));
    } catch (e) {
      print('Error updating JSON file: $e');
    }
  }

  void _addAddress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAddressPage(
            onAddressAdded: (address) {
              setState(() {
                user?.address.add(address);
              });
              _updateJsonFile(); // Update the JSON file with the new address
            },
            isDarkMode: isDarkMode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: isDarkMode ? Colors.white : Colors.black),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
            onPressed: _toggleTheme,
          ),
        ],
        title: Text(
          'My Addresses',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: user?.address.length ?? 0,
                    itemBuilder: (context, index) {
                      return AddressTile(
                          address: user!.address[index],
                          isDarkMode: isDarkMode);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? Color.fromARGB(255, 23, 23, 23)
                            : Color.fromARGB(255, 187, 254, 191),
                        side: BorderSide(width: 2, color: getRandomColor()),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                          20,
                        ))),
                    onPressed: _addAddress,
                    child: Text('Add Address'),
                  ),
                ),
              ],
            ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final Address address;
  final bool isDarkMode;

  const AddressTile({Key? key, required this.address, required this.isDarkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: getRandomColor(), // Use the imported function
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Color.fromARGB(255, 0, 0, 0)
                  : Color.fromARGB(255, 210, 209, 209).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
            )
          ],
        ),
        child: ListTile(
          title: Text(address.addressType),
          subtitle: Text(
              '${address.street}, ${address.city}, ${address.state}, ${address.postalCode}'),
          leading: Icon(Icons.location_on),
        ),
      ),
    );
  }
}
