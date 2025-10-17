import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_app/core/design/tokens.dart';

/// A reusable text field widget that follows the app's Design System.
/// 
/// Features:
/// - Adaptive colors (Light/Dark Mode)
/// - Consistent styling
/// - Label and hint support
/// - Prefix/suffix icon support
/// - Validation support
/// - Password field support
/// 
/// Example:
/// ```dart
/// AppTextField(
///   label: 'Email',
///   hint: 'example@email.com',
///   controller: emailController,
///   prefixIcon: Icons.email,
///   validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
/// )
/// ```
class AppTextField extends StatefulWidget {
  /// Text editing controller
  final TextEditingController? controller;
  
  /// Label text
  final String? label;
  
  /// Hint text
  final String? hint;
  
  /// Prefix icon
  final IconData? prefixIcon;
  
  /// Suffix icon
  final IconData? suffixIcon;
  
  /// Suffix icon onPressed callback
  final VoidCallback? onSuffixIconPressed;
  
  /// Input validator
  final String? Function(String?)? validator;
  
  /// Keyboard type
  final TextInputType? keyboardType;
  
  /// Text input action
  final TextInputAction? textInputAction;
  
  /// On field submitted callback
  final void Function(String)? onFieldSubmitted;
  
  /// On changed callback
  final void Function(String)? onChanged;
  
  /// Whether field is enabled
  final bool enabled;
  
  /// Whether field is password field
  final bool isPassword;
  
  /// Whether field is read only
  final bool readOnly;
  
  /// Max lines
  final int? maxLines;
  
  /// Max length
  final int? maxLength;
  
  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;
  
  /// Focus node
  final FocusNode? focusNode;
  
  /// Auto focus
  final bool autofocus;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.enabled = true,
    this.isPassword = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: widget.isPassword && _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      style: DesignTokens.body1(context),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: DesignTokens.body1(context),
        hintText: widget.hint,
        hintStyle: DesignTokens.body1(context).copyWith(
          color: DesignTokens.textSecondary(context),
        ),
        filled: true,
        fillColor: DesignTokens.fillColor(context),
        
        // Prefix Icon
        prefixIcon: widget.prefixIcon != null 
            ? Icon(widget.prefixIcon)
            : null,
        
        // Suffix Icon
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixIcon != null
                ? IconButton(
                    icon: Icon(widget.suffixIcon),
                    onPressed: widget.onSuffixIconPressed,
                  )
                : null,
        
        // Borders
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: BorderSide(
            color: DesignTokens.borderColor(context),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: BorderSide(
            color: DesignTokens.borderColor(context),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: BorderSide(
            color: DesignTokens.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: BorderSide(
            color: DesignTokens.error,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: BorderSide(
            color: DesignTokens.borderColor(context).withOpacity(0.5),
          ),
        ),
        
        // Padding
        contentPadding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingLg,
          vertical: DesignTokens.spacingLg,
        ),
        
        // Counter style
        counterStyle: DesignTokens.caption(context),
      ),
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
    );
  }
}
