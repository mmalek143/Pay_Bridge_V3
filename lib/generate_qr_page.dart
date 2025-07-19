import 'package:flutter/material.dart';
import 'package:pay_bridge/components/animated_custom_dropdown.dart';
import 'package:pay_bridge/components/custom_text_field.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrPage extends StatefulWidget {
  const GenerateQrPage({super.key});

  @override
  State<GenerateQrPage> createState() => _GenerateQrPageEnhancedState();
}

class _GenerateQrPageEnhancedState extends State<GenerateQrPage> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _qrData;
  bool _isQrGenerated = false;

  String _selectedCurrency = 'USD';
  final List<String> _currencies = ['USD', 'LYD'];

  // Currency symbol mapping
  final Map<String, String> _currencySymbols = {
    'USD': '\$',
    'LYD': 'D.L',
  };

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _generateQr() {
    if (_formKey.currentState!.validate()) {
      final qrData = "${_amountController.text} $_selectedCurrency";

      setState(() {
        _qrData = qrData;
        _isQrGenerated = true;
      });

      // Clear the input field after generating QR
      _amountController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('QR Code generated successfully!'),
          backgroundColor: const Color(0xFF00A3A3),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unit = size.shortestSide * 0.02;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Generate QR'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Center(
                child: Container(
                  width: unit * 13,
                  height: unit * 13,
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
                    Icons.qr_code_2_rounded,
                    size: 60,
                    color: Color(0xFF00A3A3),
                  ),
                ),
              ),
              SizedBox(height: unit * 2),
              const Center(
                child: Text(
                  'Generate Payment QR',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C3954),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: unit),
              const Center(
                child: Text(
                  'Create a QR code to receive payments',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: unit * 3),

              // Amount Section
              _buildAmountField(),
              SizedBox(height: unit * 3),

              // Generate Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _generateQr,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF107B81),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.qr_code_2_rounded, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        _isQrGenerated ? 'Update QR Code' : 'Generate QR Code',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: unit * 3),

              // QR Code Display
              if (_qrData != null) _buildQrDisplay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Amount Field with currency symbol
        Expanded(
          flex: 4,
          child: CustomTextField(
            controller: _amountController,
            labelText: "Amount",
            prefixText: "${_currencySymbols[_selectedCurrency]} ",
            prefixStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter amount';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter valid number';
              }
              if (double.parse(value) <= 0) {
                return 'Amount must be greater than zero';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 12),

        // Currency Dropdown
        Expanded(
            flex: 3,
            child: SimpleDropdown(
              items: _currencies,
              initialItem: _selectedCurrency,
              onChanged: (value) {
                setState(() {
                  _selectedCurrency = value;
                });
              },
            ))
      ],
    );
  }

  Widget _buildQrDisplay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Scan to Pay',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C3954),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: const Color(0xFF00A3A3).withOpacity(0.2)),
            ),
            child: QrImageView(
              data: _qrData!,
              version: QrVersions.auto,
              size: 200,
              gapless: false,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Color(0xFF00A3A3),
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: Color(0xFF0C3954),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _qrData!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00A3A3),
            ),
          ),
        ],
      ),
    );
  }
}
