package Test::Class::Selenium::TestCases::CSTool::CSTool;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

TestCSTool - This Test Class is an abstract class that contains CSTool navigation methods

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

sub sign_in_as_csuser{
	my($self) = @_;
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	
	$loginpage->sign_in($self->{cs_username},$self->{cs_password});		
	ok($loginpage->is_text_present("Welcome"), 'Verify User is logged in');
	$loginpage->click_list_your_property;
	ok($loginpage->is_text_present("View Specific Properties"), 'Verify User gets defaulted to Property tab page');
	
}

1;

}