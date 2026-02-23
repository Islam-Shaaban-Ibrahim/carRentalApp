import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/resources/color_manager.dart';
import 'package:qent/generated/l10n.dart';
import 'package:qent/main.dart';

OverlayEntry? _activeBanner;
String? _activeMessage;

void showAppBanner(
  String message, {
  VoidCallback? onReport,
  Duration duration = const Duration(seconds: 3),
  bool isError = false,
}) {
  final overlay = navigatorKey.currentState?.overlay;

  if (overlay == null) return;

  // Prevent duplicate banner
  if (_activeBanner != null && _activeMessage == message) return;

  // Remove existing
  _removeActiveBanner();

  late OverlayEntry entry;

  void closeBanner() {
    if (_activeBanner == entry) {
      entry.remove();
      _activeBanner = null;
      _activeMessage = null;
    }
  }

  entry = OverlayEntry(
    builder: (_) => Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: _TopBanner(
        message: message,
        isError: isError,
        onClose: closeBanner,
        onReport: onReport == null
            ? null
            : () {
                onReport();
                closeBanner();
              },
      ),
    ),
  );

  _activeBanner = entry;
  _activeMessage = message;

  overlay.insert(entry);

  Future.delayed(duration, () {
    if (_activeBanner == entry) {
      closeBanner();
    }
  });
}

void _removeActiveBanner() {
  _activeBanner?.remove();
  _activeBanner = null;
  _activeMessage = null;
}

class _TopBanner extends StatefulWidget {
  final String message;
  final VoidCallback? onReport;
  final VoidCallback onClose;
  final bool isError;

  const _TopBanner({
    required this.message,
    this.onReport,
    required this.onClose,
    required this.isError,
  });

  @override
  State<_TopBanner> createState() => _TopBannerState();
}

class _TopBannerState extends State<_TopBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fade = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.reverse();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleLarge;
    return SafeArea(
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: Material(
            color: ColorManager.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              padding: EdgeInsets.only(
                left: 8.w,
                right: 8.w,
                top: 5.w,
                bottom: 10.w,
              ),
              decoration: BoxDecoration(
                color: widget.isError
                    ? ColorManager.error
                    : ColorManager.success,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [BoxShadow(blurRadius: 6.sp)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: widget.onClose,
                    child: const Icon(Icons.close, color: ColorManager.white),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isError) ...[
                        Icon(
                          widget.message == S.current.noInternetConnection
                              ? Icons.public_off
                              : Icons.warning,
                          color: ColorManager.white,
                        ),
                      ],
                      5.horizontalSpace,
                      Expanded(
                        child: Text(
                          widget.message,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme?.copyWith(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                  if (widget.onReport != null)
                    GestureDetector(
                      onTap: widget.onReport,
                      child: Text(
                        S.current.report,
                        style: textTheme?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
