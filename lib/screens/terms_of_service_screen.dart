import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/l10n_ext.dart';

class TermsOfServiceScreen extends StatefulWidget {
  const TermsOfServiceScreen({super.key});

  @override
  State<TermsOfServiceScreen> createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  String _termsOfService = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTermsOfService();
  }

  Future<void> _loadTermsOfService() async {
    try {
      final data = await rootBundle.loadString('assets/terms_of_service_ar.md');
      // Replace ${DATE} with current date
      final now = DateTime.now();
      final dateStr = '${now.day}/${now.month}/${now.year}';
      final processedData = data.replaceAll('\${DATE}', dateStr);
      
      if (mounted) {
        setState(() {
          _termsOfService = processedData;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _termsOfService = 'فشل تحميل شروط الاستخدام: $e';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.termsOfServiceTitle),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Markdown(
              data: _termsOfService,
              selectable: true,
              onTapLink: (text, href, title) {
                if (href != null) {
                  _launchUrl(href);
                }
              },
              styleSheet: MarkdownStyleSheet(
                h1: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                h2: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                h3: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                p: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                    ),
                listBullet: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                code: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      backgroundColor: Colors.grey[200],
                    ),
                codeblockDecoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                blockquotePadding: const EdgeInsets.all(12),
                blockquoteDecoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(4),
                  border: Border(
                    right: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 4,
                    ),
                  ),
                ),
                horizontalRuleDecoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
