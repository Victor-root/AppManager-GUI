part of '../../app_manager_page.dart';

extension _SortIconButtonBuild on _AppManagerPageState {
  Widget _buildSortIconButton() {
    final isCustomSort = _sortBy != 'name';
    return Tooltip(
      message: Localization.translate('sort_label'),
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
                  ...sortItems.map(
                    (item) => ListTile(
                      title: Text(
                        Localization.translate(item['text']!),
                        style: TextStyle(
                          color: item['value'] == _sortBy
                              ? Colors.blueAccent
                              : Colors.white,
                          fontWeight: item['value'] == _sortBy
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      trailing: item['value'] == _sortBy
                          ? const Icon(
                            Icons.check,
                            color: Colors.blueAccent,
                            size: 20,
                          )
                          : null,
                      onTap: () {
                        _rebuild(() => _sortBy = item['value']!);
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCustomSort
                ? Colors.blueAccent.withOpacity(0.2)
                : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isCustomSort ? Colors.blueAccent : Colors.white.withOpacity(0.2),
            ),
          ),
          child: Icon(
            Icons.sort,
            color: isCustomSort ? Colors.blueAccent : Colors.white70,
            size: 18,
          ),
        ),
      ),
    );
  }
}
