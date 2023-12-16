use 5.30.0;
use Data::Dumper;
use List::Util qw/product/;

my $sum;
while (my $line = <>) {
  chomp $line;
  my ($wins, $mine) = get_nums($line);
  #say $line;
  #say Dumper $wins;
  #say Dumper $mine;

  my @common;
  foreach my $win (@{$wins}) {
     if (grep { $_ eq $win  } @{$mine}) {
       push @common, $win unless grep { $_ eq $win } @common;
     }
  }
  #say Dumper scalar @common;
  my $common = scalar @common;

  my $x=0;
  if ($common >= 1) {
    $x++;
    foreach (1 .. $common -1) {
      $x = $x * 2;
    }
  }
  #say "$common: $x   --- " . join ", ", @common;
  $sum += $x;
}
say $sum;

sub get_nums {
  my $line = shift;
  my ($win, $mine) = $line =~ /Card\s+\d+: (.*)? \| (.*)/;
  my @wins = split " ", $win;
  my @mine = split " ", $mine;
  return (\@wins, \@mine);
}
