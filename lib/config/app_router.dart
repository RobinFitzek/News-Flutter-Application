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
import '../widgets/app_scaffold.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/stocks',
                builder: (context, state) => const StocksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/analyze',
                builder: (context, state) {
                  final symbol = state.uri.queryParameters['symbol'];
                  return AnalyzeScreen(initialSymbol: symbol);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/portfolio',
                builder: (context, state) => const PortfolioScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/stock/:symbol',
        builder: (context, state) {
          final symbol = state.pathParameters['symbol']!;
          return StockDetailScreen(symbol: symbol);
        },
      ),
      GoRoute(
        path: '/analysis/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return AnalysisDetailScreen(analysisId: id);
        },
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/research/insider',
        builder: (context, state) => const InsiderScreen(),
      ),
      GoRoute(
        path: '/research/darkpool',
        builder: (context, state) => const DarkPoolScreen(),
      ),
      GoRoute(
        path: '/research/macro',
        builder: (context, state) => const MacroScreen(),
      ),
      GoRoute(
        path: '/research/pairs',
        builder: (context, state) => const PairsScreen(),
      ),
      GoRoute(
        path: '/research/options',
        builder: (context, state) => const OptionsFlowScreen(),
      ),
      GoRoute(
        path: '/research/institutions',
        builder: (context, state) => const InstitutionsScreen(),
      ),
      GoRoute(
        path: '/research/sector',
        builder: (context, state) => const SectorScreen(),
      ),
      GoRoute(
        path: '/research/feargreed',
        builder: (context, state) => const FearGreedScreen(),
      ),
      GoRoute(
        path: '/compare',
        builder: (context, state) => const ComparisonScreen(),
      ),
      GoRoute(
        path: '/learning',
        builder: (context, state) => const LearningScreen(),
      ),
      GoRoute(
        path: '/alerts',
        builder: (context, state) => const PriceAlertsScreen(),
      ),
      GoRoute(
        path: '/scenarios',
        builder: (context, state) => const ScenarioScreen(),
      ),
    ],
  );
});
