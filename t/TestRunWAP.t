use Test::Class::Selenium::TestCases::TestCasesWAP::TestLoggedOutPage;

#change this directory to where your setup file is located.
my $testfile = $ARGV[0];

my $t1 = Test::Class::Selenium::TestCases::TestCasesWAP::TestLoggedOutPage->new(
	config_file => $testfile
);


#$ENV{TEST_METHOD} = 'test_portland_or_not_in_portland_me';
#Test::Class->runtests($t1);
Test::Class->runtests($t1);
