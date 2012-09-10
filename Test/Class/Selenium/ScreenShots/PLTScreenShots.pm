package Test::Class::Selenium::ScreenShots::PLTScreenShots;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::PLT::ManagePage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::PageObjects::PLT::ManagerBillingInformation;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

PLTScreenShots - Take screen shots related for PLT lessor

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 pltlessor_single_vacancy

Steps:

=over

=item  1. Go through Sign-up Single vacancy

=item  2. Add property

=item  3. Sign-Out

=item  4. Go through Sign-up Multi vacancy

=item  5. Billing information

=back

=cut

sub pltlessor_single_vacancy:Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertynameone = $data->create_alpha_string(10);
	my $propertynametwo = $data->create_alpha_string(10);
	my $propertyaddressone = $data->create_address(5);
	my $propertyaddresstwo = $data->create_address(7);
	my $zipcode = "90404";

	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	$landingpage->click_list_your_property();

	my $managepage = Test::Class::Selenium::PageObjects::PLT::ManagePage->new($self);
	$managepage->screen_capture("PLT", "Manage Page");	
	$managepage->start_plt_singlevacancy($zipcode);

	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
	$pltregistrationpageone->screen_capture("PLT", "registration page 1 single vacancy");
	$pltregistrationpageone->continue_to_step_two($email, "qatest11", $propertyaddressone, "Santa Monica", "CA", "90404", "1200");

	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);

	$pltregistrationpagetwo->wait_for_text_present("Basic Listing Information", $self->{set_timeout});

	$pltregistrationpagetwo->screen_capture("PLT", "registration page 2 single vacancy");
	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertynameone, $email);

	my $pltregistrationpagethree = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage->new($self);

	$pltregistrationpagethree->wait_for_text_present("Billing Information", $self->{set_timeout});

	$pltregistrationpagethree->screen_capture("PLT", "registration page 3 single vacancy");
	$pltregistrationpagethree->submit_listing();

	$pltregistrationpagethree->wait_for_text_present("Thank you for using Rent.com to fill your vacancies!", $self->{set_timeout});	

	$pltregistrationpagethree->screen_capture("PLT", "confirmation single vacancy");	
	$pltregistrationpagethree->click_manage_my_listings();
	$pltregistrationpagethree->screen_capture("PLT", "Manage page for 1st single vacancy");	

	$pltregistrationpagethree->sign_out();
	#Add 2nd listing	
#	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
#	$manageraccountpage->click_add_new_listing();
#	$manageraccountpage->click_add_listing_plt_button();
#	$pltregistrationpageone->continue_to_step_two_existing_user($propertyaddresstwo, "Santa Monica", "CA", "90404", "1200");
#	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertynametwo, $email);
#	$pltregistrationpagethree->submit_listing_existing_user();
#	$pltregistrationpagethree->click_manage_my_listings();
#	$pltregistrationpagethree->screen_capture("PLT", "Manage page for 2nd single vacancy");	

}

=head3 pltlessor_multi_vacancy

Steps:

=over

=item  1. Go through Sign-up Multi vacancy

=item  5. Billing information

=back

=cut

sub pltlessor_multi_vacancy:Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	#my $email = "remiguel_020_qa03_plt\@rent.com";
	my $propertynameone = $data->create_alpha_string(10);
	my $propertyaddressone = $data->create_address(5);
	my $zipcode = "90404";

	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	$landingpage->click_list_your_property();
	
	my $managepage = Test::Class::Selenium::PageObjects::PLT::ManagePage->new($self);
	$managepage->screen_capture("PLT", "Manage Page");	
	
	#multivacancy screenshots
	$landingpage->click_list_your_property();
	$managepage->start_plt_multivacancy($zipcode);
	
	$managepage->pause("10000");	

	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
	$pltregistrationpageone->screen_capture("PLT", "registration page 1 multi vacancy");
	$pltregistrationpageone->continue_to_step_two($email, "qatest11", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");

	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);	
	$pltregistrationpagetwo->screen_capture("PLT", "registration page 2 multi vacancy");
	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertynameone, $email);

	my $pltregistrationpagethree = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage->new($self);

	$pltregistrationpagethree->wait_for_text_present("Billing Information", $self->{set_timeout});

	$pltregistrationpagethree->screen_capture("PLT", "registration page 3 multi vacancy");

	$pltregistrationpagethree->submit_listing();
	
	$pltregistrationpagethree->wait_for_text_present("Thank you for using Rent.com to fill your vacancies!", $self->{set_timeout});	
	
	$pltregistrationpagethree->screen_capture("PLT", "confirmation multi vacancy");	
	$pltregistrationpagethree->click_manage_my_listings();
	$pltregistrationpagethree->screen_capture("PLT", "Manage page for multi vacancy");		
}	


=head3 pltlessor_billing

Steps:

=over

=item  2. Billing information

=back

=cut

sub pltlessor_billing:Test(no_plan)
{
	my($self) = @_;

	#log in
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{plt_username},$self->{plt_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');
	$loginpage->click_manage_your_property();

	#modify billing info
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);	
	$manageraccountpage->click_billing_information();
	$manageraccountpage->screen_capture("PLT", "Billing info page");		
	
	my $managerbillinginformation = Test::Class::Selenium::PageObjects::PLT::ManagerBillingInformation->new($self);
	#company info
	$managerbillinginformation->click_my_info_edit();
	$managerbillinginformation->screen_capture("PLT", "Billing Edit company popup");		
	$managerbillinginformation->click_cancel();
	
	#creditcard info
	$managerbillinginformation->click_edit_credit_card();
	$managerbillinginformation->screen_capture("PLT", "Billing Edit credit card popup");		

}

1;

}