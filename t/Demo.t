use  Test::Class::Selenium::TestCases::Popular::TestLandingPage;
use Test::Simple;

my $testfile = $ARGV[0];
#$ENV{TEST_METHOD} ='test_160';
my $t1 =  Test::Class::Selenium::TestCases::Popular::TestLandingPage->new(config_file => $testfile);
Test::Class->runtests($t1);