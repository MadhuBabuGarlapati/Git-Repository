use Test::Class::Selenium::TestCases::CSTool::TestCSToolLogin;

use Test::Class::Selenium::TestCases::Renter::TestExistingRenter;

use Test::Class::Selenium::TestCases::CPA::TestExistingCPA;

use Test::Class::Selenium::TestCases::Renter::TestForgotPassword;

use Test::Class::Selenium::TestCases::PLT::TestExistingPLT;
use Test::Class::Selenium::TestCases::PLT::TestPLTLeftNavLinks;
use Test::Class::Selenium::TestCases::PLT::TestPLTTopNavLinks;

use Test::Class::Selenium::TestCases::Search::TestSearch;

#change this directory to where your setup file is located.
my $testfile = $ARGV[0];

my $t1 = Test::Class::Selenium::TestCases::CSTool::TestCSToolLogin->new(
	config_file => $testfile
);

my $t2 = Test::Class::Selenium::TestCases::Renter::TestExistingRenter->new(
    config_file => $testfile
);

#my $t3 = Test::Class::Selenium::TestCases::Renter::TestForgotPassword->new(
#    config_file => $testfile
#);

my $t4 = Test::Class::Selenium::TestCases::CPA::TestExistingCPA->new(
    config_file => $testfile
);

my $t5 = Test::Class::Selenium::TestCases::PLT::TestExistingPLT->new(
    config_file => $testfile
);

my $t6 = Test::Class::Selenium::TestCases::PLT::TestPLTLeftNavLinks->new(
    config_file => $testfile
);

my $t7 = Test::Class::Selenium::TestCases::PLT::TestPLTTopNavLinks->new(
    config_file => $testfile
);

my $t8 = Test::Class::Selenium::TestCases::Search::TestSearch->new(
    config_file => $testfile
);

#$ENV{TEST_METHOD} = 'test_search_with_amenities';
#Test::Class->runtests($t9, $t17);
Test::Class->runtests($t1, $t2, $t4, $t5, $t6, $t7, $t8 );
