import 'package:flutter/material.dart';
import 'package:pay_bridge/components/transaction_item.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'all';
  String selectedSort = 'newest';
  bool isSearching = false;

  // بيانات المعاملات التجريبية
  final List<Map<String, dynamic>> allTransactions = [
    {
      'id': 'TXN001',
      'type': 'transfer_sent',
      'title': 'تحويل إلى أحمد محمد',
      'amount': -250.00,
      'currency': 'LYD',
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'status': 'completed',
      'category': 'transfer',
      'description': 'دفع فاتورة الكهرباء',
      'reference': 'REF123456',
      'account': 'الحساب الرئيسي',
    },
    {
      'id': 'TXN002',
      'type': 'transfer_received',
      'title': 'تحويل من سارة أحمد',
      'amount': 500.00,
      'currency': 'USD',
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'status': 'completed',
      'category': 'transfer',
      'description': 'راتب شهر يناير',
      'reference': 'REF789012',
      'account': 'حساب الدولار',
    },
    {
      'id': 'TXN003',
      'type': 'payment',
      'title': 'دفع فاتورة الإنترنت',
      'amount': -75.00,
      'currency': 'LYD',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'status': 'completed',
      'category': 'bills',
      'description': 'فاتورة شهر ديسمبر',
      'reference': 'BILL345678',
      'account': 'الحساب الرئيسي',
    },
    {
      'id': 'TXN004',
      'type': 'qr_payment',
      'title': 'دفع عبر QR - مطعم البحر',
      'amount': -120.00,
      'currency': 'LYD',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'status': 'completed',
      'category': 'food',
      'description': 'وجبة عشاء',
      'reference': 'QR901234',
      'account': 'الحساب الرئيسي',
    },
    {
      'id': 'TXN005',
      'type': 'deposit',
      'title': 'إيداع نقدي',
      'amount': 1000.00,
      'currency': 'LYD',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'status': 'completed',
      'category': 'deposit',
      'description': 'إيداع من الفرع الرئيسي',
      'reference': 'DEP567890',
      'account': 'الحساب الرئيسي',
    },
    {
      'id': 'TXN006',
      'type': 'transfer_sent',
      'title': 'تحويل إلى محمد علي',
      'amount': -300.00,
      'currency': 'EUR',
      'date': DateTime.now().subtract(const Duration(days: 15)),
      'status': 'pending',
      'category': 'transfer',
      'description': 'دفع مقدم شراء',
      'reference': 'REF234567',
      'account': 'حساب اليورو',
    },
    {
      'id': 'TXN007',
      'type': 'withdrawal',
      'title': 'سحب نقدي - ATM',
      'amount': -200.00,
      'currency': 'LYD',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'status': 'completed',
      'category': 'withdrawal',
      'description': 'سحب من ماكينة الصراف',
      'reference': 'ATM678901',
      'account': 'الحساب الرئيسي',
    },
  ];

  List<Map<String, dynamic>> filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    filteredTransactions = List.from(allTransactions);
    _sortTransactions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTransactions() {
    setState(() {
      filteredTransactions = allTransactions.where((transaction) {
        // تصفية حسب النوع
        bool matchesFilter = true;
        if (selectedFilter != 'all') {
          switch (selectedFilter) {
            case 'sent':
              matchesFilter = transaction['amount'] < 0;
              break;
            case 'received':
              matchesFilter = transaction['amount'] > 0;
              break;
            case 'pending':
              matchesFilter = transaction['status'] == 'pending';
              break;
            case 'completed':
              matchesFilter = transaction['status'] == 'completed';
              break;
          }
        }

        // تصفية حسب البحث
        bool matchesSearch = true;
        if (_searchController.text.isNotEmpty) {
          final searchTerm = _searchController.text.toLowerCase();
          matchesSearch = transaction['title']
                  .toLowerCase()
                  .contains(searchTerm) ||
              transaction['description'].toLowerCase().contains(searchTerm) ||
              transaction['reference'].toLowerCase().contains(searchTerm);
        }

        return matchesFilter && matchesSearch;
      }).toList();

      _sortTransactions();
    });
  }

  void _sortTransactions() {
    setState(() {
      switch (selectedSort) {
        case 'newest':
          filteredTransactions.sort((a, b) => b['date'].compareTo(a['date']));
          break;
        case 'oldest':
          filteredTransactions.sort((a, b) => a['date'].compareTo(b['date']));
          break;
        case 'amount_high':
          filteredTransactions
              .sort((a, b) => b['amount'].abs().compareTo(a['amount'].abs()));
          break;
        case 'amount_low':
          filteredTransactions
              .sort((a, b) => a['amount'].abs().compareTo(b['amount'].abs()));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final unit = size.shortestSide * 0.02;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('Transactions'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(unit * 2.2),
        child: Column(
          children: [
            // Search Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(unit * 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(30, 97, 97, 97),
                    blurRadius: unit * 1.5,
                    offset: Offset(0, unit * 0.5),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _filterTransactions(),
                decoration: InputDecoration(
                  hintText: "ابحث حسب التاريخ أو القيمة",
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: unit * 2,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color(0xFF00A3A3),
                    size: unit * 3,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(unit * 2),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: unit * 2,
                    vertical: unit * 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: unit * 2),
            Row(
              children: [
                Expanded(child: _buildFilterDropdown()),
                SizedBox(width: unit * 0.6),
                Expanded(child: _buildSortDropdown()),
              ],
            ),
            SizedBox(height: unit * 2),
            Expanded(
              child: filteredTransactions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: unit * 12,
                            height: unit * 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF00A3A3).withOpacity(0.2),
                                  const Color(0xFF107B81).withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: Icon(
                              Icons.receipt_long_outlined,
                              size: unit * 6,
                              color: const Color(0xFF00A3A3),
                            ),
                          ),
                          SizedBox(height: unit * 2),
                          Text(
                            'لا توجد نتائج مطابقة',
                            style: TextStyle(
                              fontSize: unit * 2.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0C3954),
                            ),
                          ),
                          SizedBox(height: unit),
                          Text(
                            'جرب تغيير معايير البحث أو التصفية',
                            style: TextStyle(
                              fontSize: unit * 1.8,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = filteredTransactions[index];
                        final isIncome = transaction['amount'] > 0;
                        final amount = transaction['amount'].abs();
                        final currency = transaction['currency'];
                        final date = transaction['date'] as DateTime;

                        return Container(
                          margin: EdgeInsets.only(bottom: unit * 0.2),
                          child: TransactionItem.buildItem(
                            size: size,
                            type: isIncome ? 'in' : 'out',
                            amount:
                                '${isIncome ? '+' : '-'}${amount.toStringAsFixed(2)} $currency',
                            date: _formatDate(date),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    final unit = MediaQuery.sizeOf(context).shortestSide * 0.02;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(unit * 2),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(30, 97, 97, 97),
            blurRadius: unit * 1.5,
            offset: Offset(0, unit * 0.5),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: selectedFilter,
        decoration: InputDecoration(
          hintText: 'تصفية',
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: unit * 2,
          ),
          prefixIcon: Icon(
            Icons.filter_list_rounded,
            color: const Color(0xFF00A3A3),
            size: unit * 2.5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(unit * 2),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: unit * 2,
            vertical: unit * 1.5,
          ),
        ),
        items: [
          DropdownMenuItem(
            value: 'all',
            child: Text(
              'جميع المعاملات',
              style: TextStyle(
                fontSize: unit * 2,
                color: const Color(0xFF0C3954),
              ),
            ),
          ),
          DropdownMenuItem(
            value: 'sent',
            child: Text(
              'المرسلة',
              style: TextStyle(
                fontSize: unit * 2,
                color: const Color(0xFF0C3954),
              ),
            ),
          ),
          DropdownMenuItem(
            value: 'received',
            child: Text(
              'المستلمة',
              style: TextStyle(
                fontSize: unit * 2,
                color: const Color(0xFF0C3954),
              ),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedFilter = value!;
            _filterTransactions();
          });
        },
      ),
    );
  }

  Widget _buildSortDropdown() {
    final unit = MediaQuery.sizeOf(context).shortestSide * 0.02;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(unit * 2),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(30, 97, 97, 97),
            blurRadius: unit * 1.5,
            offset: Offset(0, unit * 0.5),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: selectedSort,
        decoration: InputDecoration(
          hintText: 'ترتيب',
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: unit * 2,
          ),
          prefixIcon: Icon(
            Icons.sort_rounded,
            color: const Color(0xFF00A3A3),
            size: unit * 2.5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(unit * 2),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: unit * 2,
            vertical: unit * 1.5,
          ),
        ),
        items: [
          DropdownMenuItem(
            value: 'newest',
            child: Text(
              'الأحدث أولاً',
              style: TextStyle(
                fontSize: unit * 2,
                color: const Color(0xFF0C3954),
              ),
            ),
          ),
          DropdownMenuItem(
            value: 'oldest',
            child: Text(
              'الأقدم أولاً',
              style: TextStyle(
                fontSize: unit * 2,
                color: const Color(0xFF0C3954),
              ),
            ),
          ),
          DropdownMenuItem(
            value: 'amount_high',
            child: Text(
              'المبلغ (عالي)',
              style: TextStyle(
                fontSize: unit * 2,
                color: const Color(0xFF0C3954),
              ),
            ),
          ),
          DropdownMenuItem(
            value: 'amount_low',
            child: Text(
              'المبلغ (منخفض)',
              style: TextStyle(
                fontSize: unit * 2,
                color: const Color(0xFF0C3954),
              ),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedSort = value!;
            _sortTransactions();
          });
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return 'منذ ${difference.inMinutes} دقيقة';
      }
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
