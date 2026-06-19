part of '../../app_manager_page.dart';

extension _BottomDropdownBuild on _AppManagerPageState {
  Widget _buildBottomDropdown({
    required String label,
    required String? value,
    required List<Map<String, String>> items,
    required void Function(String?) onChanged,
  }) =>
  FadeIn(
    duration: const Duration(milliseconds: 300),
    child: GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => Material(
            color: Colors.grey[850]!.withOpacity(0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                ...items.map(
                  (item) => ListTile(
                    title: Text(
                      Localization.translate(item['text']!),
                      style: TextStyle(
                        color: item['value'] == value
                            ? Colors.blueAccent
                            : Colors.white,
                        fontWeight: item['value'] == value
                            ? FontWeight.w600
                            : FontWeight.w400,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: item['value'] == value
                        ? const Icon(
                          Icons.check,
                          color: Colors.blueAccent,
                          size: 20,
                        )
                        : null,
                    onTap: () {
                      onChanged(item['value']);
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                Localization.translate(items.firstWhere(
                    (item) => item['value'] == value,
                    orElse: () => {'text': label})['text']!
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.white70,
              size: 18,
            ),
          ],
        ),
      ),
    ),
  );
}
