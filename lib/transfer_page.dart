import 'package:flutter/material.dart';
import 'package:pay_bridge/components/animated_custom_dropdown.dart';
import 'package:pay_bridge/components/custom_text_field.dart';

class TransferMoneyPage extends StatefulWidget {
  const TransferMoneyPage({super.key});

  @override
  State<TransferMoneyPage> createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _recipientIdController = TextEditingController();
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

    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transfer Money",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(children: [
                    Container(
                      width: size.width / 2.5,
                      height: size.height / 8,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF00A3A3).withOpacity(0.2),
                            const Color(0xFF00A3A3).withOpacity(0.1),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        size: 60,
                        color: Color(0xFF00A3A3),
                      ),
                    ),
                    SizedBox(height: size.height / 40),
                    Text(
                      "Send Money Securely",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0C3954),
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
                  ]),
                ),
                const SizedBox(height: 32),

                // Recipient ID Field
                CustomTextField(
                  controller: _recipientIdController,
                  labelText: "Recipient ID",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter recipient ID';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Amount Field
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        controller: _amountController,
                        labelText: "Amount",
                        prefixText: "${_currencySymbols[_selectedCurrency]!} ",
                        prefixStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
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
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SimpleDropdown(
                          items: _currencies,
                          initialItem: _selectedCurrency,
                          onChanged: (value) {
                            setState(() {
                              _selectedCurrency = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  controller: _noteController,
                  labelText: "Note (optional)",
                  //     maxLines: 3,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignLabelWithHint: true,
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
            "Transferred ${_currencySymbols[_selectedCurrency]}${_amountController.text}",
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
