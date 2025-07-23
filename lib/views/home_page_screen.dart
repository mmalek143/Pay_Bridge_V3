import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pay_bridge/components/button_center_homrpage.dart';
import 'package:pay_bridge/components/card.dart';
import 'package:pay_bridge/views/create_account_currency.dart';
import 'package:pay_bridge/views/notification.dart';
import 'package:pay_bridge/components/transaction_item.dart';

class HomePageScreen extends StatefulWidget {
  final Size size;
  const HomePageScreen({super.key, required this.size});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int selectedIndex = 0;
  PageController pageController = PageController();
  bool isRefreshing = false;

  final List<List<Map<String, dynamic>>> cardTransactions = [
    [
      {'type': 'in', 'amount': '+200 USD', 'date': '20/3/2025 18:00:00'},
      {'type': 'out', 'amount': '-100 USD', 'date': '15/3/2025 14:30:00'},
      {'type': 'in', 'amount': '+500 USD', 'date': '10/3/2025 12:15:00'},
    ],
    [
      {'type': 'out', 'amount': '-75 EUR', 'date': '18/3/2025 16:45:00'},
      {'type': 'in', 'amount': '+300 EUR', 'date': '12/3/2025 09:30:00'},
      {'type': 'out', 'amount': '-150 EUR', 'date': '08/3/2025 14:20:00'},
    ],
    [
      {'type': 'in', 'amount': '+0 LYD', 'date': 'No transactions yet'},
      {'type': 'in', 'amount': '+0 LYD', 'date': 'No transactions yet'},
      {'type': 'in', 'amount': '+0 LYD', 'date': 'No transactions yet'},
    ],
  ];

  final List<Map<String, dynamic>> fixedButtons = [
    {'title': 'TRANSFER', 'icon': Icons.send_rounded, 'route': 'transfer_page'},
    {
      'title': 'GENERATE QR',
      'icon': Icons.qr_code_2_rounded,
      'route': 'generate_qr_page'
    },
    {
      'title': 'REQUESTS',
      'icon': Icons.mail_outline_rounded,
      'route': 'requests_page'
    },
  ];

  Future<void> _refreshData() async {
    setState(() => isRefreshing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isRefreshing = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('تم تحديث البيانات بنجاح',
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF00A3A3),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final unit = widget.size.shortestSide * 0.02;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(top: unit),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("images/logo1.png", height: unit * 6),
              IconButton(
                icon: Icon(Icons.notifications_outlined,
                    size: unit * 4.5, color: const Color(0xFF00A3A3)),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const Notifications(),
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: const Color(0xFF00A3A3),
        backgroundColor: const Color(0xFFF8F9FA),
        strokeWidth: 3,
        displacement: unit * 4,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: unit * 28,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) => setState(() => selectedIndex = index),
                children: [
                  CardWidget(
                    cardIndex: 0,
                    size: widget.size,
                    amount: 5000.25,
                    cardHolder: "Malek Fouzi Aburayan",
                    currencyType: "Dinar",
                  ),
                  CardWidget(
                    cardIndex: 1,
                    size: widget.size,
                    amount: 5000.25,
                    cardHolder: "Motasem Saleh Saklul",
                    currencyType: "Dollar",
                  ),
                  const CreateAccountCurrency(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return GestureDetector(
                  onTap: () => pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: unit),
                    width: selectedIndex == index ? unit * 2.4 : unit * 1.2,
                    height: unit * 1.2,
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? const Color(0xFF00A3A3)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(unit * 0.6),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: unit),
            if (selectedIndex != 2)
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: unit, horizontal: unit * 2.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: fixedButtons.map((button) {
                        return ButtonList(
                          size: widget.size,
                          title: button['title'],
                          icon: button['icon'],
                          onPress: () {
                            Navigator.of(context).pushNamed(button['route']);
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: unit * 2),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        key: ValueKey('transactions_$selectedIndex'),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(unit * 2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(30, 97, 97, 97),
                              blurRadius: unit * 2,
                              offset: Offset(0, unit),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: unit * 2, vertical: unit * 1),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Last Transactions",
                                  style: TextStyle(
                                    fontSize: unit * 2.9,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0C3954),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: unit * 1),
                            SizedBox(
                              height: unit * 32,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cardTransactions[selectedIndex]
                                    .take(3)
                                    .length,
                                itemBuilder: (context, index) {
                                  final transaction =
                                      cardTransactions[selectedIndex][index];

                                  return TransactionItem.buildItem(
                                    size: widget.size,
                                    type: transaction['type'],
                                    amount: transaction['amount'],
                                    date: transaction['date'],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

// ضع ودجت transferIn و tranferOut هنا أيضًا بعد التعديل إن أردت تضمينها بشكل كامل

//عمليات المعاملات
Widget transferIn(Size size, String amount, String date) {
  final double unit = size.shortestSide * 0.02;

  return Container(
    margin: EdgeInsets.only(bottom: unit * 1.5),
    decoration: BoxDecoration(
      color: const Color(0xFFF0FFF4),
      borderRadius: BorderRadius.circular(unit * 1.5),
      border: Border.all(
        color: const Color(0xFF4CAF50).withOpacity(0.2),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF4CAF50).withOpacity(0.1),
          blurRadius: unit * 2,
          offset: Offset(0, unit),
        )
      ],
    ),
    child: ListTile(
      leading: Container(
        width: unit * 5.5,
        height: unit * 5.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF4CAF50).withOpacity(0.2),
              const Color(0xFF4CAF50).withOpacity(0.1),
            ],
          ),
        ),
        child: Icon(
          Icons.arrow_downward_rounded,
          color: const Color(0xFF4CAF50),
          size: unit * 2.2,
        ),
      ),
      title: Text(
        "TRANSFER IN",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0C3954),
          fontSize: unit * 2.2,
        ),
      ),
      subtitle: Text(
        date,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: unit * 1.6,
        ),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: unit * 1.5, vertical: unit),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(unit * 2),
        ),
        child: Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: unit * 1.6,
            color: const Color(0xFF4CAF50),
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: unit * 2),
    ),
  );
}

Widget tranferOut(Size size, String amount, String date) {
  final double unit = size.shortestSide * 0.02;

  return Container(
    margin: EdgeInsets.only(bottom: unit * 1.5),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF5F5),
      borderRadius: BorderRadius.circular(unit * 1.5),
      border: Border.all(
        color: const Color(0xFFF44336).withOpacity(0.2),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFF44336).withOpacity(0.1),
          blurRadius: unit * 2,
          offset: Offset(0, unit),
        )
      ],
    ),
    child: ListTile(
      leading: Container(
        width: unit * 5.5,
        height: unit * 5.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFF44336).withOpacity(0.2),
              const Color(0xFFF44336).withOpacity(0.1),
            ],
          ),
        ),
        child: Icon(
          Icons.arrow_upward_rounded,
          color: const Color(0xFFF44336),
          size: unit * 2.2,
        ),
      ),
      title: Text(
        "TRANSFER OUT",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0C3954),
          fontSize: unit * 2.2,
        ),
      ),
      subtitle: Text(
        date,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: unit * 1.6,
        ),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: unit * 1.5, vertical: unit),
        decoration: BoxDecoration(
          color: const Color(0xFFF44336).withOpacity(0.1),
          borderRadius: BorderRadius.circular(unit * 2),
        ),
        child: Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: unit * 1.6,
            color: const Color(0xFFF44336),
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: unit * 2,
      ),
    ),
  );
}
