import 'package:flutter/material.dart';
import 'package:pay_bridge/components/animated_custom_dropdown.dart';
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

  // متغيرات منتقي التاريخ
  DateTime? startDate;
  DateTime? endDate;
  bool isDateFilterActive = false;

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
    super.dispose();
  }

  // دالة عرض حوار منتقي التاريخ
  // why future ??
  Future<void> _showDateRangeDialog() async {
    final unit = MediaQuery.sizeOf(context).shortestSide * 0.02;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        DateTime? tempStartDate = startDate;
        DateTime? tempEndDate = endDate;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(unit * 3),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                padding: EdgeInsets.all(unit * 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(unit * 3),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // عنوان الحوار
                    Row(
                      children: [
                        Icon(
                          Icons.date_range_rounded,
                          color: const Color(0xFF00A3A3),
                          size: unit * 3,
                        ),
                        SizedBox(width: unit),
                        Expanded(
                          child: Text(
                            'تصفية حسب التاريخ',
                            style: TextStyle(
                              fontSize: unit * 2.5,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0C3954),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.close_rounded,
                            color: Colors.grey[600],
                            size: unit * 2.5,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    SizedBox(height: unit * 3),

                    // تاريخ البداية
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(unit * 2),
                        border: Border.all(
                          color: tempStartDate != null
                              ? const Color(0xFF00A3A3).withOpacity(0.5)
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.calendar_today_rounded,
                          color: const Color(0xFF00A3A3),
                          size: unit * 2.5,
                        ),
                        title: Text(
                          'من تاريخ',
                          style: TextStyle(
                            fontSize: unit * 2,
                            color: const Color(0xFF0C3954),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          tempStartDate != null
                              ? '${tempStartDate!.day}/${tempStartDate!.month}/${tempStartDate!.year}'
                              : 'اختر تاريخ البداية',
                          style: TextStyle(
                            fontSize: unit * 1.8,
                            color: tempStartDate != null
                                ? const Color(0xFF0C3954)
                                : Colors.grey[600],
                          ),
                        ),
                        trailing: tempStartDate != null
                            ? IconButton(
                                onPressed: () {
                                  setDialogState(() {
                                    tempStartDate = null;
                                  });
                                },
                                icon: Icon(
                                  Icons.clear_rounded,
                                  color: Colors.grey[600],
                                  size: unit * 2,
                                ),
                              )
                            : null,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: tempStartDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: tempEndDate ?? DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color(0xFF00A3A3),
                                    onPrimary: Colors.white,
                                    surface: Colors.white,
                                    onSurface: Color(0xFF0C3954),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setDialogState(() {
                              tempStartDate = picked;
                              // إذا كان تاريخ النهاية أقل من تاريخ البداية، قم بإعادة تعيينه
                              if (tempEndDate != null &&
                                  tempEndDate!.isBefore(picked)) {
                                tempEndDate = null;
                              }
                            });
                          }
                        },
                      ),
                    ),

                    SizedBox(height: unit * 2),

                    // تاريخ النهاية
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(unit * 2),
                        border: Border.all(
                          color: tempEndDate != null
                              ? const Color(0xFF00A3A3).withOpacity(0.5)
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.event_rounded,
                          color: const Color(0xFF00A3A3),
                          size: unit * 2.5,
                        ),
                        title: Text(
                          'إلى تاريخ',
                          style: TextStyle(
                            fontSize: unit * 2,
                            color: const Color(0xFF0C3954),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          tempEndDate != null
                              ? '${tempEndDate!.day}/${tempEndDate!.month}/${tempEndDate!.year}'
                              : 'اختر تاريخ النهاية',
                          style: TextStyle(
                            fontSize: unit * 1.8,
                            color: tempEndDate != null
                                ? const Color(0xFF0C3954)
                                : Colors.grey[600],
                          ),
                        ),
                        trailing: tempEndDate != null
                            ? IconButton(
                                onPressed: () {
                                  setDialogState(() {
                                    tempEndDate = null;
                                  });
                                },
                                icon: Icon(
                                  Icons.clear_rounded,
                                  color: Colors.grey[600],
                                  size: unit * 2,
                                ),
                              )
                            : null,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: tempEndDate ?? DateTime.now(),
                            firstDate: tempStartDate ?? DateTime(2020),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color(0xFF00A3A3),
                                    onPrimary: Colors.white,
                                    surface: Colors.white,
                                    onSurface: Color(0xFF0C3954),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setDialogState(() {
                              tempEndDate = picked;
                            });
                          }
                        },
                      ),
                    ),

                    SizedBox(height: unit * 4),

                    // أزرار الحوار
                    Row(
                      children: [
                        // زر مسح الكل
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setDialogState(() {
                                tempStartDate = null;
                                tempEndDate = null;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade400),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(unit * 2),
                              ),
                              padding:
                                  EdgeInsets.symmetric(vertical: unit * 1.5),
                            ),
                            child: Text(
                              'مسح',
                              style: TextStyle(
                                fontSize: unit * 2,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: unit * 1.5),

                        // زر الإلغاء
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF00A3A3)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(unit * 2),
                              ),
                              padding:
                                  EdgeInsets.symmetric(vertical: unit * 1.5),
                            ),
                            child: Text(
                              'إلغاء',
                              style: TextStyle(
                                fontSize: unit * 2,
                                color: const Color(0xFF00A3A3),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: unit * 1.5),

                        // زر التطبيق
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                startDate = tempStartDate;
                                endDate = tempEndDate;
                                isDateFilterActive =
                                    startDate != null || endDate != null;
                                _filterTransactions();
                              });
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00A3A3),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(unit * 2),
                              ),
                              padding:
                                  EdgeInsets.symmetric(vertical: unit * 1.5),
                              elevation: 0,
                            ),
                            child: Text(
                              'تطبيق',
                              style: TextStyle(
                                fontSize: unit * 2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // دالة إلغاء تصفية التاريخ
  void _clearDateFilter() {
    setState(() {
      startDate = null;
      endDate = null;
      isDateFilterActive = false;
      _filterTransactions();
    });
  }

  // دالة إلغاء جميع التصفيات
  void _clearAllFilters() {
    setState(() {
      selectedFilter = 'all';
      _searchController.clear();
      startDate = null;
      endDate = null;
      isDateFilterActive = false;
      _filterTransactions();
    });
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

        // تصفية حسب التاريخ
        bool matchesDate = true;
        if (isDateFilterActive) {
          final transactionDate = transaction['date'] as DateTime;

          if (startDate != null) {
            final startOfDay =
                DateTime(startDate!.year, startDate!.month, startDate!.day);
            matchesDate = matchesDate &&
                transactionDate
                    .isAfter(startOfDay.subtract(const Duration(seconds: 1)));
          }

          if (endDate != null) {
            final endOfDay = DateTime(
                endDate!.year, endDate!.month, endDate!.day, 23, 59, 59);
            matchesDate = matchesDate &&
                transactionDate
                    .isBefore(endOfDay.add(const Duration(seconds: 1)));
          }
        }

        return matchesFilter && matchesDate;
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
    final hasActiveFilters = selectedFilter != 'all' ||
        _searchController.text.isNotEmpty ||
        isDateFilterActive;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('Transactions'),
        centerTitle: true,
        actions: [
          if (hasActiveFilters)
            IconButton(
              onPressed: _clearAllFilters,
              icon: Icon(
                Icons.clear_all_rounded,
                color: const Color(0xFF00A3A3),
              ),
              tooltip: 'مسح جميع التصفيات',
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(unit * 2),
        child: Column(
          children: [
            // صف الفلاتر مع منتقي التاريخ
            Row(
              children: [
                Expanded(flex: 2, child: _buildFilterDropdown()),
                SizedBox(width: unit * 1),
                Expanded(flex: 3, child: _buildSortDropdown()),
              ],
            ),
            SizedBox(height: unit * 1),
            _buildDatePickerButton(),

            // عرض التصفية النشطة للتاريخ
            if (isDateFilterActive) ...[
              SizedBox(height: unit * 1.5),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: unit * 2,
                  vertical: unit * 1,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00A3A3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(unit * 1.5),
                  border: Border.all(
                    color: const Color(0xFF00A3A3).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.date_range_rounded,
                      color: const Color(0xFF00A3A3),
                      size: unit * 2,
                    ),
                    SizedBox(width: unit * 0.5),
                    Expanded(
                      child: Text(
                        'من ${startDate != null ? '${startDate!.day}/${startDate!.month}' : 'البداية'} إلى ${endDate != null ? '${endDate!.day}/${endDate!.month}' : 'النهاية'}',
                        style: TextStyle(
                          fontSize: unit * 1.6,
                          color: const Color(0xFF00A3A3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: unit * 0.5),
                    GestureDetector(
                      onTap: _clearDateFilter,
                      child: Icon(
                        Icons.close_rounded,
                        color: const Color(0xFF00A3A3),
                        size: unit * 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],

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
                          if (hasActiveFilters) ...[
                            SizedBox(height: unit * 2),
                            ElevatedButton.icon(
                              onPressed: _clearAllFilters,
                              icon: Icon(Icons.clear_all_rounded),
                              label: Text('مسح جميع التصفيات'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00A3A3),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(unit * 2),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: unit * 3,
                                  vertical: unit * 1.5,
                                ),
                              ),
                            ),
                          ],
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

  // زر منتقي التاريخ
  Widget _buildDatePickerButton() {
    final unit = MediaQuery.sizeOf(context).shortestSide * 0.02;

    return Container(
      width: unit * 35,
      decoration: BoxDecoration(
        color: isDateFilterActive ? const Color(0xFF00A3A3) : Colors.white,
        borderRadius: BorderRadius.circular(unit * 2),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(30, 97, 97, 97),
            blurRadius: unit * 1.5,
            offset: Offset(0, unit * 0.5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: _showDateRangeDialog,
        icon: Icon(Icons.date_range_rounded),
        label: Text(
          'تصفية حسب التاريخ ',
          style: TextStyle(
            fontSize: unit * 2,
            color: const Color(0xFF0C3954),
          ),
        ),
        style: ElevatedButton.styleFrom(
          iconSize: unit * 2.5,
          iconColor: const Color(0xFF00A3A3),
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(unit * 2),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: unit * 3,
            vertical: unit * 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    final unit = MediaQuery.sizeOf(context).shortestSide * 0.02;

    // خريطة القيم والمناظر بالعربية
    final Map<String, String> filterOptions = {
      'all': 'الكل',
      'sent': 'المرسلة',
      'received': 'المستلمة',
    };

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: unit),
        ),
        Expanded(
          child: SimpleDropdown(
            prefixIcon: Icons.filter_list_rounded,
            items: filterOptions.values.toList(),
            initialItem: filterOptions[selectedFilter]!,
            hintText: 'تصفية',
            onChanged: (selectedArabicLabel) {
              final selectedKey = filterOptions.entries
                  .firstWhere((entry) => entry.value == selectedArabicLabel)
                  .key;

              setState(() {
                selectedFilter = selectedKey;
                _filterTransactions();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSortDropdown() {
    final unit = MediaQuery.sizeOf(context).shortestSide * 0.02;

    final Map<String, String> sortOptions = {
      'newest': 'الأحدث أولاً',
      'oldest': 'الأقدم أولاً',
      'amount_high': 'المبلغ (عالي)',
      'amount_low': 'المبلغ (منخفض)',
    };

    return Row(
      children: [
        Expanded(
          child: SimpleDropdown(
            prefixIcon: Icons.list_alt_rounded,
            items: sortOptions.values.toList(),
            initialItem: sortOptions[selectedSort]!,
            onChanged: (selectedArabicLabel) {
              final selectedKey = sortOptions.entries
                  .firstWhere((entry) => entry.value == selectedArabicLabel)
                  .key;

              setState(() {
                selectedSort = selectedKey;
                _sortTransactions();
              });
            },
          ),
        ),
      ],
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
