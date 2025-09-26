/// مساعدات التحقق من النماذج
class FormValidators {
  /// التحقق من الحقل المطلوب
  static String? required(String? value, [String? customMessage]) {
    if (value == null || value.trim().isEmpty) {
      return customMessage ?? 'الحقل مطلوب';
    }
    return null;
  }

  /// التحقق من البريد الإلكتروني
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }

  /// التحقق من كلمة المرور
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < minLength) {
      return 'كلمة المرور يجب أن تكون $minLength أحرف على الأقل';
    }
    return null;
  }

  /// التحقق من الأرقام
  static String? number(String? value, {int? min, int? max}) {
    if (value == null || value.trim().isEmpty) {
      return 'الحقل مطلوب';
    }
    final number = int.tryParse(value.trim());
    if (number == null) {
      return 'يجب إدخال رقم صحيح';
    }
    if (min != null && number < min) {
      return 'القيمة يجب أن تكون $min أو أكثر';
    }
    if (max != null && number > max) {
      return 'القيمة يجب أن تكون $max أو أقل';
    }
    return null;
  }

  /// التحقق من النطاق (للدرجات مثلاً)
  static String? range(String? value, int min, int max) {
    return number(value, min: min, max: max);
  }

  /// التحقق من طول النص
  static String? minLength(String? value, int minLength) {
    if (value == null || value.trim().isEmpty) {
      return 'الحقل مطلوب';
    }
    if (value.trim().length < minLength) {
      return 'يجب أن يكون النص $minLength أحرف على الأقل';
    }
    return null;
  }

  /// دمج عدة تحققات
  static String? combine(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }
}