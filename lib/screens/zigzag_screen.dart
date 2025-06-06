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

  @override
  void initState() {
    super.initState();
    loader.loadInitialSections();
    controller.addListener(_onScroll);
  }

  void _onScroll() {
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
              return SectionWidget(section: loader.sections[index]);
            },
          );
        },
      ),
    );
  }
}
