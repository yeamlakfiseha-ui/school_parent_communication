/// Formats message timestamps consistently across the messaging UI.
String formatMessageTime(DateTime timestamp, {DateTime? now}) {
  final reference = now ?? DateTime.now();
  final today = DateTime(reference.year, reference.month, reference.day);
  final messageDay = DateTime(timestamp.year, timestamp.month, timestamp.day);
  final differenceDays = today.difference(messageDay).inDays;

  if (differenceDays == 0) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
  if (differenceDays == 1) {
    return 'Yesterday';
  }
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[timestamp.month - 1]} ${timestamp.day}';
}
