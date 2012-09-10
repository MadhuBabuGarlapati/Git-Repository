package Test::Class::Selenium::TestCases::CSTool::TestCSToolLogin;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::CSTool::CSTool';

=head1 NAME

TestCSToolLogin - This Test Class verifies existing renters

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_login

Verify login as a CS-Tool user

Test Steps:

=over

=item 1. Enter existing valid username

=item 2. Enter existing valid password	

=back

Expected Result:

CSTool User should be able to sign-in, and after clicking on 'Manage Your Property' user gets defaulted to Property tab page

=cut

sub test_login: Test(no_plan)
{
	my($self) = @_;	
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{cs_username},$self->{cs_password});		
	ok($loginpage->is_text_present("Welcome"), 'Verify User is logged in');
	$loginpage->click_list_your_property();
	ok($loginpage->is_text_present("View Specific Properties"), 'Verify User gets defaulted to Property tab page');

}

1;

}

