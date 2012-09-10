package Test::Class::Selenium::TestCases::PLT::TestPLTLeftNavLinks;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::PLT::TestPLT';

=head1 NAME

TestPLTLeftNavLinks - This Test Class verifies the left navigation links for a PLT lessor.

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_plt_left_nav_links

Verify left navigation links are present.

For ppl verify links:

"View Leads"
"Learn More"
"Listing DashBoard"

"Update Rents" 
"Add Specials" 
"Add Photos" 
"View Leads" 

"Select Listing to Edit" <-- change this to "Edit Listing Details" 

"Billing Information"
"Pay-Per-Lead FAQ"
"Request A Lead Review"
"Contact Us"

=over

Expected Result:

Links are valid.

=cut

sub test_plt_left_nav_links: Test(no_plan)
{

	my($self) = @_;	
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $company_name = $data->create_alpha_string(8);
	my $first_name = $data->create_alpha_string(5);
	my $last_name = $data->create_alpha_string(5);
		
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{plt_username},$self->{plt_password});		
	ok($loginpage->wait_for_text_present('Sign Out', '30000'), 'Verify User is logged in');
	$loginpage->click_manage_your_property();
	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);

	#click update rents
	$manageraccountpage->click_update_rents();
	ok($manageraccountpage->is_text_present("Add/Edit Floor Plans"), 'Verify update rents page');
	$manageraccountpage->click_manage_your_property();
	#click add specils
	$manageraccountpage->click_add_specials();
	ok($manageraccountpage->is_text_present("Move-In Specials"), 'Verify add specials page');
	$manageraccountpage->click_manage_your_property();
	#click add photos
	$manageraccountpage->click_add_photos();
	ok($manageraccountpage->is_text_present("Manage Images"), 'Verify add photos page');
	$manageraccountpage->click_manage_your_property();
	#click view leads
	$manageraccountpage->click_view_leads();
	ok($manageraccountpage->is_page_title_present("Rent.com: Lead Responder"), 'Verify view leads page title');
	$manageraccountpage->click_manage_your_property();
	
	#click edit listing details
	$manageraccountpage->click_edit_listing_details();
	ok($manageraccountpage->is_text_present("Listing Status:"), 'Verify edit listing details page');
	$manageraccountpage->click_manage_your_property();
	
	#click billing information
	$manageraccountpage->click_billing_information();
	ok($manageraccountpage->is_page_title_present("Rent.com: Manage information"), 'Verify billing information page title');

	#click Listing Dashboard
	$manageraccountpage->click_listing_dashboard();
	ok($manageraccountpage->is_page_title_present("Rent.com: Manager Site: Account"), 'Verify Listing Dashboard title');
	ok($manageraccountpage->is_text_present("My Listings"), 'Verify listing dashboard page');
	$manageraccountpage->click_manage_your_property();
	
	SKIP:
	{
		skip('Because of QA-81 - Automation research.  Research into finding solution for selenium pop-up windows in internet explorer, also this affects FF4.', 1);
	
		#click contact us
		$manageraccountpage->click_contact_us();
		ok($manageraccountpage->is_text_present("Contact Property Support"), 'Verify contact us page');
		$manageraccountpage->click_manage_your_property();	
	}
}

1;

}
