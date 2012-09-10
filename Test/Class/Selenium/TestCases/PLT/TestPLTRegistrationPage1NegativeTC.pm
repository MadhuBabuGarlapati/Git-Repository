package Test::Class::Selenium::TestCases::PLT::TestPLTRegistrationPage1NegativeTC;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::PLT::ManagePage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use Test::Class::Selenium::TestCases::PLT::TestPLT;
use base 'Test::Class::Selenium::TestCases::PLT::TestPLT';

=head1 NAME 

TestPLTRegistrationPage1NegativeTC

=head1 SYNOPSIS

=head1 DESCRIPTION

Registration page 1 negative test cases

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_invalid_email_format

Verify invalid email format 'asdf'

Test Steps:

=over

=item 1. Go to rent.com
=item 2. Click on 'List Your Property'
=item 3. Enter email as 'asdf'
=item 4. Click submit

=back

Expected Result:

error message "Please enter a valid email address"

=cut

sub test_invalid_email_format: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = "asdf";
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->fill_create_account($email, "qatest11");
	$pltregistrationpageone->click_step_two_button();

	ok($pltregistrationpageone->is_text_present("Please enter a valid email address"), 'Verify error message "Please enter a valid email address"');

}

=head3 test_empty_passwords

Test Steps:

=over

=item 1. Go to rent.com
=item 2. Click on 'List Your Property'
=item 3. Leave email as blank
=item 4. Click submit

=back

Expected Result:

error messages 
"Please enter a password."
"Please reenter your password."

=cut

sub test_empty_passwords: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $zipcode = "90404";
	
	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->fill_create_account($email, "");
	$pltregistrationpageone->click_step_two_button();
	
	ok($pltregistrationpageone->is_text_present("Please enter a password."), 'Verify password empty');
	ok($pltregistrationpageone->is_text_present("Please reenter your password."), 'Verify re-enter password empty');
	
}


=back

=head3 test_empty_property_info

Test Steps:

=over

=item 1. Go to rent.com
=item 2. Click on 'List Your Property'
=item 3. Leave street_address, city, state, zip as blank
=item 4. Click submit

=back

Expected Result:
error messages are displayed

"Please enter a street address."
"Please enter a valid city name."

=cut

sub test_empty_property_info_for_apartment: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $minrent = "1000";
	my $street_address = "";
	my $city = "";
	my $state = "CA";
	my $zip = "90404";
	
	
	$self->go_to_plt_page_multi_vacancy($zip);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->wait_for_text_present("Create An Account", $self->{set_timeout});	

	$pltregistrationpageone->fill_create_account($email, "qatest11");
	$pltregistrationpageone->fill_property_information($street_address, $city, $state, $zip);
	$pltregistrationpageone->fill_floor_plan_info($minrent);
	$pltregistrationpageone->click_step_two_button();
	
	#Give 5 seconds for the error msgs to load
	$pltregistrationpageone->wait_for_text_present("Please enter a street address.", $self->{set_timeout});	
	
	ok($pltregistrationpageone->is_text_present("Please enter a street address."), 'Verify error msg for empty street address');
	ok($pltregistrationpageone->is_text_present("Please enter a valid city name."), 'Verify error msg for empty city');
	
}

=head3 test_empty_floor_plan_info_for_apartment

Test Steps:

=over

=item 1. Go to rent.com
=item 2. Click on 'List Your Property'
=item 3. Leave floor plan as blank
=item 4. Click submit

=back

Expected Result:

error messages are displayed

Please enter valid minimum rent amounts for all floorplans.

=cut


sub test_empty_floor_plan_info_for_apartment: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $minrent = "";
	my $street_address = "1221 federal ave";
	my $city = "los angeles";
	my $state = "CA";
	my $zip = "90024";
	
	$self->go_to_plt_page_multi_vacancy($zip);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->fill_create_account($email, "qatest11");
	$pltregistrationpageone->fill_property_information($street_address, $city, $state, $zip);
	$pltregistrationpageone->fill_floor_plan_info($minrent);
	$pltregistrationpageone->click_step_two_button();
	
	#Give 10 seconds for the error msgs to load
	$pltregistrationpageone->wait_for_text_present("Please enter valid minimum rent amounts for all floorplans.", $self->{set_timeout});	
	
	ok($pltregistrationpageone->is_text_present("Please enter valid minimum rent amounts for all floorplans."), 'Verify error msg for empty floor plan information');
	ok($pltregistrationpageone->is_text_present("Email Address"), 'Verify still on page 1 PLT reg page');
	ok($pltregistrationpageone->is_text_present("Password"), 'Verify still on page 1 PLT reg page');
	
}

=head3 test_min_password_length

Verify user is unable to enter less than 4 chars for password

Test Steps:

=over

=item 1. Go to PLT registration page

=item 2. Click on Single vacancy Get Started link

=item 3. Fill out the entire form with valid data, except enter only 3 characters in the Password & Reenter Password fields

=item 4. Click on the Continue button

=back

Expected Result:

Error message 'Passwords must be at least 4 characters' is displayed on the page and does not allow user to continue

=cut

sub test_min_password_length: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $zip = "90404";
		
	$self->go_to_plt_page_single_vacancy($zip);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->fill_create_account($email, "123");
	$pltregistrationpageone->click_step_two_button();
	
	ok($pltregistrationpageone->is_text_present("Passwords must be at least 4 characters"), 'Verify min password error message');
	ok($pltregistrationpageone->is_text_present("Create An Account"), 'Verify user is still on the same page, \'Create An Account\'');
	ok($pltregistrationpageone->is_text_present("Property Information"), 'Verify user is still on the same page, \'Property Information\'');
	
}

1;

}
