import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wall_filter.dart';
import '../providers/wall_filter_providers.dart';
import '../core/l10n_ext.dart';

class WallSearchBar extends ConsumerStatefulWidget {
  final String courseId;

  const WallSearchBar({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<WallSearchBar> createState() => _WallSearchBarState();
}

class _WallSearchBarState extends ConsumerState<WallSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final filter = ref.read(wallFilterProvider(widget.courseId));
    ref.read(wallFilterProvider(widget.courseId).notifier).state = 
        filter.copyWith(searchQuery: _searchController.text);
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => WallFilterDialog(courseId: widget.courseId),
    );
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final filter = ref.watch(wallFilterProvider(widget.courseId));
    final hasActiveFilters = filter.hasActiveFilters;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Search field
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: l.searchPostsPlaceholder,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _clearSearch,
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) => setState(() {}),
              ),
            ),
          ),
          const SizedBox(width: 8),
          
          // Filter button
          Badge(
            isLabelVisible: hasActiveFilters,
            label: Text('${filter.activeFilterCount}'),
            child: IconButton(
              icon: Icon(
                Icons.filter_list,
                color: hasActiveFilters 
                    ? Theme.of(context).colorScheme.primary 
                    : null,
              ),
              onPressed: _showFilterDialog,
              tooltip: l.filterButtonTooltip,
            ),
          ),

          // Sort button
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortDialog(),
            tooltip: l.sortButtonTooltip,
          ),
        ],
      ),
    );
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => WallSortDialog(courseId: widget.courseId),
    );
  }
}

class WallFilterDialog extends ConsumerStatefulWidget {
  final String courseId;

  const WallFilterDialog({
    super.key,
    required this.courseId,
  });

  @override
  ConsumerState<WallFilterDialog> createState() => _WallFilterDialogState();
}

class _WallFilterDialogState extends ConsumerState<WallFilterDialog> {
  late PostTypeFilter _postType;
  late DateTime? _startDate;
  late DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    final filter = ref.read(wallFilterProvider(widget.courseId));
    _postType = filter.postType;
    _startDate = filter.startDate;
    _endDate = filter.endDate;
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    
    return AlertDialog(
      title: Text(l.filterPostsTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post type filter
            Text(
              l.postTypeFilter,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: PostTypeFilter.values.map((type) {
                final isSelected = _postType == type;
                return ChoiceChip(
                  label: Text(type.label),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _postType = type);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Date range filter
            Text(
              l.dateRangeFilter,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(_startDate != null 
                        ? '${_startDate!.year}/${_startDate!.month}/${_startDate!.day}'
                        : l.dateFromLabel),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _startDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() => _startDate = date);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(_endDate != null 
                        ? '${_endDate!.year}/${_endDate!.month}/${_endDate!.day}'
                        : l.dateToLabel),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _endDate ?? DateTime.now(),
                        firstDate: _startDate ?? DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() => _endDate = date);
                      }
                    },
                  ),
                ),
              ],
            ),
            if (_startDate != null || _endDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton.icon(
                  icon: const Icon(Icons.clear),
                  label: Text(l.filterClearDates),
                  onPressed: () {
                    setState(() {
                      _startDate = null;
                      _endDate = null;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Reset all filters
            ref.read(wallFilterProvider(widget.courseId).notifier).state = 
                const WallFilter();
            Navigator.of(context).pop();
          },
          child: Text(l.filterReset),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l.dialogCancelButton),
        ),
        FilledButton(
          onPressed: () {
            final currentFilter = ref.read(wallFilterProvider(widget.courseId));
            ref.read(wallFilterProvider(widget.courseId).notifier).state = 
                currentFilter.copyWith(
                  postType: _postType,
                  startDate: _startDate,
                  endDate: _endDate,
                );
            Navigator.of(context).pop();
          },
          child: Text(l.filterApply),
        ),
      ],
    );
  }
}

class WallSortDialog extends ConsumerWidget {
  final String courseId;

  const WallSortDialog({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final filter = ref.watch(wallFilterProvider(courseId));

    return AlertDialog(
      title: Text(l.sortPostsTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sort options
          ...WallSortOption.values.map((option) {
            final isSelected = filter.sortBy == option;
            return ListTile(
              title: Text(option.label),
              leading: Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: isSelected ? Theme.of(context).colorScheme.primary : null,
              ),
              onTap: () {
                ref.read(wallFilterProvider(courseId).notifier).state = 
                    filter.copyWith(sortBy: option);
                Navigator.of(context).pop();
              },
            );
          }),
          const Divider(),
          
          // Pinned first toggle
          SwitchListTile(
            title: Text(l.sortPinnedFirst),
            value: filter.pinnedFirst,
            onChanged: (value) {
              ref.read(wallFilterProvider(courseId).notifier).state = 
                  filter.copyWith(pinnedFirst: value);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l.reactionsClose),
        ),
      ],
    );
  }
}
