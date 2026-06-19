import 'package:app_manager/utils/localization.dart';
import 'package:flutter/material.dart';

enum ViewMode { list, mosaic }

class ViewSelector extends StatelessWidget {
  final ViewMode currentMode;
  final Function(ViewMode) onModeChanged;
  final bool showIcons;
  final Function(bool) onShowIcons;

  const ViewSelector({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
    required this.showIcons,
    required this.onShowIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          _viewModeOption(
              ViewMode.list,
              Icons.view_list_rounded,
              Localization.translate('list_view'),
              Localization.translate('list_view_tooltip')),
          const SizedBox(width: 3),
          _viewModeOption(
              ViewMode.mosaic,
              Icons.grid_view_rounded,
              Localization.translate('mosaic_view'),
              Localization.translate('mosaic_view_tooltip')),
        ],
      ),
    );
  }

  Widget _viewModeOption(
      ViewMode mode, IconData icon, String label, String tooltip) {
    final selected = currentMode == mode;
    return Expanded(
      child: Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: () async {
            onModeChanged(mode);
            if (mode == ViewMode.mosaic && !showIcons) {
              onShowIcons(true);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              color: selected ? Colors.blueAccent : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    size: 16, color: selected ? Colors.white : Colors.white60),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      color: selected ? Colors.white : Colors.white60,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
