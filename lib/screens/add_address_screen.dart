import 'package:flutter/material.dart';
import 'package:groceryapp/components/random_color.dart';
import 'package:groceryapp/components/userJsonFile.dart';

class AddAddressPage extends StatefulWidget {
  final Function(Address) onAddressAdded;
  final bool isDarkMode;

  const AddAddressPage(
      {Key? key, required this.onAddressAdded, required this.isDarkMode})
      : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  String? _selectedAddressType;
  String? _selectedCity;
  String? _selectedState;
  String? _selectedPostalCode;

  final List<String> _addressTypes = [
    'home',
    'workplace',
    'dormitory',
    'other'
  ];

  final Map<String, List<String>> _citiesWithStates = {
    'Istanbul': ['Kadikoy', 'Besiktas', 'Sisli'],
    'Ankara': ['Cankaya', 'Kecioren', 'Mamak'],
    'Izmir': ['Konak', 'Karşıyaka', 'Bornova']
  };

  final Map<String, List<String>> _statesWithPostalCodes = {
    'Kadikoy': ['34710', '34720', '34730'],
    'Besiktas': ['34330', '34340', '34350'],
    'Sisli': ['34360', '34370', '34380'],
    'Cankaya': ['06510', '06520', '06530'],
    'Kecioren': ['06310', '06320', '06330'],
    'Mamak': ['06630', '06640', '06650'],
    'Konak': ['35210', '35220', '35230'],
    'Karşıyaka': ['35530', '35540', '35550'],
    'Bornova': ['35030', '35040', '35050']
  };

  List<String> get _states =>
      _selectedCity != null ? _citiesWithStates[_selectedCity] ?? [] : [];

  List<String> get _postalCodes => _selectedState != null
      ? _statesWithPostalCodes[_selectedState] ?? []
      : [];

  Widget _buildDropdownButton<T>(
      {required String hint,
      required T? value,
      required List<T> items,
      required void Function(T?) onChanged,
      required String? Function(T?) validator}) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(30),
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
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode
              ? Color.fromARGB(255, 23, 23, 23)
              : Color.fromARGB(255, 248, 248, 136),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 249, 252, 255), width: 1.0),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 118, 128, 137), width: 2.0),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        value: value,
        hint: Text(
          hint,
          style: TextStyle(
              color: isDarkMode
                  ? Color.fromARGB(255, 130, 128, 128)
                  : Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildDropdownButton<String>(
                  hint: 'Select Address Type',
                  value: _selectedAddressType,
                  items: _addressTypes,
                  onChanged: (value) {
                    setState(() {
                      _selectedAddressType = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select address type' : null,
                ),
                SizedBox(height: 8),
                _buildDropdownButton<String>(
                  hint: 'Select City',
                  value: _selectedCity,
                  items: _citiesWithStates.keys.toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                      _selectedState = null;
                      _selectedPostalCode = null;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select city' : null,
                ),
                SizedBox(height: 8),
                _buildDropdownButton<String>(
                  hint: 'Select State',
                  value: _selectedState,
                  items: _states,
                  onChanged: (value) {
                    setState(() {
                      _selectedState = value;
                      _selectedPostalCode = null;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select state' : null,
                ),
                SizedBox(height: 8),
                _buildDropdownButton<String>(
                  hint: 'Select Postal Code',
                  value: _selectedPostalCode,
                  items: _postalCodes,
                  onChanged: (value) {
                    setState(() {
                      _selectedPostalCode = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select postal code' : null,
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[850] : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      width: 1,
                      color: getRandomColor(), // Use the imported function
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode
                            ? Color.fromARGB(255, 0, 0, 0)
                            : Color.fromARGB(255, 210, 209, 209)
                                .withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: TextFormField(
                    controller: _streetController,
                    decoration: InputDecoration(
                      labelText: 'Street',
                      labelStyle: TextStyle(
                          color: isDarkMode
                              ? Color.fromARGB(255, 130, 128, 128)
                              : Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      filled: true,
                      fillColor: isDarkMode
                          ? Color.fromARGB(255, 23, 23, 23)
                          : Color.fromARGB(255, 248, 248, 136),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 249, 252, 255),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 118, 128, 137),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    validator: (value) =>
                        value?.isEmpty == true ? 'Please enter street' : null,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? Color.fromARGB(255, 23, 23, 23)
                          : Color.fromARGB(255, 187, 254, 191),
                      side: BorderSide(width: 2, color: getRandomColor()),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                        20,
                      ))),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      final newAddress = Address(
                        addressId: DateTime.now().millisecondsSinceEpoch,
                        addressType: _selectedAddressType!,
                        street: _streetController.text,
                        city: _selectedCity!,
                        state: _selectedState!,
                        postalCode: _selectedPostalCode!,
                      );
                      widget.onAddressAdded(newAddress);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Add Address',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
