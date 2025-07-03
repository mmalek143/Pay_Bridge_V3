import 'package:flutter/material.dart';

class TransferMoneyPage extends StatefulWidget {
  const TransferMoneyPage({super.key});

  @override
  State<TransferMoneyPage> createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _recipientIdController = TextEditingController();
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _selectedCurrency = 'USD';
  final List<String> _currencies = ['USD', 'LYD'];

  // Currency symbol mapping
  final Map<String, String> _currencySymbols = {
    'USD': '\$',
    'LYD': 'ل.د',
  };

  @override
  void dispose() {
    _recipientIdController.dispose();
    _recipientNameController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transfer Money",
          style: TextStyle(
            color: Color.fromARGB(
              255,
              255,
              255,
              255,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF107B81),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color.fromARGB(
            255,
            255,
            255,
            255,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Send Money Securely",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF107B81),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Fill in recipient details and transfer amount",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),

                // Recipient ID Field
                TextFormField(
                  controller: _recipientIdController,
                  decoration: InputDecoration(
                    labelText: "Recipient ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person_outline),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter recipient ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Recipient Name Field
                TextFormField(
                  controller: _recipientNameController,
                  decoration: InputDecoration(
                    labelText: "Recipient Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter recipient name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Amount and Currency Fields
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Amount Field
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: "Amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixText:
                              "${_currencySymbols[_selectedCurrency]!} ",
                          prefixStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Currency Dropdown
                    Expanded(
                      flex: 2,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCurrency,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 0,
                            isExpanded: true,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCurrency = newValue!;
                              });
                            },
                            items: _currencies
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Note Field
                TextFormField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Note (optional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 40),

                // Transfer Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () => _processTransfer(context),
                    icon: const Icon(
                      Icons.send,
                      size: 24,
                      color: Color.fromARGB(
                        255,
                        255,
                        255,
                        255,
                      ),
                    ),
                    label: const Text(
                      "TRANSFER",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF107B81),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _processTransfer(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Success case
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Transferred ${_currencySymbols[_selectedCurrency]}${_amountController.text} to ${_recipientNameController.text}",
            style: const TextStyle(fontSize: 16),
          ),
          backgroundColor: const Color(0xFF107B81),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      // Clear form after successful transfer
      Future.delayed(const Duration(seconds: 3), () {
        _formKey.currentState!.reset();
        setState(() => _selectedCurrency = 'USD');
      });
    }
  }
}
