import 'package:flutter/material.dart';
import '../providers/section_loader.dart';
import '../widgets/section_widget.dart';

class ZigZagScreen extends StatefulWidget {
  const ZigZagScreen({super.key});

  @override
  State<ZigZagScreen> createState() => _ZigZagScreenState();
}

class _ZigZagScreenState extends State<ZigZagScreen> {
  final SectionLoader loader = SectionLoader();
  final ScrollController controller = ScrollController();
  bool showBackToTop = false;

  @override
  void initState() {
    super.initState();
    loader.loadInitialSections();
    controller.addListener(_onScroll);
  }

  void _onScroll() {
    // Show back-to-top button logic
    final shouldShow = controller.offset > MediaQuery.of(context).size.height;
    if (shouldShow != showBackToTop) {
      setState(() => showBackToTop = shouldShow);
    }

    // Lazy loading logic
    if (controller.position.pixels >=
            controller.position.maxScrollExtent - 800 &&
        !loader.isLoading) {
      loader.loadMoreSections();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(title: const Text("Zig-Zag Viewer")),
      floatingActionButton: showBackToTop
          ? FloatingActionButton(
              onPressed: () {
                controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            )
          : null,
      body: AnimatedBuilder(
        animation: loader,
        builder: (context, _) {
          return ListView.builder(
            controller: controller,
            itemCount: loader.sections.length + 1,
            itemBuilder: (context, index) {
              if (index == loader.sections.length) {
                return loader.hasMore
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink();
              }
              return SectionWidget(
                section: loader.sections[index],
                sectionIndex: index,
              );
            },
          );
        },
      ),
    );
  }
}
