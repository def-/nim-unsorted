iterator fasta_pairs*(f: TFile): tuple[header: string, sequence: string] {.inline.} =
  var sequence = ""
  var header = ""
  var seq_index = -1
  for line in f.lines:
    if line[0] == '>':
      if seq_index >= 0:
        yield (header, sequence)
      header = line
      sequence = ""
      seq_index += 1
    else:
      sequence.add(line)
  yield (header, sequence)

var f = open("sequence.fasta")
for i in fasta_pairs(f):
  echo i[0].len, " ", i[1].len
