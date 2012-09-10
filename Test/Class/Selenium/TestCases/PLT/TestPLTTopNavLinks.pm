package Test::Class::Selenium::TestCases::PLT::TestPLTTopNavLinks;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

TestPLTTopNavLinks - This Test Class verifies the top navigation links for a PLT lessor.

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{
	
BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_plt_top_nav_links

Verify top navigation links are present.

The following links are to be verified:

"Lead Responder"
"Account"
"Create Listing"

=over

Expected Result:

Links are valid and redirect to the proper popup(s) or pages.

=cut

sub test_plt_left_nav_links: Test(no_plan)
{

	my($self) = @_;	
			
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{plt_username},$self->{plt_password});		
	ok($loginpage->wait_for_text_present('Sign Out', '30000'), 'Verify User is logged in');
	$loginpage->click_manage_your_property();
	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);

	#click "Lead Responder"
	$manageraccountpage->click_lead_responder();
	ok($manageraccountpage->is_text_present("You made contact but last response is from renter"), 'Verify Lead Responder page');
	$manageraccountpage->click_manage_your_property();
	#click "Account"
	$manageraccountpage->click_account();
	ok($manageraccountpage->is_text_present("Contact Info"), 'Verify Account Profile page');
	$manageraccountpage->click_manage_your_property();
	#click "Create Listing"
	$manageraccountpage->click_create_listing();
	ok($manageraccountpage->is_text_present("Choose your property type"), 'Verify Add Listing Popup');
	#$manageraccountpage->click_manage_your_property();
	
}
	
1;

}