import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _initialAmountController =
      TextEditingController();

  String? selectedBranch;
  String? selectedAccountType;
  String? selectedCurrency;

  final List<String> branches = ['Benghazi', 'Misurata', 'Tripoli'];
  final List<String> accountTypes = ['Individuals', 'Companies'];
  final List<String> currencies = ['USD', 'LYD'];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Create Account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00A3A3),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Container(
                  height: size.height / 7,
                  width: size.width / 4,
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
                    Icons.account_balance_rounded,
                    size: 45,
                    color: Color(0xFF00A3A3),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Set Up Your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0C3954),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height / 45),
              _buildDropdownField(
                title: 'Select branch',
                value: selectedBranch,
                items: branches,
                icon: Icons.business,
                onChanged: (val) => setState(() => selectedBranch = val),
              ),
              SizedBox(height: size.height / 45),
              _buildDropdownField(
                title: 'Account type',
                value: selectedAccountType,
                items: accountTypes,
                icon: Icons.people_outline,
                onChanged: (val) => setState(() => selectedAccountType = val),
              ),
              SizedBox(height: size.height / 45),
              _buildDropdownField(
                title: 'Currency',
                value: selectedCurrency,
                items: currencies,
                icon: Icons.currency_exchange,
                onChanged: (val) {
                  setState(() {
                    selectedCurrency = val;
                  });
                },
              ),
              SizedBox(height: size.height / 45),
              _buildTextField(
                controller: _initialAmountController,
                hintText: selectedCurrency != null
                    ? 'Initial value in $selectedCurrency (optional)'
                    : 'Initial value (optional)',
                icon: Icons.money,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validatorMessage: null, // optional field
              ),
              SizedBox(height: size.height / 35),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A3A3),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  label: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: size.height / 40),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF00A3A3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.info_outline, color: Color(0xFF00A3A3)),
                        SizedBox(width: 8),
                        Text(
                          'Account Information',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0C3954),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Your account will be secured with advanced encryption\n'
                      '• You can add funds anytime after creation\n'
                      '• All transactions are monitored for security',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required String? value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          icon: Icon(icon, color: const Color(0xFF00A3A3)),
          border: InputBorder.none,
          hintText: title,
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
        validator: (val) => val == null ? 'Please select $title' : null,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? validatorMessage,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: const Color(0xFF00A3A3)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        validator: validatorMessage != null
            ? (val) {
                if (val == null || val.trim().isEmpty) {
                  return validatorMessage;
                }
                return null;
              }
            : null,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final summary = '''
Branch: $selectedBranch
Account type: $selectedAccountType
Currency: $selectedCurrency
Initial value: ${_initialAmountController.text}
Account name: ${_accountNameController.text}
''';

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Account Created'),
          content: Text(summary),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
