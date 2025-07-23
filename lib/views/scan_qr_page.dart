import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isScannerActive = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.pauseCamera(); // إيقاف الكاميرا بعد القراءة
    });
  }

  void _startScanner() {
    setState(() {
      result = null;
      isScannerActive = true;
    });
    controller?.resumeCamera();
  }

  void _stopScanner() {
    controller?.pauseCamera();
    setState(() {
      isScannerActive = false;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double unit = MediaQuery.of(context).size.shortestSide * 0.02;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('QR Scanner'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(unit * 2.2),
        child: Column(
          children: [
            // Scanner Container
            Container(
              width: double.infinity,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(unit * 2.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(30, 97, 97, 97),
                    blurRadius: unit * 2,
                    offset: Offset(0, unit),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(unit * 2.5),
                child: isScannerActive
                    ? Stack(
                        children: [
                          QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                          // Scanner overlay
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF00A3A3),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(unit * 2.5),
                            ),
                          ),
                          // Scanning indicator
                          Positioned(
                            bottom: unit * 2,
                            left: 0,
                            right: 0,
                            child: Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: unit * 2),
                              padding: EdgeInsets.symmetric(
                                  horizontal: unit * 2, vertical: unit),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00A3A3).withOpacity(0.9),
                                borderRadius: BorderRadius.circular(unit * 1.5),
                              ),
                              child: Text(
                                'قم بمسح رمز QR',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: unit * 2.2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF00A3A3).withOpacity(0.1),
                              const Color(0xFF107B81).withOpacity(0.05),
                            ],
                          ),
                        ),
                        child: Center(
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
                                  Icons.qr_code_scanner_rounded,
                                  size: unit * 6,
                                  color: const Color(0xFF00A3A3),
                                ),
                              ),
                              SizedBox(height: unit * 3),
                              Text(
                                'اضغط لبدء المسح',
                                style: TextStyle(
                                  fontSize: unit * 2.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0C3954),
                                ),
                              ),
                              SizedBox(height: unit),
                              Text(
                                'ضع رمز QR داخل الإطار للمسح',
                                style: TextStyle(
                                  fontSize: unit * 1.8,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),

            SizedBox(height: unit * 3),

            // Start/Stop Scanner Button
            Container(
              width: double.infinity,
              height: unit * 7,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF00A3A3),
                    const Color(0xFF107B81),
                  ],
                ),
                borderRadius: BorderRadius.circular(unit * 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00A3A3).withOpacity(0.3),
                    blurRadius: unit * 2,
                    offset: Offset(0, unit),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(unit * 2),
                  onTap: isScannerActive ? _stopScanner : _startScanner,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isScannerActive
                              ? Icons.stop_circle_outlined
                              : Icons.qr_code_scanner_rounded,
                          color: Colors.white,
                          size: unit * 3,
                        ),
                        SizedBox(width: unit),
                        Text(
                          isScannerActive ? 'إيقاف المسح' : 'ابدأ المسح',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: unit * 2.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: unit * 3),

            // Result Container
            if (result != null)
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: double.infinity,
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
                padding: EdgeInsets.all(unit * 2.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: unit * 5,
                          height: unit * 5,
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
                            Icons.check_circle_outline,
                            color: const Color(0xFF4CAF50),
                            size: unit * 2.5,
                          ),
                        ),
                        SizedBox(width: unit * 1.5),
                        Text(
                          'تم المسح بنجاح',
                          style: TextStyle(
                            fontSize: unit * 2.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0C3954),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: unit * 2),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(unit * 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(unit * 1.5),
                        border: Border.all(
                          color: const Color(0xFF00A3A3).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'نوع الرمز:',
                            style: TextStyle(
                              fontSize: unit * 1.8,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: unit * 0.5),
                          Text(
                            describeEnum(result!.format),
                            style: TextStyle(
                              fontSize: unit * 2.2,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0C3954),
                            ),
                          ),
                          SizedBox(height: unit * 1.5),
                          Text(
                            'البيانات:',
                            style: TextStyle(
                              fontSize: unit * 1.8,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: unit * 0.5),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(unit * 1.5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(unit),
                              border: Border.all(
                                color: const Color(0xFF00A3A3).withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              result!.code ?? 'لا توجد بيانات',
                              style: TextStyle(
                                fontSize: unit * 2,
                                color: const Color(0xFF0C3954),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: unit * 2),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: unit * 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00A3A3).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(unit * 1.5),
                              border: Border.all(
                                color: const Color(0xFF00A3A3),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(unit * 1.5),
                                onTap: () {
                                  setState(() {
                                    result = null;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    'مسح جديد',
                                    style: TextStyle(
                                      color: const Color(0xFF00A3A3),
                                      fontSize: unit * 2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: unit * 1.5),
                        Expanded(
                          child: Container(
                            height: unit * 6,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  const Color(0xFF00A3A3),
                                  const Color(0xFF107B81),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(unit * 1.5),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(unit * 1.5),
                                onTap: () {
                                  // يمكن إضافة وظيفة نسخ أو مشاركة هنا
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'تم نسخ البيانات',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: const Color(0xFF00A3A3),
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(unit),
                                      ),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    'نسخ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: unit * 2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
