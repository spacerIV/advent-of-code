use 5.30.0;
use Data::Dumper;
use List::Util qw/product/;

my %max = (blue => 14, red => 12, green => 13);
my $sum;

GAME:
while (my $line = <>) {
  my $min;
  chomp $line;
  my ($game_num, $game) = $line =~ m/Game (\d+): (.*)/;
  my @sets = split ";", $game;
  foreach my $set (@sets) {
    my @rolls = split ", ", $set;
    foreach my $roll (@rolls) {
      my ($num, $col) = $roll =~ /(\d+)\s(\w+)/;
      if (exists $min->{$col} && $min->{$col}) {
        $min->{$col} = $num if $num > $min->{$col}
      }
      else {
        $min->{$col} = $num;
      }
    }
  }
  say Dumper values %{$min};
  say Dumper product(values %{$min});
  $sum += product(values %{$min});
}
say Dumper $sum;
