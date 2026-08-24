import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';

/// Pill-shaped search input with a leading search icon and a clear
/// button that appears once text is entered. Distinct from
/// [AppTextField] because search bars use a fully-rounded shape and
/// filled-surface treatment rather than the standard outlined field.
class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller = widget.controller ?? TextEditingController();
  late bool _hasText = _controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.search,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: AppColors.surfaceAlt,
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
        suffixIcon: _hasText
            ? IconButton(
                icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                tooltip: 'Clear search',
                onPressed: _clear,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.chip),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.chip),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.chip),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
