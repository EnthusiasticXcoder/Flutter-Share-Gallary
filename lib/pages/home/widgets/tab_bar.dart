import 'package:flutter/material.dart';
import 'package:gallary/helpers/shaders/circle_shader.dart';

class TabBarWidget extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> tabViews;
  const TabBarWidget({super.key, required this.tabs, required this.tabViews});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BlueCirclePainter(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.12,
          titleTextStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          title: const SafeArea(child: Text('Gallery')),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
            vertical: MediaQuery.of(context).size.height * 0.015,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: <Widget>[
              // tabs widget
              TabBar(
                  controller: _tabController,
                  tabs: widget.tabs
                      .map((tab) => Tab(
                            text: tab,
                          ))
                      .toList()),

              // margin
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // tab screens
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: widget.tabViews,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
