const x = "const x = |const y = x[0..9]&34.chr&x&34.chr&10.chr&x[11..119]&10.chr&x[121..148]&10.chr&x[150..154]&10.chr&x[156 .. -1]|macro cecho(): stmt = echo y|cecho|echo y"
const y = x[0..9]&34.chr&x&34.chr&10.chr&x[11..119]&10.chr&x[121..148]&10.chr&x[150..154]&10.chr&x[156 .. -1]
macro cecho(): stmt = echo y
cecho
echo y
