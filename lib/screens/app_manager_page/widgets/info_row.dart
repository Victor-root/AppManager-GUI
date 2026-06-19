part of '../app_manager_page.dart';

extension _InfoRowBuild on _AppManagerPageState {
  TableRow _buildInfoRow(String key, String value) => TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              key,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Text(
                value,
                style: const TextStyle(fontSize: 13, color: Colors.white70),
                softWrap: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: ElevatedButton(
              onPressed: () => _copyToClipboard(value),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(60, 28),
                padding: EdgeInsets.zero,
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(Localization.translate('copy'),
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      );
}
