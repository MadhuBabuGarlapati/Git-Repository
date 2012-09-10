package Test::Class::Selenium::TestCases::PLT::TestPLTRegistrationPageOne;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::PLT::ManagePage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::PLT::TestPLT';
use Test::Class::Selenium::DataAccessObjects::PLTDao;


=head1 NAME

TestPLTRegistrationPageOne

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_new_lesser_multiple_floor_plans_multivacancy

Verify new lesser with multiple floor plans

Test Steps:

=cut

sub test_new_lesser_multiple_floor_plans_multi_vacancy: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";
	my $phonenumber = "(453) 453-4534";

	$self->go_to_plt_page_multi_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->continue_to_step_two_multiple_floor_plans($email, "qatest11", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
	$pltregistrationpageone->pause("30000");
	ok($pltregistrationpageone->is_text_present("Basic Listing Information"), 'Verify Property registration page 2');
	
	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);
	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertyname, $email, $phonenumber);
		
	my $pltregistrationpagethree = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage->new($self);
	ok($pltregistrationpagethree->is_text_present("Submit your listing today and start receiving leads!"), 'Verify Property registration page 3');
	$pltregistrationpagethree->submit_listing();
		
	ok($pltregistrationpagethree->is_text_present("Thank you for using Rent.com to fill your vacancies!"), 'Verify Successful registration');

}

=head3 test_check_tables_after_step_one

=cut

sub test_check_tables_after_registration_single_vacancy: Test(no_plan)
{

    my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";
	my $phonenumber = "(453) 453-4534";
	
	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->continue_to_step_two_single_floor_plan($email, "qatest11", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
	$pltregistrationpageone->pause("30000");
	ok($pltregistrationpageone->is_text_present("Basic Listing Information"), 'Verify Property registration page 2');
	
	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);
	# IB-4506 (Pricing Changes):  le Two
	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertyname, $email, $phonenumber);
		
	my $pltregistrationpagethree = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage->new($self);
	# ok($pltregistrationpagethree->is_text_present("Premium Advertising that Works"), 'Verify Property registration page 3');
	# IB-4506 (Pricing changes)
	ok($pltregistrationpagethree->is_text_present("Submit your listing today and start receiving leads!"), 'Verify Property registration page 3');
	$pltregistrationpagethree->submit_listing();
		
	ok($pltregistrationpagethree->is_text_present("Thank you for using Rent.com to fill your vacancies!"), 'Verify Successful registration');

	#print "\n my database".$self->{database};
	
	my $PLTDao = Test::Class::Selenium::DataAccessObjects::PLTDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	
	my $propertyid =  $PLTDao->get_most_recent_property_id_from_email($email);
	print "\n";
	ok( $propertyid ne '' , "Verify new record is inserted into tblproperty - new property id: $propertyid" );
	
	my $property_nm = $PLTDao->get_property_contact_data($propertyid);
	print "\n";
	ok( $property_nm ne '' , "Verify new record is inserted into tblpropertycontact - new property phone number: $property_nm" );
	
	my $personid =  $PLTDao->get_personid_for_plt($email);
	print "\n";
	ok( $personid ne '' , "Verify new record is inserted into tblperson - new person id: $personid" );
		
	my $companyid =  $PLTDao->get_companyid_from_personid($personid);
	print "\n";
	ok( $companyid ne '' , "Verify new record is inserted into tblperson_company - new company id: $companyid" );

	my $cctransaction_id =  $PLTDao->get_cctransaction_from_personid($personid);
	print "\n";
	ok( $cctransaction_id ne '' , "Verify new record is inserted into tblcctransaction - new transaction id: $cctransaction_id" );
	
	my $company_nm =  $PLTDao->get_company_data($companyid);
	print "\n";
	ok( $company_nm ne '' , "Verify new record is inserted into tblcompany - new company name: $company_nm" );

}

=head3 test_max_password_length

Verify user enters 25 chars for password

Test Steps:

=over

=item 1. Go to PLT registration page

=item 2. Click on Multiple vacancy Get Started link

=item 3. Fill out the entire form with valid data, except enter 25 characters in the Password & Reenter Password fields

=item 4. Click on the Continue button

=back

Expected Result:

User should be able to successfully continue to 'Step 2' of the registration process

=cut

sub test_max_password_length: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->continue_to_step_two($email, "1234567890123456789012345", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
	$pltregistrationpageone->pause("30000");
	
	ok($pltregistrationpageone->is_text_present("Basic Listing Information"), 'Verify Property registration page 2, \'Basic Listing Information\'');
	ok($pltregistrationpageone->is_text_present("Contact Information"), 'Verify Property registration page 2, \'Contact Information\'');
	ok($pltregistrationpageone->is_text_present("Add Details (Recommended)"), 'Verify Property registration page 2, \'Add Details (Recommended)\'');
}

=head3 test_floor_plan_dropdown_value_selection

Verify user selects a value from the floor plan drop-down menu

Test Steps:

=over

=item 1. Go to PLT registration page

=item 2. Click on Multiple vacancy Get Started link

=item 3. Select a value from the floor plan drop-down menu

=back

Expected Result:

System displays existing page and users entries with the addition of the Floorplan 
Entry Grid containing a number of rows determined by the value selected in floor plan drop-down.

=cut

sub test_floor_plan_dropdown_value_selection: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";
	
	$self->go_to_plt_page_multi_vacancy($zipcode);
	
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
    
    $pltregistrationpageone->fill_multiple_floor_plan_info("1000");

	
	ok($pltregistrationpageone->is_element_present("Property-Units-0-bedroom_nb"), 'Verify row 1 of the Entry Grid is displayed on the page, \'Row 1 out of 3 exists on the floor plan entry grid is present\'');
	ok($pltregistrationpageone->is_element_present("Property-Units-1-bedroom_nb"), 'Verify row 2 of the Entry Grid is displayed on the page, \'Row 2 out of 3 exists on the floor plan entry grid is present\'');
	ok($pltregistrationpageone->is_element_present("Property-Units-2-bedroom_nb"), 'Verify row 3 of the Entry Grid is displayed on the page, \'Row 3 out of 3 exists on the floor plan entry grid is present\'');
}

=head3 test_income_restricted_column

Verify an additional column entitled, "Income restricted?" containing 'yes/no' radio buttons are displayed
on the entry grid after user selects "Yes" for question 'Any income restricted units?'

Test Steps:

=over
=over

=item 1. Go to PLT registration page

=item 2. Click on Multiple vacancy Get Started link

=item 3. Select "Yes" radio button for "any income restricted units?" question under 
the property information section for restricted housing

=back

Expected Result:

System displays an additional column entitled, "Income restricted ?" 
containing yes/no radio buttons.

=cut

sub test_income_restricted_column: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";
	
	$self->go_to_plt_page_multi_vacancy($zipcode);
		
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
    
    $pltregistrationpageone->fill_property_information_income_restricted("100 N Main St.", "Santa Monica", "CA", $zipcode);
	
	
	ok($pltregistrationpageone->is_text_present("Income"), 'Verify the income restricted column name is displayed on the Entry Grid, \'Income restricted column name is displayed on the floor plan entry grid\'');
	ok($pltregistrationpageone->is_text_present("Restricted?"), 'Verify the income restricted column name is displayed on the Entry Grid, \'Income restricted column name is displayed on the floor plan entry grid\'');
	ok($pltregistrationpageone->is_element_present("Property-Units-0-incomerestricted_fg_1"), 'Verify the "Income restricted" column has the Yes radio button, \'Income restricted column has the "Yes" radio button in the entry grid\'');
	ok($pltregistrationpageone->is_element_present("Property-Units-0-incomerestricted_fg_0"), 'Verify the "Income restricted" column has the No radio button, \'Income restricted column has the "No" radio button in the entry grid\'');

	
}


=head3 test_floor_plan_count_update

Verify when a user enters all the required fields and optional fields in the floor plan grid based 
on the number of floor plan selected and then updates the floor plan to a different number, 
the grid is re-displayed correctly with retained entry(ies)

Test Steps:

=over

=item 1. Go to PLT registration page

=item 2. Click on Multiple vacancy Get Started link

=item 3. Select the value 3 from floor plan drop down

=item 4. Select the value 2 from floor plan drop down

=back

Expected Result:

System re-displays the grid with the updated number of rows and retained entry(ies).


=cut

sub test_floor_plan_count_update: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";

	$self->go_to_plt_page_multi_vacancy($zipcode);
			
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
    
    $pltregistrationpageone->fill_multiple_floor_plan_info(1000);
	$pltregistrationpageone->select_floor_plan_dropdown();
	
	ok($pltregistrationpageone->is_element_present("Property-Units-0-bedroom_nb"), 'Verify the row 1 of the floor plan grid exists, \'Row 1 of the floor plan grid exists\'');
	ok($pltregistrationpageone->is_element_present("Property-Units-1-bedroom_nb"), 'Verify the row 2 of the floor plan grid exists, \'Row 2 of the floor plan grid exists\'');
    ok(!($pltregistrationpageone->is_visible("Property-Units-2-bedroom_nb")), 'Verify the row 3 of the floor plan grid is not visible, \'Row 3 of the floor plan grid is not visible\'');
	
}

1;

}
