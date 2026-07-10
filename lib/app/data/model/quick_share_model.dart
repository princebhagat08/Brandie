
enum QuickShareTarget {
  instagram,
  whatsapp,
  facebook,
  messenger,
  businessWhatsapp,
  shareChat,
  telegram,
  tiktok,
}


class QuickShareItem {
  final String icon;
  final QuickShareTarget target;
  final String label;

  const QuickShareItem({
    required this.icon,
    required this.target,
    required this.label,
  });
}

class ShareDialogStep {
  final String message;
  final Future<void> Function() action;

  const ShareDialogStep({
    required this.message,
    required this.action,
  });
}