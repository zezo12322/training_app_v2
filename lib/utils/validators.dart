import '../constants/app_constants.dart';

class Validators {
  // Email validation
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    
    // Basic email regex
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email.trim())) {
      return 'البريد الإلكتروني غير صحيح';
    }
    
    return null;
  }
  
  // Password validation
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    
    if (password.length < AppConstants.minPasswordLength) {
      return 'كلمة المرور يجب أن تكون ${AppConstants.minPasswordLength} أحرف على الأقل';
    }
    
    return null;
  }
  
  // Name validation
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'الاسم مطلوب';
    }
    
    if (name.trim().length < 2) {
      return 'الاسم يجب أن يكون حرفين على الأقل';
    }
    
    if (name.trim().length > 50) {
      return 'الاسم يجب ألا يزيد عن 50 حرف';
    }
    
    return null;
  }
  
  // Course name validation
  static String? validateCourseName(String? courseName) {
    if (courseName == null || courseName.trim().isEmpty) {
      return 'اسم الكورس مطلوب';
    }
    
    if (courseName.trim().length < 3) {
      return 'اسم الكورس يجب أن يكون 3 أحرف على الأقل';
    }
    
    if (courseName.trim().length > AppConstants.maxCourseNameLength) {
      return 'اسم الكورس يجب ألا يزيد عن ${AppConstants.maxCourseNameLength} حرف';
    }
    
    return null;
  }
  
  // Course code validation
  static String? validateCourseCode(String? courseCode) {
    if (courseCode == null || courseCode.trim().isEmpty) {
      return 'كود الكورس مطلوب';
    }
    
    if (courseCode.trim().length != AppConstants.courseCodeLength) {
      return 'كود الكورس يجب أن يكون ${AppConstants.courseCodeLength} أحرف';
    }
    
    // Only alphanumeric characters
    final codeRegex = RegExp(r'^[A-Z0-9]+$');
    if (!codeRegex.hasMatch(courseCode.trim().toUpperCase())) {
      return 'كود الكورس يجب أن يحتوي على أحرف وأرقام إنجليزية فقط';
    }
    
    return null;
  }
  
  // Post content validation
  static String? validatePostContent(String? content) {
    if (content == null || content.trim().isEmpty) {
      return 'محتوى المنشور مطلوب';
    }
    
    if (content.trim().length < 5) {
      return 'محتوى المنشور يجب أن يكون 5 أحرف على الأقل';
    }
    
    if (content.trim().length > AppConstants.maxPostContentLength) {
      return 'محتوى المنشور يجب ألا يزيد عن ${AppConstants.maxPostContentLength} حرف';
    }
    
    return null;
  }
  
  // Comment validation
  static String? validateComment(String? comment) {
    if (comment == null || comment.trim().isEmpty) {
      return 'التعليق مطلوب';
    }
    
    if (comment.trim().length < 2) {
      return 'التعليق يجب أن يكون حرفين على الأقل';
    }
    
    if (comment.trim().length > AppConstants.maxCommentLength) {
      return 'التعليق يجب ألا يزيد عن ${AppConstants.maxCommentLength} حرف';
    }
    
    return null;
  }
  
  // Score validation (0-100)
  static String? validateScore(String? score) {
    if (score == null || score.trim().isEmpty) {
      return 'الدرجة مطلوبة';
    }
    
    final parsedScore = int.tryParse(score.trim());
    if (parsedScore == null) {
      return 'الدرجة يجب أن تكون رقم';
    }
    
    if (parsedScore < 0 || parsedScore > 100) {
      return 'الدرجة يجب أن تكون بين 0 و 100';
    }
    
    return null;
  }
  
  // Feedback validation
  static String? validateFeedback(String? feedback) {
    if (feedback == null || feedback.trim().isEmpty) {
      return 'التعليق مطلوب';
    }
    
    if (feedback.trim().length < 10) {
      return 'التعليق يجب أن يكون 10 أحرف على الأقل';
    }
    
    if (feedback.trim().length > AppConstants.maxFeedbackLength) {
      return 'التعليق يجب ألا يزيد عن ${AppConstants.maxFeedbackLength} حرف';
    }
    
    return null;
  }
  
  // File size validation
  static String? validateFileSize(int fileSizeInBytes, {int? maxSizeInBytes}) {
    final maxSize = maxSizeInBytes ?? AppConstants.maxFileSize;
    
    if (fileSizeInBytes > maxSize) {
      final maxSizeInMB = (maxSize / (1024 * 1024)).toStringAsFixed(1);
      return 'حجم الملف يجب ألا يزيد عن ${maxSizeInMB} ميجابايت';
    }
    
    return null;
  }
  
  // File extension validation
  static String? validateFileExtension(String fileName, List<String> allowedExtensions) {
    final extension = fileName.split('.').last.toLowerCase();
    
    if (!allowedExtensions.contains(extension)) {
      return 'نوع الملف غير مدعوم. الأنواع المدعومة: ${allowedExtensions.join(', ')}';
    }
    
    return null;
  }
}
