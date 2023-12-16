use 5.30.0;
use Data::Dumper;
use List::Util qw/product/;

my $file = 'test4.txt';
open my $fh, '<', $file or die;
$/ = undef;
my $data = <$fh>;
close $fh;
my @lines = split "\n", $data;

my $sum;
my @mores;
my $line_num=1;

say "Orig lines!!";
say Dumper scalar @lines;

foreach my $line (@lines) {
  chomp $line;
  my ($wins, $mine) = get_nums($line);

  my $num_wins = get_wins($wins, $mine);
  say $line;
  say $num_wins;
  my $x = $line_num;
  foreach (1 .. $num_wins) {
    push @lines, $lines[$x];
    #say "Adding line: $x - $lines[$x]";
    $x++;
  }
  #say "Adding from $line_num to $line_num + " . scalar @common;

  $line_num++;
}
say "Mores!";
say Dumper scalar @mores;
say "Orig lines!!";
say Dumper scalar @lines;

sub get_wins {
  my ($wins, $mine) = @_;
  my @common;
  foreach my $win (@{$wins}) {
     if (grep { $_ eq $win  } @{$mine}) {
       push @common, $win unless grep { $_ eq $win } @common;
     }
  }
  return scalar @common;
}

sub get_nums {
  my $line = shift;
  my ($win, $mine) = $line =~ /Card\s+\d+: (.*)? \| (.*)/;
  my @wins = split " ", $win;
  my @mine = split " ", $mine;
  return (\@wins, \@mine);
}
