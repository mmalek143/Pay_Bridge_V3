import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  //_notifications قائمة لتخزين جميع الإشعارات.
  final List<NotificationItemData> _notifications = [];

  @override
  void initState() {
    super.initState();
    // تُنشئ إشعارات تجريبية عند بدء تشغيل الشاشة.
    _notifications.addAll([
      NotificationItemData(
        id: 1,
        type: 'تحويل ناجح',
        icon: Icons.account_balance_wallet,
        time: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      NotificationItemData(
        id: 2,
        type: 'إيداع جديد',
        icon: Icons.savings,
        time: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationItemData(
        id: 3,
        type: 'طلب صرف',
        icon: Icons.payment,
        time: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NotificationItemData(
        id: 4,
        type: 'عرض خاص',
        icon: Icons.local_offer,
        time: DateTime.now().subtract(const Duration(days: 2)),
      ),
      NotificationItemData(
        id: 5,
        type: 'تحديث النظام',
        icon: Icons.system_update,
        time: DateTime.now().subtract(const Duration(days: 10)),
      )
      // Add more notifications as needed
    ]);
  }

/* تحديث حالة الإشعار إلى "مقروء" عند النقر عليه.

copyWith() تنشئ نسخة جديدة من الإشعار مع تحديث خاصية isRead.
 */
  void _markAsRead(int id) {
    setState(() {
      final index = _notifications.indexWhere((item) => item.id == id);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
      }
    });
  }
//إزالة الإشعار من القائمة عند السحب للحذف.

  void _dismissNotification(int id) {
    setState(() {
      _notifications.removeWhere((item) => item.id == id);
    });
  }

/* 
 تجميع الإشعارات حسب الوقت
تقسم الإشعارات إلى 4 مجموعات حسب الوقت:
 */
  Map<String, List<NotificationItemData>> _groupNotifications() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final lastWeek = today.subtract(const Duration(days: 7));

    Map<String, List<NotificationItemData>> groups = {
      'اليوم': [],
      'أمس': [],
      'الأسبوع الماضي': [],
      'سابقاً': [],
    };

    for (final notification in _notifications) {
      final notificationDate = DateTime(
        notification.time.year,
        notification.time.month,
        notification.time.day,
      );

      if (notificationDate == today) {
        groups['اليوم']!.add(notification);
      } else if (notificationDate == yesterday) {
        groups['أمس']!.add(notification);
      } else if (notificationDate.isAfter(lastWeek)) {
        groups['الأسبوع الماضي']!.add(notification);
      } else {
        groups['سابقاً']!.add(notification);
      }
    }

    // Remove empty groups
    groups.removeWhere((key, value) => value.isEmpty);

    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotifications = _groupNotifications();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F9FF),
              Color(0xFFE6F0FF),
            ],
          ),
        ),
        /* 
  تستدعي _groupNotifications() لتصنيف الإشعارات.
تعرض شريط العنوان مع خلفية متدرجة.
تعرض قائمة بمجموعات الإشعارات.
         */
        child: ListView(
          children: [
            // بناء مجموعة إشعارات (_buildNotificationGroup)
            for (final entry in groupedNotifications.entries)
              _buildNotificationGroup(entry.key, entry.value),
          ],
        ),
      ),
    );
  }

/* 
تعرض عنوان المجموعة (اليوم، أمس، ...)
تعرض الإشعارات باستخدام ListView.separated
shrinkWrap: true لتحسين الأداء
عند النقر على إشعار:
يتم تحديده كمقروء (_markAsRead)
تظهر تفاصيل الإشعار (_showNotificationDetails)
 */
  Widget _buildNotificationGroup(
      String period, List<NotificationItemData> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            period,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0C3954),
            ),
          ),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: notifications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return NotificationItem(
              notification: notification,
              onDismiss: () => _dismissNotification(notification.id),
              onTap: () {
                _markAsRead(notification.id);
                _showNotificationDetails(context, notification);
              },
            );
          },
        ),
      ],
    );
  }

  void _showNotificationDetails(
      BuildContext context, NotificationItemData notification) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "تفاصيل الإشعار",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(12, 57, 84, 1.0),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildDetailRow("نوع العملية:", notification.type),
              _buildDetailRow("المبلغ:", "1,250 دينار"),
              _buildDetailRow(
                  "رقم المرجع:", "#REF-${DateTime.now().millisecond}"),
              _buildDetailRow("الحساب:", "حساب التوفير - **** 4582"),
              _buildDetailRow("الوقت:",
                  "${notification.time.day}/${notification.time.month}/${notification.time.year} - ${notification.time.hour}:${notification.time.minute}"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* 
تخزن معلومات الإشعار
copyWith() تسمح بتحديث الخصائص مع الحفاظ على الثبات (immutability)
 */
class NotificationItemData {
  final int id;
  final String type;
  final IconData icon;
  final DateTime time;
  final bool isRead;

  NotificationItemData({
    required this.id,
    required this.type,
    required this.icon,
    required this.time,
    this.isRead = false,
  });

  NotificationItemData copyWith({
    int? id,
    String? type,
    IconData? icon,
    DateTime? time,
    bool? isRead,
  }) {
    return NotificationItemData(
      id: id ?? this.id,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationItemData notification;
  final VoidCallback onDismiss;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onDismiss,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('notif_${notification.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red[400],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      onDismissed: (direction) {
        onDismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("تم حذف الإشعار"),
            backgroundColor: const Color.fromRGBO(12, 57, 84, 1.0),
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Red dot for unread notifications
              if (!notification.isRead)
                Positioned(
                  top: 16,
                  left: 8,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF107B81).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        notification.icon,
                        color: const Color(0xFF107B81),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.type,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(12, 57, 84, 1.0),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "تمت عملية ${notification.type} بنجاح. اضغط لرؤية التفاصيل",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                _formatTime(notification.time),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
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
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final notificationDate = DateTime(time.year, time.month, time.day);

    if (notificationDate == today) {
      return "اليوم - ${time.hour}:${time.minute.toString().padLeft(2, '0')}";
    } else if (notificationDate == today.subtract(const Duration(days: 1))) {
      return "أمس - ${time.hour}:${time.minute.toString().padLeft(2, '0')}";
    } else {
      return "${time.day}/${time.month}/${time.year} - ${time.hour}:${time.minute.toString().padLeft(2, '0')}";
    }
  }
}
