import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loading_widget.dart';
import 'empty_state_widget.dart';

/// Widget مشترك لبناء البيانات غير المتزامنة مع إدارة حالات التحميل والخطأ والفراغ
class AsyncDataBuilder<T> extends StatelessWidget {
  final Stream<T>? stream;
  final Future<T>? future;
  final Widget Function(BuildContext context, T data) builder;
  final String? loadingMessage;
  final String? emptyMessage;
  final IconData? emptyIcon;
  final Widget? customLoading;
  final Widget? customError;
  final Widget? customEmpty;
  final bool Function(T data)? isEmpty;

  const AsyncDataBuilder({
    super.key,
    this.stream,
    this.future,
    required this.builder,
    this.loadingMessage,
    this.emptyMessage,
    this.emptyIcon,
    this.customLoading,
    this.customError,
    this.customEmpty,
    this.isEmpty,
  }) : assert(stream != null || future != null, 'Either stream or future must be provided');

  @override
  Widget build(BuildContext context) {
    if (stream != null) {
      return StreamBuilder<T>(
        stream: stream,
        builder: (context, snapshot) => _buildContent(context, snapshot),
      );
    } else {
      return FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) => _buildContent(context, snapshot),
      );
    }
  }

  Widget _buildContent(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return customLoading ?? LoadingWidget(message: loadingMessage);
    }

    if (snapshot.hasError) {
      return customError ?? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'حدث خطأ: ${snapshot.error}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (!snapshot.hasData) {
      return customEmpty ?? EmptyStateWidget(
        message: emptyMessage ?? 'لا توجد بيانات',
        icon: emptyIcon,
      );
    }

    final data = snapshot.data!;

    // للتحقق من البيانات الفارغة خاصة QuerySnapshot
    if (isEmpty != null && isEmpty!(data)) {
      return customEmpty ?? EmptyStateWidget(
        message: emptyMessage ?? 'لا توجد بيانات',
        icon: emptyIcon,
      );
    }

    // التحقق من QuerySnapshot فارغة
    if (data is QuerySnapshot && data.docs.isEmpty) {
      return customEmpty ?? EmptyStateWidget(
        message: emptyMessage ?? 'لا توجد بيانات',
        icon: emptyIcon,
      );
    }

    return builder(context, data);
  }
}