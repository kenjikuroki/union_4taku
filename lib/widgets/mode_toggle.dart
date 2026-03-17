import 'package:flutter/material.dart';
import '../utils/purchase_manager.dart';

enum QuizMode { shuffle, sequential }

class ModeToggle extends StatelessWidget {
  final QuizMode currentMode;
  final ValueChanged<QuizMode> onModeChanged;
  final VoidCallback onLockTapped;

  const ModeToggle({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
    required this.onLockTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: PurchaseManager.instance.isPremiumNotifier,
      builder: (context, isPremium, child) {
        return Container(
          width: 200,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: currentMode == QuizMode.shuffle
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  width: 100,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C3E50),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onModeChanged(QuizMode.shuffle),
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: Icon(
                          Icons.shuffle,
                          color: currentMode == QuizMode.shuffle
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: isPremium 
                          ? () => onModeChanged(QuizMode.sequential)
                          : onLockTapped,
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.format_list_numbered,
                              color: currentMode == QuizMode.sequential
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                            if (!isPremium)
                              const Icon(
                                Icons.lock,
                                color: Colors.black45,
                                size: 32,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
