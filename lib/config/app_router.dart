import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../views/auth/login_screen.dart';
import '../views/dashboard/dashboard_screen.dart';
import '../views/stocks/stocks_screen.dart';
import '../views/analyze/analyze_screen.dart';
import '../views/portfolio/portfolio_screen.dart';
import '../views/settings/settings_screen.dart';
import '../views/stock_detail/stock_detail_screen.dart';
import '../views/analysis_detail/analysis_detail_screen.dart';
import '../views/research/insider_screen.dart';
import '../views/research/dark_pool_screen.dart';
import '../views/research/macro_screen.dart';
import '../views/research/pairs_screen.dart';
import '../views/research/options_flow_screen.dart';
import '../views/research/institutions_screen.dart';
import '../views/research/sector_screen.dart';
import '../views/research/fear_greed_screen.dart';
import '../views/research/comparison_screen.dart';
import '../views/learning/learning_screen.dart';
import '../views/learning/price_alerts_screen.dart';
import '../views/learning/scenario_screen.dart';
import '../views/research/geopolitical_screen.dart';
import '../views/research/economic_calendar_screen.dart';
import '../views/learning/weekly_report_screen.dart';
import '../widgets/app_scaffold.dart';
import '../data/repositories/auth_repository.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    refreshListenable: authRepo,
    redirect: (context, state) {
      if (state.matchedLocation == '/auth/login') return null;
      return authRepo.isLoggedInSync() ? null : '/auth/login';
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/', builder: (_, __) => const DashboardScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/stocks', builder: (_, __) => const StocksScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/analyze', builder: (context, state) {
              final symbol = state.uri.queryParameters['symbol'];
              return AnalyzeScreen(initialSymbol: symbol);
            }),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/portfolio', builder: (_, __) => const PortfolioScreen()),
          ]),
        ],
      ),
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      GoRoute(path: '/stock/:symbol', builder: (context, state) {
        final symbol = state.pathParameters['symbol']!;
        return StockDetailScreen(symbol: symbol);
      }),
      GoRoute(path: '/analysis/:id', builder: (context, state) {
        return AnalysisDetailScreen(analysisId: int.parse(state.pathParameters['id']!));
      }),
      GoRoute(path: '/auth/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/research/insider', builder: (_, __) => const InsiderScreen()),
      GoRoute(path: '/research/darkpool', builder: (_, __) => const DarkPoolScreen()),
      GoRoute(path: '/research/macro', builder: (_, __) => const MacroScreen()),
      GoRoute(path: '/research/pairs', builder: (_, __) => const PairsScreen()),
      GoRoute(path: '/research/options', builder: (_, __) => const OptionsFlowScreen()),
      GoRoute(path: '/research/institutions', builder: (_, __) => const InstitutionsScreen()),
      GoRoute(path: '/research/sector', builder: (_, __) => const SectorScreen()),
      GoRoute(path: '/research/feargreed', builder: (_, __) => const FearGreedScreen()),
      GoRoute(path: '/compare', builder: (_, __) => const ComparisonScreen()),
      GoRoute(path: '/learning', builder: (_, __) => const LearningScreen()),
      GoRoute(path: '/alerts', builder: (_, __) => const PriceAlertsScreen()),
      GoRoute(path: '/scenarios', builder: (_, __) => const ScenarioScreen()),
      GoRoute(path: '/research/geo', builder: (_, __) => const GeopoliticalScreen()),
      GoRoute(path: '/research/calendar', builder: (_, __) => const EconomicCalendarScreen()),
      GoRoute(path: '/report', builder: (_, __) => const WeeklyReportScreen()),
    ],
  );
});
