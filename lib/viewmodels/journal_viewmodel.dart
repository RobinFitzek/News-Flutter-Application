import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/journal_repository.dart';

class JournalState {
  const JournalState({
    this.entries = const [],
    this.isLoading = false,
    this.errorMessage,
  });
  final List<JournalEntryData> entries;
  final bool isLoading;
  final String? errorMessage;
  JournalState copyWith({List<JournalEntryData>? entries, bool? isLoading, String? errorMessage}) =>
    JournalState(entries: entries ?? this.entries, isLoading: isLoading ?? this.isLoading, errorMessage: errorMessage ?? this.errorMessage);
}

class JournalViewModel extends StateNotifier<JournalState> {
  JournalViewModel({required this.journalRepo}) : super(const JournalState());
  final JournalRepository journalRepo;

  Future<void> loadEntries() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final entries = await journalRepo.getAll();
      state = state.copyWith(entries: entries, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> addEntry(JournalEntryData entry) async {
    try { await journalRepo.add(entry); await loadEntries(); }
    catch (e) { state = state.copyWith(errorMessage: e.toString()); }
  }

  Future<void> closeEntry(int id, {required double exitPrice, required DateTime exitDate, required double pnl}) async {
    try { await journalRepo.close(id, exitPrice: exitPrice, exitDate: exitDate, pnl: pnl); await loadEntries(); }
    catch (e) { state = state.copyWith(errorMessage: e.toString()); }
  }

  Future<void> deleteEntry(int id) async {
    try { await journalRepo.delete(id); await loadEntries(); }
    catch (e) { state = state.copyWith(errorMessage: e.toString()); }
  }
}

final journalViewModelProvider = StateNotifierProvider<JournalViewModel, JournalState>((ref) {
  return JournalViewModel(journalRepo: ref.watch(journalRepositoryProvider));
});
