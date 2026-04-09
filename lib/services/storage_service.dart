import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/player.dart';
import '../models/quest.dart';
import '../models/daily_record.dart';

const _kPlayer = 'player_v1';
const _kDailyQuests = 'daily_quests_v1';
const _kQuestDate = 'quest_date_v1';
const _kHistory = 'history_v1';
const _kNotificationsEnabled = 'notifications_enabled_v1';

String _dateKey(DateTime d) =>
    '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  // ── Player ──────────────────────────────────────────────────────────────────

  Future<Player> loadPlayer() async {
    final raw = _prefs.getString(_kPlayer);
    if (raw == null) return Player.initial();
    return Player.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> savePlayer(Player player) async {
    await _prefs.setString(_kPlayer, jsonEncode(player.toJson()));
  }

  // ── Daily quests ────────────────────────────────────────────────────────────

  /// Returns null when no quests are stored or the stored date ≠ today.
  Future<List<Quest>?> loadDailyQuests() async {
    final storedDate = _prefs.getString(_kQuestDate);
    final today = _dateKey(DateTime.now());
    if (storedDate != today) return null;

    final raw = _prefs.getString(_kDailyQuests);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List;
    return list.map((e) => Quest.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveDailyQuests(List<Quest> quests, DateTime date) async {
    await _prefs.setString(_kQuestDate, _dateKey(date));
    await _prefs.setString(
        _kDailyQuests, jsonEncode(quests.map((q) => q.toJson()).toList()));
  }

  // ── History ─────────────────────────────────────────────────────────────────

  Future<List<DailyRecord>> loadHistory() async {
    final raw = _prefs.getString(_kHistory);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list
        .map((e) => DailyRecord.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveHistory(List<DailyRecord> history) async {
    await _prefs.setString(
        _kHistory, jsonEncode(history.map((r) => r.toJson()).toList()));
  }

  Future<void> appendRecord(DailyRecord record) async {
    final history = await loadHistory();
    history.removeWhere(
        (r) => _dateKey(r.date) == _dateKey(record.date)); // deduplicate
    history.add(record);
    await saveHistory(history);
  }

  // ── Notifications ───────────────────────────────────────────────────────────

  Future<bool> loadNotificationsEnabled() async =>
      _prefs.getBool(_kNotificationsEnabled) ?? true;

  Future<void> saveNotificationsEnabled(bool val) async =>
      _prefs.setBool(_kNotificationsEnabled, val);

  // ── Reset ───────────────────────────────────────────────────────────────────

  Future<void> clearAll() async => _prefs.clear();
}
