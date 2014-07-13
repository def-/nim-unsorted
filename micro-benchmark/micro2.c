#define size 100000

void main() {
  int a[size];
  for (int i = 0; i < size; i++)
    a[i] = 0;

  int sum = 0;
  while (sum < 100000000) {
    for (int i = 0; i < size; i++)
      a[i]++;

    sum = 0;
    for (int i = 0; i < size; i++)
      sum += a[i];
  }
  printf("%d\n", sum);
}
