
import 'package:flutter/material.dart';
import 'package:woniu_creative/pages/admin/admin_dashboard_page.dart';
import 'package:woniu_creative/pages/admin/channel_list_page.dart';
import 'package:woniu_creative/pages/admin/device_register_page.dart';
import 'package:woniu_creative/pages/admin/material_list_page.dart';
import 'package:woniu_creative/pages/admin/playlist_list_page.dart';
import 'package:woniu_creative/utils/logger_utils.dart';
import 'package:woniu_creative/widgets/state_extension.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final List<MenuItem> _menuItems = [
    MenuItem(title: '仪表盘', icon: Icons.dashboard, route: '/dashboard'),
    MenuItem(
      title: '用户管理',
      icon: Icons.people,
      children: [
        MenuItem(title: '用户列表', route: '/users', icon: Icons.people),
        MenuItem(
          title: '角色管理',
          route: '/roles',
          icon: Icons.ac_unit,
          children: [
            MenuItem(title: '创建角色', route: '/roles-1', icon: Icons.people),
            MenuItem(title: '编辑角色', route: '/roles-2', icon: Icons.ac_unit),
          ],
        ),
      ],
    ),
    MenuItem(
      title: '设备管理',
      icon: Icons.devices,
      children: [
        MenuItem(title: '设备注册', route: '/device/register', icon: Icons.devices),
        MenuItem(title: '设备列表', route: '/device/list', icon: Icons.list),
      ],
    ),
    MenuItem(
      title: '内容管理',
      icon: Icons.folder_outlined,
      children: [
        MenuItem(title: '频道管理', route: '/channel/list', icon: Icons.list),
        MenuItem(title: '播放列表', route: '/playlist/list', icon: Icons.subscriptions_outlined),
        MenuItem(title: '素材管理', route: '/material/list', icon: Icons.description_outlined),
      ],
    ),
    MenuItem(
      title: '系统设置',
      icon: Icons.settings,
      children: [
        MenuItem(title: '基础设置', route: '/settings/basic', icon: Icons.abc),
        MenuItem(title: '高级设置', route: '/settings/advanced', icon: Icons.abc),
      ],
    ),
  ];
  final Map<String, Widget Function(BuildContext)> _routeMap = {
    '/dashboard': (context) => DashboardPage(),
    '/users': (context) => UsersPage(),
    '/roles-1': (context) => RolesPage(),
    '/roles-2': (context) => RolesPage(),
    '/settings/basic': (context) => BasicSettingsPage(),
    '/settings/advanced': (context) => AdvancedSettingsPage(),
    '/device/register': (context) => const DeviceRegisterPage(),
    '/channel/list': (context) => const ChannelListPage(),
    '/playlist/list': (context) => const PlayListListPage(),
    '/material/list': (context) => const MaterialListPage(),
  };

  /// 将菜单的树结构反转，能通过叶子节点快速找到所有父节点
  /// map中的key是叶子节点的route，value是包含自己及所有父节点组成的List
  final Map<String, List<MenuItem>> _menuReverseTreeChildToParent = {};

  // String _currentRoute = '/dashboard';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<NavigatorState> _innerNavigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _genReverseMenuTree(_menuItems, []);
    _genRouteListener();
  }

  void _genRouteListener() {
    var dashboardRoute = context.read<DashboardRoute>();
    dashboardRoute.addListener(() {
      debug('路由变化：${dashboardRoute.lastRoute} -> ${dashboardRoute.route}');
      if (dashboardRoute.route == dashboardRoute.lastRoute) return;
      // 更新菜单选中状态和展开状态
      var list = _menuReverseTreeChildToParent[dashboardRoute.lastRoute];
      if (list != null) {
        list.firstOrNull?.isSelected = false;
      }
      list = _menuReverseTreeChildToParent[dashboardRoute.route];
      if (list != null) {
        list.firstOrNull?.isSelected = true;
        for (var i = 1; i < list.length; i++) {
          var item = list[i];
          item.expanded = true;
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _innerNavigatorKey.currentState?.popAndPushNamed(dashboardRoute.route);
    });
  }

  void _genReverseMenuTree(List<MenuItem> items, List<MenuItem> parents) {
    for (var item in items) {
      if (item.children.isNotEmpty) {
        _genReverseMenuTree(item.children, [item, ...parents]);
      } else {
        _menuReverseTreeChildToParent[item.route] = [item, ...parents];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:
          !isPC
              ? AppBar(
                title: Text('管理系统'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                  ),
                ],
              )
              : null,
      endDrawer: !isPC ? _buildNavMenu() : null,
      body: Row(
        children: [
          if (isPC) _buildNavMenu(),
          Expanded(
            child: Navigator(
              key: _innerNavigatorKey,
              // initialRoute: dashboardRoute.route,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => _buildContent(context, settings.name!),
                  settings: settings,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavMenu() {
    return Consumer<DashboardRoute>(
      builder: (context, value, child) {
        return Drawer(
          width: 222,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),
              ..._menuItems.map((item) => _buildMenuItem(item)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                '控制台',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.account_box_outlined),
                SizedBox(width: 10),
                Text('管理员1'),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // _innerNavigatorKey.currentState?.pushReplacementNamed('/roles-2');
                    setState(() {});
                  },
                  child: Text('test1'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    if (item.children.isNotEmpty) {
      // item.controller ??= ExpansionTileController();
      return ExpansionTile(
        // 这里使用Globalkey是为了state更新的时候，不使用缓存，使initiallyExpanded能生效
        key: GlobalKey(),
        leading: Icon(item.icon),
        title: Text(item.title),
        iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
        childrenPadding: EdgeInsets.only(left: 16),
        initiallyExpanded: item.expanded,
        // 必须设置为true，否则没展开的时候子菜单没有state，调用controller的时候会报错
        maintainState: true,
        // controller: ExpansionTileController(),
        onExpansionChanged: (value) {
          item.expanded = value;
          // setState(() {});
        },
        children: item.children.map((child) => _buildMenuItem(child)).toList(),
      );
    }
    // item.selectedController = StreamController();
    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.title),
      selected: item.isSelected,
      onTap: () => _handleMenuTap(item.route),
    );
  }

  void _handleMenuTap(String route) {
    var routeState = context.read<DashboardRoute>();
    if (routeState.route != route) {
      _innerNavigatorKey.currentState?.popAndPushNamed(route);
    }
  }

  Widget _buildContent(BuildContext context, String route) {
    // 在下一帧更新当前选中的路由
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var routeState = context.read<DashboardRoute>();
      routeState.changeRoute(route);
    });
    final pageBuilder = _routeMap[route];
    if (pageBuilder == null) {
      return Center(child: Text('页面未找到'));
    }
    return pageBuilder(context);
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final String route;
  final List<MenuItem> children;

  bool expanded = false;
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    if (_isSelected != value) {
      _isSelected = value;
      // selectedController?.add(value);
    }
  }

  // ExpansionTileController? controller;

  // StreamController<bool>? selectedController;

  MenuItem({
    required this.title,
    required this.icon,
    this.route = '',
    this.children = const [],
  });
}

class DashboardRoute extends ChangeNotifier {
  String _route = '/';
  String _lastRoute = '';

  String get route => _route;
  String get lastRoute => _lastRoute;

  DashboardRoute(this._route);

  void changeRoute(String route) {
    _lastRoute = _route;
    _route = route;
    notifyListeners();
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('用户管理', style: TextStyle(fontSize: 24)),
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => ListTile(title: Text('用户 $index')),
          ),
        ),
      ],
    );
  }
}

class RolesPage extends StatelessWidget {
  const RolesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('角色管理', style: TextStyle(fontSize: 24)),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => ListTile(title: Text('角色 $index')),
          ),
        ),
      ],
    );
  }
}

class BasicSettingsPage extends StatelessWidget {
  const BasicSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('基础设置', style: TextStyle(fontSize: 24)),
        Expanded(child: Center(child: Text('基础设置内容'))),
      ],
    );
  }
}

class AdvancedSettingsPage extends StatelessWidget {
  const AdvancedSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('高级设置', style: TextStyle(fontSize: 24)),
        Expanded(child: Center(child: Text('高级设置内容'))),
      ],
    );
  }
}
