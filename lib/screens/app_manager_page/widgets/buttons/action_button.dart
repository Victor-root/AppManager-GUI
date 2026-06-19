part of '../../app_manager_page.dart';

extension _ActionButtonBuild on _AppManagerPageState {
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required String tooltip,
    required VoidCallback? onPressed,
    required int delay,
  }) {
    final colors = AppColors.of(context);
    return FadeIn(
      duration: Duration(milliseconds: delay),
      child: Tooltip(
        message: tooltip,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.background.withOpacity(0.8),
                border: Border.all(color: colors.foreground.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 20, color: colors.foregroundMuted),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: colors.foregroundMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
