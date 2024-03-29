import tables, strutils, nre, options, bigints

let countryLen = toTable({
  "AL": 28, "AD": 24, "AT": 20, "AZ": 28, "BE": 16, "BH": 22, "BA": 20, "BR": 29,
  "BG": 22, "CR": 21, "HR": 21, "CY": 28, "CZ": 24, "DK": 18, "DO": 28, "EE": 20,
  "FO": 18, "FI": 18, "FR": 27, "GE": 22, "DE": 22, "GI": 23, "GR": 27, "GL": 18,
  "GT": 28, "HU": 28, "IS": 26, "IE": 22, "IL": 23, "IT": 27, "KZ": 20, "KW": 30,
  "LV": 21, "LB": 28, "LI": 21, "LT": 20, "LU": 20, "MK": 19, "MT": 31, "MR": 27,
  "MU": 30, "MC": 27, "MD": 24, "ME": 22, "NL": 18, "NO": 15, "PK": 24, "PS": 29,
  "PL": 28, "PT": 25, "RO": 24, "SM": 27, "SA": 24, "RS": 22, "SK": 24, "SI": 19,
  "ES": 24, "SE": 24, "CH": 21, "TN": 24, "TR": 26, "AE": 23, "GB": 22, "VG": 24})

proc validIban(iban: string): bool =
  # Ensure upper alphanumeric input
  var iban = iban.replace(" ","").replace("\t","")
  if iban.match(re"^[\dA-Z]+$").isNone:
    return false

  # Validate country code against expected length
  if iban.len != countryLen[iban[0..1]]:
    return false

  # Shift and convert
  iban = iban[4..iban.high] & iban[0..3]
  var digits = ""
  for ch in iban:
    case ch
      of '0'..'9': digits.add($(ch.ord - '0'.ord))
      of 'A'..'Z': digits.add($(ch.ord - 'A'.ord + 10))
      else: discard
  result = initBigInt(digits) mod 97 == 1

for account in ["GB82 WEST 1234 5698 7654 32", "GB82 TEST 1234 5698 7654 32"]:
  echo account, " validation is: ", validIban account
