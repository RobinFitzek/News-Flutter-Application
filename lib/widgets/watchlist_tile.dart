import 'package:flutter/material.dart';
import '../../data/database/app_database.dart';
import '../../config/theme.dart';

class WatchlistTile extends StatelessWidget {
  const WatchlistTile({
    super.key,
    required this.item,
    this.quote,
    this.onTap,
    this.onDelete,
    this.onTierChange,
    this.onLongPress,
  });

  final WatchlistItemData item;
  final StockCacheData? quote;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final Function(String tier)? onTierChange;
  final VoidCallback? onLongPress;

  Color _tierColor(String tier) {
    switch (tier) {
      case 'core':
        return Colors.blue;
      case 'swing':
        return Colors.orange;
      case 'research':
        return Colors.purple;
      case 'earnings':
        return Colors.green.shade700;
      default:
        return Colors.grey;
    }
  }

  Color _gainLossColor(BuildContext context, double change) {
    final colors = Theme.of(context).extension<StockColors>() ??
        const StockColors(gainColor: Colors.green, lossColor: Colors.red);
    return change >= 0 ? colors.gainColor : colors.lossColor;
  }

  @override
  Widget build(BuildContext context) {
    final change = quote?.change ?? item.lastPriceChange ?? 0;
    final changePercent = quote?.changePercent ?? 0;
    final isPositive = change >= 0;
    final price = quote?.currentPrice ?? item.lastPrice;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Remove Stock'),
            content: Text('Remove ${item.symbol} from watchlist?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Remove'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => onDelete?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: CircleAvatar(
          backgroundColor: _tierColor(item.tier),
          child: Text(
            item.symbol.length > 4 ? item.symbol.substring(0, 4) : item.symbol,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              item.symbol,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (quote?.companyName != null && quote!.companyName.isNotEmpty) ...[
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  quote!.companyName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: _tierColor(item.tier).withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.tier,
                style: TextStyle(
                  fontSize: 11,
                  color: _tierColor(item.tier),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (item.groupName != null) ...[
              const SizedBox(width: 6),
              Text(item.groupName!, style: const TextStyle(fontSize: 12)),
            ],
          ],
        ),
        trailing: price != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${isPositive ? "+" : ""}${change.toStringAsFixed(2)} (${isPositive ? "+" : ""}${changePercent.toStringAsFixed(2)}%)',
                    style: TextStyle(
                      color: _gainLossColor(context, change),
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
