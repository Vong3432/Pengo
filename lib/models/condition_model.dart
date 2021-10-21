class Condition {
  Condition({
    required this.symbol,
    required this.symbolValue,
    required this.formattedValue,
  });

  String symbol;
  String symbolValue;
  String formattedValue;
}

final List<Condition> conditionList = <Condition>[
  Condition(
    symbol: '>',
    symbolValue: "LARGER",
    formattedValue: "larger",
  ),
  Condition(
    symbol: '>=',
    symbolValue: "LARGER_EQUAL",
    formattedValue: "larger equal",
  ),
  Condition(
    symbol: '=',
    symbolValue: "EQUAL",
    formattedValue: "equal",
  ),
  Condition(
    symbol: '<',
    symbolValue: "LESSER",
    formattedValue: "lesser",
  ),
  Condition(
    symbol: '<=',
    symbolValue: "LESSER_EQUAL",
    formattedValue: "lesser equal",
  ),
];
