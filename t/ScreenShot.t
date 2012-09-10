use Test::Class::Selenium::ScreenShots::RenterScreenShots;
use Test::Class::Selenium::ScreenShots::CSToolScreenShots;
use Test::Class::Selenium::ScreenShots::PLTScreenShots;

#change this directory to where your setup file is located.
my $testfile = $ARGV[0];

my $t1 = Test::Class::Selenium::ScreenShots::RenterScreenShots->new(
	config_file => $testfile
);

my $t2 = Test::Class::Selenium::ScreenShots::CSToolScreenShots->new(
	config_file => $testfile
);

my $t3 = Test::Class::Selenium::ScreenShots::PLTScreenShots->new(
	config_file => $testfile
);

#$ENV{TEST_METHOD} = 'pltlessor_multi_vacancy';
#Test::Class->runtests($t3);
Test::Class->runtests($t1, $t2, $t3);