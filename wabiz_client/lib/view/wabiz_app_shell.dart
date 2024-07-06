import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/**
 * 하위 Screen을 담는 Shell Widget
 */
class WabizAppShell extends StatefulWidget {

  const WabizAppShell({
    super.key,
    required this.child,
    required this.currentIndex
  });

  final Widget child;
  final int currentIndex;

  @override
  State<WabizAppShell> createState() => _WabizAppShellState();
}

class _WabizAppShellState extends State<WabizAppShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          GoRouter.of(context).go('/home');
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '홈'
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: '프로젝트'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                widget.currentIndex == 2 ? Icons.favorite : Icons.favorite_border,
              ),
              label: '구독'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                widget.currentIndex == 3 ? Icons.person : Icons.person_2_outlined,
              ),
              label: '마이페이지'
          )
        ],
      ),
    );
  }
}
