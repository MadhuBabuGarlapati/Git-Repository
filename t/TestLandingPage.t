use  Test::Class::Selenium::TestCases::Popular::TestLandingPage;

my $testfile = $ARGV[0];

my $browser = $ARGV[1];

$ENV{TEST_METHOD} = $ARGV[2];

my $report = $ARGV[3];

my $t1 =  Test::Class::Selenium::TestCases::Popular::TestLandingPage->new(config_file => $testfile,browser=>$browser,report=>$report);

Test::Class->runtests($t1);