use 5.30.0;
use Data::Dumper;

my %max = (blue => 14, red => 12, green => 13);
say Dumper %max;

my $sum=0;

GAME:
while (my $line = <>) {
  chomp $line;
  my ($game_num, $game) = $line =~ m/Game (\d+): (.*)/;
  my @sets = split ";", $game;
  say "Full game: $game_num - $game";
  foreach my $set (@sets) {
    say "  -- Set: $set";
    my @rolls = split ", ", $set;
    foreach my $roll (@rolls) {
      #say "    -- Roll $roll";
      my ($num, $col) = $roll =~ /(\d+)\s(\w+)/;
      #say "      -- num: $num col: $col";
      if ($max{$col} < $num) {
        say "FAIL! -- $game_num";
        next GAME;
      }
    }
  }
  $sum += $game_num;
}
say $sum;
