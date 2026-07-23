import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedSearchBar extends StatefulWidget {
  final void Function(String)? onChanged;
  const AnimatedSearchBar({super.key, required this.onChanged});

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _expanded = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      // Auto-collapse if it loses focus and is empty
      if (!_focusNode.hasFocus && _controller.text.isEmpty && _expanded) {
        toggle();
      }
    });
  }

  // toggle
  void toggle() {
    setState(() {
      _expanded = !_expanded;
    });

    if (_expanded) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kWidth = MediaQuery.of(context).size.width - 40;
    return AnimatedContainer(
      width: _expanded ? kWidth : 56,
      curve: Curves.easeInOut,
      height: 52,
      duration: 300.ms,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(_expanded ? 16 : 28),
      ),
      child: AnimatedSwitcher(
        duration: 300.ms,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        ),
        child: _expanded
            ? SizedBox(
                key: ValueKey('expanded'),
                width: kWidth,
                child: Row(
                  children: [
                    // searchField
                    Expanded(
                      child: CupertinoSearchTextField(
                        onChanged: widget.onChanged,
                        focusNode: _focusNode,
                        controller: _controller,
                        suffixMode: OverlayVisibilityMode.never,
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Close button — always visible when expanded
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _controller.clear();
                        widget.onChanged?.call('');
                        toggle();
                      },
                      minimumSize: Size(32, 32),
                      child: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              )
            : CupertinoButton(
                key: ValueKey('Closed'),
                padding: EdgeInsets.zero,
                onPressed: toggle,
                child: const Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                  size: 22,
                ),
              ),
      ),
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<AppColor> filteredColors = AppColor.allColors;

  void _search(String value) {
    setState(() {
      filteredColors = AppColor.allColors
          .where(
            (color) => color.name.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  // Determine contrasting text color for readability on any background
  Color _contrastText(Color bg) {
    final luminance = bg.computeLuminance();
    return luminance > 0.45 ? const Color(0xFF1A1A2E) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Color Palette',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0F0C29), // deep indigo
                Color(0xFF302B63), // purple
                Color(0xFF24243E), // dark slate
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                // Search row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedSearchBar(onChanged: (value) => _search(value)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Color count badge
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A3660),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${filteredColors.length} colors',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Grid
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisExtent: 140,
                        ),
                    itemBuilder: (context, index) {
                      final color = filteredColors[index];
                      final textColor = _contrastText(color.color);
                      return Container(
                        decoration: BoxDecoration(color: color.color),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              color.hex,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontSize: 15,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              color.name,
                              style: TextStyle(
                                color: textColor.withValues(alpha: 0.8),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: filteredColors.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppColor {
  final String name;
  final String hex;
  final Color color;
  const AppColor({required this.color, required this.hex, required this.name});

  static const List<AppColor> allColors = [
    // Whites
    AppColor(name: 'Pure White', hex: '#FFFFFF', color: Color(0xFFFFFFFF)),
    AppColor(name: 'Off White', hex: '#F8F8F8', color: Color(0xFFF8F8F8)),
    AppColor(name: 'White Smoke', hex: '#F5F5F5', color: Color(0xFFF5F5F5)),
    AppColor(name: 'Ghost White', hex: '#F8F8FF', color: Color(0xFFF8F8FF)),
    AppColor(name: 'Snow', hex: '#FFFAFA', color: Color(0xFFFFFAFA)),

    // Greys
    AppColor(name: 'Light Grey', hex: '#D3D3D3', color: Color(0xFFD3D3D3)),
    AppColor(name: 'Grey', hex: '#808080', color: Color(0xFF808080)),
    AppColor(name: 'Dark Grey', hex: '#A9A9A9', color: Color(0xFFA9A9A9)),
    AppColor(name: 'Charcoal', hex: '#36454F', color: Color(0xFF36454F)),
    AppColor(name: 'Slate', hex: '#708090', color: Color(0xFF708090)),

    // Blues
    AppColor(name: 'Sky Blue', hex: '#87CEEB', color: Color(0xFF87CEEB)),
    AppColor(name: 'Light Blue', hex: '#ADD8E6', color: Color(0xFFADD8E6)),
    AppColor(name: 'Royal Blue', hex: '#4169E1', color: Color(0xFF4169E1)),
    AppColor(name: 'Navy Blue', hex: '#000080', color: Color(0xFF000080)),
    AppColor(name: 'Teal', hex: '#008080', color: Color(0xFF008080)),

    // Purples
    AppColor(name: 'Lavender', hex: '#E6E6FA', color: Color(0xFFE6E6FA)),
    AppColor(name: 'Purple', hex: '#800080', color: Color(0xFF800080)),
    AppColor(name: 'Indigo', hex: '#4B0082', color: Color(0xFF4B0082)),
    AppColor(name: 'Violet', hex: '#EE82EE', color: Color(0xFFEE82EE)),
    AppColor(name: 'Magenta', hex: '#FF00FF', color: Color(0xFFFF00FF)),

    // Greens
    AppColor(name: 'Mint', hex: '#ACFFAC', color: Color(0xFFACFFAC)),
    AppColor(name: 'Light Green', hex: '#90EE90', color: Color(0xFF90EE90)),
    AppColor(name: 'Green', hex: '#008000', color: Color(0xFF008000)),
    AppColor(name: 'Forest Green', hex: '#228B22', color: Color(0xFF228B22)),
    AppColor(name: 'Olive', hex: '#808000', color: Color(0xFF808000)),

    // Reds
    AppColor(name: 'Salmon', hex: '#FA8072', color: Color(0xFFFA8072)),
    AppColor(name: 'Light Coral', hex: '#F08080', color: Color(0xFFF08080)),
    AppColor(name: 'Red', hex: '#FF0000', color: Color(0xFFFF0000)),
    AppColor(name: 'Crimson', hex: '#DC143C', color: Color(0xFFDC143C)),
    AppColor(name: 'Maroon', hex: '#800000', color: Color(0xFF800000)),

    // Oranges/Yellows
    AppColor(name: 'Peach', hex: '#FFDAB9', color: Color(0xFFFFDAB9)),
    AppColor(name: 'Orange', hex: '#FFA500', color: Color(0xFFFFA500)),
    AppColor(name: 'Gold', hex: '#FFD700', color: Color(0xFFFFD700)),
    AppColor(name: 'Yellow', hex: '#FFFF00', color: Color(0xFFFFFF00)),
    AppColor(name: 'Mustard', hex: '#FFDB58', color: Color(0xFFFFDB58)),

    // Browns/Blacks
    AppColor(name: 'Tan', hex: '#D2B48C', color: Color(0xFFD2B48C)),
    AppColor(name: 'Brown', hex: '#A52A2A', color: Color(0xFFA52A2A)),
    AppColor(name: 'Sienna', hex: '#A0522D', color: Color(0xFFA0522D)),
    AppColor(name: 'Black', hex: '#000000', color: Color(0xFF000000)),
    AppColor(name: 'Dark Brown', hex: '#654321', color: Color(0xFF654321)),
  ];
}
