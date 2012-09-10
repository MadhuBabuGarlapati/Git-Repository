use Test::Class::Selenium::TestCases::CSTool::TestCSToolLogin;
use Test::Class::Selenium::TestCases::CSTool::TestCSToolPropertySearch;
use Test::Class::Selenium::TestCases::CSTool::TestCSToolNewContent;
use Test::Class::Selenium::TestCases::CSTool::TestCSToolProperty;
use Test::Class::Selenium::TestCases::CSTool::TestCSToolCompany;

use Test::Class::Selenium::TestCases::Renter::TestExistingRenter;
use Test::Class::Selenium::TestCases::Renter::TestNewReturningRenter;

use Test::Class::Selenium::TestCases::HotLead::TestHotLead;
use Test::Class::Selenium::TestCases::LeaseReport::TestLeaseReportRefactored;

use Test::Class::Selenium::TestCases::Renter::TestRegisterRenter;
use Test::Class::Selenium::TestCases::Search::TestSearch;

use Test::Class::Selenium::TestCases::PLT::TestPLTBilling;
use Test::Class::Selenium::TestCases::PLT::TestPLTRegistrationPageOne;
use Test::Class::Selenium::TestCases::PLT::TestPLTRegistrationPageTwo;
use Test::Class::Selenium::TestCases::PLT::TestPLTLeftNavLinks;
use Test::Class::Selenium::TestCases::PLT::TestPLTRegisterLesser;
use Test::Class::Selenium::TestCases::PLT::TestPLTRegistrationPage1NegativeTC;
use Test::Class::Selenium::TestCases::PLT::TestPLTManagerBillingInformation;
use Test::Class::Selenium::TestCases::PLT::TestPLTTopNavLinks;
use Test::Class::Selenium::TestCases::PLT::TestExistingPLT;
use Test::Class::Selenium::TestCases::PLT::TestPLTPhotos;

use Test::Class::Selenium::TestCases::CPA::TestExistingCPA;

use Test::Class::Selenium::TestCases::Renter::TestForgotPassword;

use Test::Class::Selenium::TestCases::Search::TestFeaturedListingsSearch;

use Test::Class::Selenium::TestCases::Renter::TestAccountProfile;

use Test::Class::Selenium::TestCases::PDP::TestPDP;
use Test::Class::Selenium::TestCases::Markets::TestMarkets;
use Test::Class::Selenium::TestCases::Akamai::TestImagesOnAkamai;

#change this directory to where your setup file is located.
my $testfile = $ARGV[0];

my $t1 = Test::Class::Selenium::TestCases::CSTool::TestCSToolLogin->new(
	config_file => $testfile
);

my $t2 = Test::Class::Selenium::TestCases::CSTool::TestCSToolPropertySearch->new(
    config_file => $testfile
);

my $t3 = Test::Class::Selenium::TestCases::CSTool::TestCSToolNewContent->new(
    config_file => $testfile
);

my $t4 = Test::Class::Selenium::TestCases::Renter::TestExistingRenter->new(
    config_file => $testfile
);

my $t5 = Test::Class::Selenium::TestCases::HotLead::TestHotLead->new(
    config_file => $testfile
);

my $t6 = Test::Class::Selenium::TestCases::LeaseReport::TestLeaseReportRefactored->new(
    config_file => $testfile
);

my $t8 = Test::Class::Selenium::TestCases::PLT::TestPLTLeftNavLinks->new(
    config_file => $testfile
);

my $t9 = Test::Class::Selenium::TestCases::PLT::TestPLTRegisterLesser->new(
    config_file => $testfile
);

my $t10 = Test::Class::Selenium::TestCases::Renter::TestRegisterRenter->new(
    config_file => $testfile
);

my $t11 = Test::Class::Selenium::TestCases::Search::TestSearch->new(
    config_file => $testfile
);

my $t13 = Test::Class::Selenium::TestCases::PLT::TestPLTRegistrationPage1NegativeTC->new(
    config_file => $testfile
);

my $t15 = Test::Class::Selenium::TestCases::PLT::TestPLTBilling->new(
    config_file => $testfile
);

my $t16 = Test::Class::Selenium::TestCases::CSTool::TestCSToolProperty->new(
    config_file => $testfile
);

my $t17 = Test::Class::Selenium::TestCases::PLT::TestPLTRegistrationPageOne->new(
    config_file => $testfile
);

my $t18 = Test::Class::Selenium::TestCases::CSTool::TestCSToolCompany->new(
    config_file => $testfile
);

my $t19 = Test::Class::Selenium::TestCases::CPA::TestExistingCPA->new(
    config_file => $testfile
);

my $t20 = Test::Class::Selenium::TestCases::PLT::TestPLTManagerBillingInformation->new(
    config_file => $testfile
);

my $t21 = Test::Class::Selenium::TestCases::Renter::TestForgotPassword->new(
    config_file => $testfile
);

my $t22 = Test::Class::Selenium::TestCases::PLT::TestPLTTopNavLinks->new(
    config_file => $testfile
);

my $t23 = Test::Class::Selenium::TestCases::PLT::TestExistingPLT->new(
    config_file => $testfile
);

my $t24 = Test::Class::Selenium::TestCases::PLT::TestPLTRegistrationPageTwo->new(
    config_file => $testfile
);

my $t25 = Test::Class::Selenium::TestCases::PLT::TestPLTPhotos->new(
    config_file => $testfile
);

my $t26 = Test::Class::Selenium::TestCases::Renter::TestNewReturningRenter->new(
    config_file => $testfile
);

my $t27 = Test::Class::Selenium::TestCases::Search::TestFeaturedListingsSearch->new(
    config_file => $testfile
);

my $t28 = Test::Class::Selenium::TestCases::Renter::TestAccountProfile->new(
    config_file => $testfile
);

my $t29 = Test::Class::Selenium::TestCases::PDP::TestPDP->new(
    config_file => $testfile
);

my $t30 = Test::Class::Selenium::TestCases::Markets::TestMarkets->new(
    config_file => $testfile
);

my $t31 = Test::Class::Selenium::TestCases::Akamai::TestImagesOnAkamai->new(
    config_file => $testfile
);


#$ENV{TEST_METHOD} = 'test_login';
Test::Class->runtests($t1, $t2, $t3, $t4, $t5, $t6, $t8, $t9, $t10, $t11, $t13, $t15, $t16, $t17, $t18, $t19, $t20, $t21, $t22, $t23, $t24, $t25, $t26, $t27, $t28, $t29, $t30, $t31);



