package Test::Class::Selenium::TestCases::PLT::TestPLTRegistrationPageTwo;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::PLT::ManagePage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::PageObjects::PLT::PropertyOverviewPage;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::PLT::TestPLT';
use Test::Class::Selenium::DataAccessObjects::PLTDao;


=head1 NAME

TestPLTRegistrationPageTwo

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{
	
BEGIN {$ENV{DIE_ON_FAIL} = 1}


=head3 test_return_to_manager_homepage_link

Verify a new user is able to go to the listing dashboard 
when they click on 'Managers Home' on PLT registration page 2

Test Steps:

=over

=item 1. Go to PLT registration page

=item 2. Click on Single vacancy Get Started link

=item 3. Fill out all the required fields on page 1 of the registration process 
=item 4. Click on 'Continue to Step 2'
=item 5. On page 2, click on the 'Managers Home' link on the top left corner

=back

Expected Result:

User is able to go to the listing dashboard (even though the listing is incomplete), 
when they click on 'Managers Home' on PLT registration page 2


=cut

sub test_return_to_manager_homepage_link: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";	

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->continue_to_step_two_single_floor_plan($email, "1234567890123456789012345", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
		
	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);
	
	$pltregistrationpagetwo->click_manager_home_link();
	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	
	ok($manageraccountpage->is_text_present("My Listings"), 'Verify Property Listing page 2, \'Property Listings Information dashboard\'');
	ok($manageraccountpage->is_text_present("Listing Summary"), 'Verify Property Listing page 2, \'Property Listings Information dashboard\'');
	ok($manageraccountpage->is_text_present("Your listing is incomplete"), 'Verify Property Listing page 2, \'Property Listings Information dashboard\'');

}

=head3 test_abandon_registration

Verify a new user abandons registration on page 2

Test Steps:

=over

=item 1. Go to PLT registration page

=item 2. Click on Single vacancy Get Started link

=item 3. Fill out all the required fields on page 1 of the registration process 
=item 4. Click on 'Continue to Step 2'
=item 5. On page 2, click on the 'Managers Home' link on the top left corner

=item 6. View the property's overview page

=back

Expected Result:

Verify listing status is incomplete


=cut

sub test_abandon_registration: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";	

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->continue_to_step_two_single_floor_plan($email, "1234567890123456789012345", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
		
	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);
	
	$pltregistrationpagetwo->click_manager_home_link();
	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->click_property_overview();

	my $propertyoverviewpage = Test::Class::Selenium::PageObjects::PLT::PropertyOverviewPage->new($self);
	ok($propertyoverviewpage->is_text_present("Listing Status: Incomplete"), 'Verify listing status is incomplete');
	ok($propertyoverviewpage->is_text_present("Add Property Name"), 'Verify \'Add Property Name \' link is present');
	ok($propertyoverviewpage->is_text_present("Add Phone Number"), 'Verify \'Add Phone Number \' link is present');
	
}


1;

}
