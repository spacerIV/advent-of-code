use 5.30.0;

my $tot = 0;
while (my $line = <>) {
  chomp $line;

  $line =~ s/twone/twoone/g;
  $line =~ s/eightwo/eighttwo/g;
  $line =~ s/eighthree/eightthree/g;
  $line =~ s/oneight/oneeight/g;
  $line =~ s/nineight/nineeight/g;
  $line =~ s/sevenine/sevennine/g;

  $line =~ s/one/1/g;
  $line =~ s/two/2/g;
  $line =~ s/three/3/g;
  $line =~ s/four/4/g;
  $line =~ s/five/5/g;
  $line =~ s/six/6/g;
  $line =~ s/seven/7/g;
  $line =~ s/eight/8/g;
  $line =~ s/nine/9/g;

  say $line;
  my $char = 0;
  my @arr = split "", $line;
  my ($first) = $line =~ /(\d)/;
  my ($last) = $line =~ /(\d)\D*$/;
  #say "First: $first";
  #say "Last $last";
  $tot += "$first$last";
}
say $tot;
