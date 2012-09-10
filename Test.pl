use strict;
use warnings;

my @browser = split(/:/,'1:2:3:4:5');
my $browser;
my $pid;
our $i = 0;

foreach $browser (@browser){


  $pid =  fork();
  if($pid == 0){
if($browser eq '4'){
qx("ping -n 5 localhost ");
}
  	
print("fork : " .$browser."\n");


exit 0;
}	
}

 print($i);