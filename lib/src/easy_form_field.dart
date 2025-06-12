import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'field_types.dart';
import 'validators.dart';

class EasyFormField extends StatefulWidget {
  final String label;
  final FieldType fieldType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool required;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final bool enabled;
  final int maxLines;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  // Enhanced styling options (all nullable)
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final Color? fillColor;
  final bool filled;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? errorStyle;
  final Color? cursorColor;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final double? cursorWidth;

  // Colors (all nullable)
  final Color? focusColor;
  final Color? hoverColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  // Border radius options (all nullable)
  final double? borderRadius;
  final BorderRadius? customBorderRadius;

  // Border width options (all nullable)
  final double? borderWidth;
  final double? focusedBorderWidth;
  final double? errorBorderWidth;

  // Border colors (all nullable)
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? disabledBorderColor;

  // Shadow and elevation (all nullable)
  final List<BoxShadow>? boxShadow;
  final double? elevation;

  // Icon styling (all nullable)
  final double? iconSize;
  final EdgeInsetsGeometry? prefixIconPadding;
  final EdgeInsetsGeometry? suffixIconPadding;

  // Field spacing (all nullable)
  final EdgeInsetsGeometry? fieldMargin;
  final EdgeInsetsGeometry? fieldPadding;

  // Date picker options (all nullable)
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const EasyFormField({
    super.key,
    required this.label,
    this.fieldType = FieldType.text,
    this.controller,
    this.validator,
    this.hintText,
    this.required = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.onChanged,
    this.onSaved,
    this.enabled = true,
    this.maxLines = 1,
    this.textInputAction,
    this.focusNode,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.fillColor,
    this.filled = false,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.errorStyle,
    this.cursorColor,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorWidth,
    this.focusColor,
    this.hoverColor,
    this.prefixIconColor,
    this.suffixIconColor,
    this.borderRadius,
    this.customBorderRadius,
    this.borderWidth,
    this.focusedBorderWidth,
    this.errorBorderWidth,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.boxShadow,
    this.elevation,
    this.iconSize,
    this.prefixIconPadding,
    this.suffixIconPadding,
    this.fieldMargin,
    this.fieldPadding,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<EasyFormField> createState() => _EasyFormFieldState();
}

class _EasyFormFieldState extends State<EasyFormField> {
  late TextEditingController _controller;
  bool _obscureText = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscureText = widget.fieldType == FieldType.password;
    _selectedDate = widget.initialDate;

    if (widget.fieldType == FieldType.datepicker && _selectedDate != null) {
      _controller.text = _formatDate(_selectedDate!);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  TextInputType _getKeyboardType() {
    // Handle multiline case first
    if (widget.maxLines > 1 ||
        widget.textInputAction == TextInputAction.newline) {
      return TextInputType.multiline;
    }

    switch (widget.fieldType) {
      case FieldType.number:
        return const TextInputType.numberWithOptions(decimal: true);
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.password:
        return TextInputType.visiblePassword;
      case FieldType.alphanum:
      case FieldType.text:
      case FieldType.datepicker:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> _getInputFormatters() {
    switch (widget.fieldType) {
      case FieldType.number:
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))];
      case FieldType.alphanum:
        return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))];
      case FieldType.datepicker:
        return [FilteringTextInputFormatter.deny(RegExp(r'.*'))];
      default:
        return [];
    }
  }

  String? Function(String?)? _getValidator() {
    if (widget.validator != null) {
      return widget.validator;
    }

    if (!widget.required) {
      return null;
    }

    switch (widget.fieldType) {
      case FieldType.text:
        return EasyValidators.text;
      case FieldType.alphanum:
        return EasyValidators.alphanum;
      case FieldType.number:
        return EasyValidators.number;
      case FieldType.email:
        return EasyValidators.email;
      case FieldType.password:
        return EasyValidators.password;
      case FieldType.datepicker:
        return EasyValidators.datepicker;
    }
  }

  IconData? _getPrefixIcon() {
    if (widget.prefixIcon != null) {
      return widget.prefixIcon;
    }

    switch (widget.fieldType) {
      case FieldType.email:
        return Icons.email_outlined;
      case FieldType.password:
        return Icons.lock_outline;
      case FieldType.number:
        return Icons.numbers;
      case FieldType.datepicker:
        return Icons.calendar_today;
      default:
        return null;
    }
  }

  Widget? _getSuffixIcon() {
    if (widget.fieldType == FieldType.password) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: widget.suffixIconColor,
          size: widget.iconSize,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    if (widget.fieldType == FieldType.datepicker) {
      return IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: widget.suffixIconColor,
          size: widget.iconSize,
        ),
        onPressed: _selectDate,
      );
    }

    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(
          widget.suffixIcon,
          color: widget.suffixIconColor,
          size: widget.iconSize,
        ),
        onPressed: widget.onSuffixIconPressed,
      );
    }

    return null;
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = _formatDate(picked);
      });

      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text);
      }
    }
  }

  BorderRadius _getBorderRadius() {
    if (widget.customBorderRadius != null) {
      return widget.customBorderRadius!;
    }
    return BorderRadius.circular(widget.borderRadius ?? 8);
  }

  InputBorder _createBorder({Color? color, double? width}) {
    final borderRadius = _getBorderRadius();
    final borderWidth = width ?? widget.borderWidth ?? 1.0;
    final borderColor = color ?? widget.borderColor ?? Colors.grey.shade300;

    return OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: borderColor, width: borderWidth),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget textField = TextFormField(
      controller: _controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      obscureText: _obscureText,
      keyboardType: _getKeyboardType(),
      inputFormatters: _getInputFormatters(),
      textInputAction: widget.textInputAction,
      validator: _getValidator(),
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      readOnly: widget.fieldType == FieldType.datepicker,
      onTap: widget.fieldType == FieldType.datepicker ? _selectDate : null,
      style: widget.textStyle,
      cursorColor: widget.cursorColor,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth ?? 2.0,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText ?? _getDefaultHint(),
        prefixIcon: _getPrefixIcon() != null
            ? Padding(
                padding: widget.prefixIconPadding ?? EdgeInsets.zero,
                child: Icon(
                  _getPrefixIcon(),
                  color: widget.prefixIconColor,
                  size: widget.iconSize,
                ),
              )
            : null,
        suffixIcon: widget.suffixIconPadding != null
            ? Padding(
                padding: widget.suffixIconPadding!,
                child: _getSuffixIcon(),
              )
            : _getSuffixIcon(),
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

        // Custom borders or default borders
        border: widget.border ?? _createBorder(),
        enabledBorder:
            widget.enabledBorder ?? _createBorder(color: widget.borderColor),
        focusedBorder: widget.focusedBorder ??
            _createBorder(
                color: widget.focusedBorderColor ?? Colors.blue,
                width: widget.focusedBorderWidth ?? 2.0),
        errorBorder: widget.errorBorder ??
            _createBorder(
                color: widget.errorBorderColor ?? Colors.red,
                width: widget.errorBorderWidth ?? 1.0),
        focusedErrorBorder: widget.focusedErrorBorder ??
            _createBorder(
                color: widget.errorBorderColor ?? Colors.red,
                width: widget.focusedBorderWidth ?? 2.0),
        disabledBorder: widget.disabledBorder ??
            _createBorder(
                color: widget.disabledBorderColor ?? Colors.grey.shade200),

        filled: widget.filled,
        fillColor:
            widget.fillColor ?? (widget.filled ? Colors.grey.shade50 : null),
        labelStyle: widget.labelStyle,
        hintStyle: widget.hintStyle,
        errorStyle: widget.errorStyle,
        focusColor: widget.focusColor,
        hoverColor: widget.hoverColor,
      ),
    );

    // Apply shadow and elevation if specified
    if (widget.boxShadow != null || widget.elevation != null) {
      textField = Container(
        decoration: BoxDecoration(
          borderRadius: _getBorderRadius(),
          boxShadow: widget.boxShadow ??
              (widget.elevation != null
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: widget.elevation!,
                        offset: Offset(0, widget.elevation! / 2),
                      )
                    ]
                  : null),
        ),
        child: textField,
      );
    }

    // Apply field margin and padding
    return Container(
      margin: widget.fieldMargin ?? const EdgeInsets.symmetric(vertical: 8.0),
      padding: widget.fieldPadding,
      child: textField,
    );
  }

  String? _getDefaultHint() {
    switch (widget.fieldType) {
      case FieldType.email:
        return 'Enter your email address';
      case FieldType.password:
        return 'Enter your password';
      case FieldType.number:
        return 'Enter a number';
      case FieldType.alphanum:
        return 'Enter letters and numbers only';
      case FieldType.datepicker:
        return 'Select a date';
      default:
        return 'Enter text';
    }
  }
}
