part of '../app_manager_page.dart';

extension _AppBarBuild on _AppManagerPageState {
  AppBar _buildAppBar() =>
  AppBar(
    title: FadeIn(
      duration: const Duration(milliseconds: 300),
      child: Text(
        'App Manager',
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        overflow: TextOverflow.ellipsis,
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    flexibleSpace: Container(
      color: Colors.grey[850]!.withOpacity(0.8),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: FadeInRight(
          duration: const Duration(milliseconds: 350),
          child: const DonateButton(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: ValueListenableBuilder<String>(
          valueListenable: Localization.languageNotifier,
          builder: (context, languageCode, child) {
            return FadeInRight(
              duration: const Duration(milliseconds: 300),
              child: Tooltip(
                message: Localization.translate('view_source'),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => UrlUtils.launchUrlOrShow(context, 'https://github.com/BlassGO/AppManager-GUI'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Text(
                        '@BlassGO',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
