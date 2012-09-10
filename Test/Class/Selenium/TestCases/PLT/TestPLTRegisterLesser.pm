package Test::Class::Selenium::TestCases::PLT::TestPLTRegisterLesser;

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

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_new_lesser

Verify Register as a new PLT lesser - Single Vacancy Pricing (1-4 Units)

Test Steps:

=over

=item

=back

=cut

sub test_new_lesser: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	#my $email = "remiguel_019_qa03_plt\@rent.com";
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $phonenumber = "(453) 453-4534";
	my $zipcode = "90404";		

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->continue_to_step_two($email, "qatest11", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
	$pltregistrationpageone->pause("30000");
	ok($pltregistrationpageone->is_text_present("Basic Listing Information"), 'Verify Property registration page 2');
	
	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);
	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertyname, $email, $phonenumber);
	
	my $pltregistrationpagethree = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage->new($self);

	ok($pltregistrationpagethree->is_text_present("Submit your listing today and start receiving leads!"), 'Verify Property registration page 3');		
	$pltregistrationpagethree->submit_listing();
	
	ok($pltregistrationpagethree->is_text_present("Thank you for using Rent.com to fill your vacancies!"), 'Verify Successful registration');

}

=head3 test_new_lesser

Verify Register as a new PLT lesser - Single Vacancy Pricing (1-4 Units), with a toll free number:  (877) 776-2516

Test Steps:

=over

=item

=back

=cut

sub test_new_lesser_with_toll_free_number: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	#my $email = "remiguel_019_qa03_plt\@rent.com";
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $phonenumber = "(877) 776-2516";
	my $zipcode = "90404";		

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->continue_to_step_two($email, "qatest11", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
	$pltregistrationpageone->pause("30000");
	ok($pltregistrationpageone->is_text_present("Basic Listing Information"), 'Verify Property registration page 2');
	
	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);
	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertyname, $email, $phonenumber);
	
	my $pltregistrationpagethree = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage->new($self);

	ok($pltregistrationpagethree->is_text_present("Submit your listing today and start receiving leads!"), 'Verify Property registration page 3');		
	$pltregistrationpagethree->submit_listing();
	
	ok($pltregistrationpagethree->is_text_present("Thank you for using Rent.com to fill your vacancies!"), 'Verify Successful registration');

}

=head3 test_new_lesser_creates_two_properties

Verify Register as a new lesser PLT and create 2 properties

Test Steps:

=over

=item

=back


=cut

sub test_new_lesser_creates_two_properties: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	#my $email = "remiguel_020_qa03_plt\@rent.com";
	my $propertynameone = $data->create_alpha_string(10);
	my $propertynametwo = $data->create_alpha_string(10);
	my $propertyaddressone = $data->create_address(5);
	my $propertyaddresstwo = $data->create_address(7);
	my $phonenumber = "(453) 453-4534";
	my $zipcode = "90404";	
	
	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->continue_to_step_two($email, "qatest11", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
	print "\n#Email of user:  ".$email."\n";
	ok($pltregistrationpageone->is_text_present("Basic Listing Information"), 'Verify Property registration page 2');

	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);
	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertynameone, $email, $phonenumber);
		
	my $pltregistrationpagethree = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage->new($self);
	ok($pltregistrationpagethree->is_text_present("Submit your listing today and start receiving leads!"), 'Verify Property registration page 3');
	$pltregistrationpagethree->pause("5000");
	$pltregistrationpagethree->submit_listing();
		
	ok($pltregistrationpagethree->is_text_present("Thank you for using Rent.com to fill your vacancies!"), 'Verify Successful registration');

	$pltregistrationpagethree->click_manage_my_listings();
	
	#click add new listing	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->click_add_new_listing();
	# IB-4506 (Pricing Changes)
	$manageraccountpage->click_add_listing_plt_button_singlevacancy($zipcode);

	$pltregistrationpageone->continue_to_step_two_existing_user($propertyaddresstwo, "Santa Monica", "CA", "90404", "1200");
	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertynametwo, $email, $phonenumber);
	$pltregistrationpagethree->submit_listing_existing_user();

	ok($pltregistrationpagethree->is_text_present("Thank you for using Rent.com to fill your vacancies!"), 'Verify creation of second property');

	$pltregistrationpagethree->click_manage_my_listings();
	#$manageraccountpage->click_select_listing_to_edit();
		
	$manageraccountpage->wait_for_text_present($propertynameone, $self->{set_timeout});
		
	ok($manageraccountpage->is_text_present($propertynameone), 'Verify address of property name 1');
	ok($manageraccountpage->is_text_present($propertynametwo), 'Verify address of property name 2');

}

=head3 test_existing_email

Test Steps:

=over

=item

=back


=cut

sub test_existing_email: Test(no_plan)
{
	my($self) = @_;
	
	my $email = $self->{plt_username};
	my $zipcode = "90404";	

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
	$pltregistrationpageone->continue_to_step_two($email, "qatest11", "123 asdf", "Santa Monica", "CA", $zipcode, "1200");
	ok($pltregistrationpageone->is_text_present("This email address is already in use."), 'Verify existing username');
}

=head3 test_invalid_format_email

Test Steps:

=over

=item

=back

=cut

sub test_invalid_format_email: Test(no_plan)
{
	my($self) = @_;

	my $email = "abcdefghi";
	my $zipcode = "90404";	

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
	
	$pltregistrationpageone->fill_create_account($email, "qatest11");
	$pltregistrationpageone->click_step_two_button();
	ok($pltregistrationpageone->is_text_present("Please enter a valid email address"), 'Verify user was not able to continue');

}

=head3 test_create_an_account

Test Steps:

=over

=item

=back

=cut

sub test_create_an_account: Test(no_plan)
{

my($self) = @_;
	
	my $zipcode = "90404";	

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
	ok($pltregistrationpageone->is_text_present("Create An Account"), 'Verify User is on Create An Account page - Create An Account');	
	ok($pltregistrationpageone->is_text_present("Email Address"), 'Verify User is on Create An Account page - Email Address');	
	ok($pltregistrationpageone->is_text_present("Property Information"), 'Verify User is on Create An Account page - Property Information');	
	# IB-4605 (Pricing Changes):  Floor Plan module removed and now combined with Property Info module
	# ok($pltregistrationpageone->is_text_present("Floor Plan Information"), 'Verify User is on Create An Account page - Floor Plan Information');	
	
}

=head3 test_user_is_logged_out

Create a new PLT lesser and verify user is logged out

Test Steps:

=over

=item

=back

=cut

sub test_user_is_logged_out: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	#my $email = "remiguel_019_qa03_plt\@rent.com";
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $phonenumber = "(453) 453-4534";
	my $zipcode = "90404";

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->continue_to_step_two($email, "qatest11", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
	$pltregistrationpageone->pause("30000");
	ok($pltregistrationpageone->is_text_present("Basic Listing Information"), 'Verify Property registration page 2');
	
	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);
	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertyname, $email, $phonenumber);
		
	my $pltregistrationpagethree = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage->new($self);
	# IB-4506 (Pricing Changes)
	# ok($pltregistrationpagethree->is_text_present("Premium Advertising that Works"), 'Verify Property registration page 3');
	ok($pltregistrationpagethree->is_text_present("Submit your listing today and start receiving leads!"), 'Verify Property registration page 3');
	$pltregistrationpagethree->pause("5000");
	$pltregistrationpagethree->submit_listing();
		
	ok($pltregistrationpagethree->is_text_present("Thank you for using Rent.com to fill your vacancies!"), 'Verify Successful registration');
	$pltregistrationpagethree->sign_out();
	ok($pltregistrationpagethree->is_text_present("Sign In"), 'Verify user is on logged out page');

}

=head3 test_user_does_not_have_an_account

Test Steps:

=over

=item

=back

=cut

sub test_user_does_not_have_an_account: Test(no_plan)
{

my($self) = @_;
	
	my $zipcode = "90404";
	
	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
	ok($pltregistrationpageone->is_text_present("Create An Account"), 'Verify User is on Create An Account page - Create An Account');	
	ok($pltregistrationpageone->is_text_present("Email Address"), 'Verify User is on Create An Account page - Email Address');	
	ok($pltregistrationpageone->is_text_present("Property Information"), 'Verify User is on Create An Account page - Property Information');	
	
}

=head3 test_user_account_already_exists

Test Steps:

=over

=item

=back

=cut

sub test_user_account_already_exists: Test(no_plan)
{
	my($self) = @_;

	my $zipcode = "90404";
	
    my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	
    $loginpage->sign_in($self->{plt_username},$self->{plt_password});
	$self->go_to_plt_page_logged_in();
	
	# IB-4506 (Pricing Changes)
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->click_add_new_listing();

	$manageraccountpage->click_add_listing_plt_button_singlevacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);	
	ok(($pltregistrationpageone->is_text_present("Create An Account")==0), 'Verify User is on page 1 of PLT registration without the Create An Account section');	
	ok(($pltregistrationpageone->is_text_present("Email Address")==0), 'Verify User is on page 1 of PLT registration without the Email Address field');	
	ok(($pltregistrationpageone->is_text_present("Password")==0), 'Verify User is on page 1 of PLT registration without the Password field');	
	ok(($pltregistrationpageone->is_text_present("Reenter Password")==0), 'Verify User is on page 1 of PLT registration without the Reenter Password field');

}

=head3 test_user_does_not_complete_all_fields

Test Steps:

=over

=item

=back

=cut

sub test_user_does_not_complete_all_fields: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $zipcode = "90404";
	
	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
    $pltregistrationpageone->continue_to_step_two($email, "qatest11", "", "", "CA", $zipcode, "");
	ok($pltregistrationpageone->is_text_present("Please enter a street address."), 'Verify Error Messages on PLT New Listing Page 1 - Please enter a street address');
	ok($pltregistrationpageone->is_text_present("Please enter a valid city name."), 'Verify Error Messages on PLT New Listing Page 1 - Please enter a valid city name');
	ok($pltregistrationpageone->is_text_present("Please enter valid minimum rent amounts for all floorplans."), 'Verify Error Messages on PLT New Listing Page 1 - Please enter valid minimum rent amounts for all floorplans');
   
}

=head3 test_user_selects_income_restricted

Test Steps:

=over

=item

=back

=cut

sub test_user_selects_income_restricted: Test(no_plan)

{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
	$pltregistrationpageone->continue_to_step_two_income_restricted($email, "qatest11", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
	ok($pltregistrationpageone->is_text_present("Please specify at least one income restricted floorplan."), 'Verify Error Messages on PLT New Listing Page 1 - Please specify at least one income restricted floorplan');
	ok($pltregistrationpageone->is_text_present("Create An Account"), 'Verify user still on PLT New Listing Page 1 - Create An Account');
	ok($pltregistrationpageone->is_text_present(" Property Information"), 'Verify user still on PLT New Listing Page 1 -  Property Information');
        
}

=head3 test_property_information

Test Steps:

=over

=item

=back

=cut

sub test_property_information: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $zipcode = "90404";

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
    $pltregistrationpageone->continue_to_step_two($email, "qatest11", "", "", "CA", "", "1200");
	ok($pltregistrationpageone->is_text_present("Please enter a street address."), 'Verify Error Messages on PLT New Listing Page 1 Property Information - Please enter a street address');
	ok($pltregistrationpageone->is_text_present("Please enter a valid city name."), 'Verify Error Messages on PLT New Listing Page 1 Property Information - Please enter a valid city name');
	ok($pltregistrationpageone->is_text_present("Please enter a 5-digit zip code."), 'Verify Error Messages on PLT New Listing Page 1 Property Information - Please enter a 5-digit zip code');
   
}

=head3 test_emailaddress_tip

Test Steps:

=over

=item

=back

=cut

sub test_emailaddress_tip: Test(no_plan)
{
	my($self) = @_;
	
	my $zipcode = "90404";
		
	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
    ok($pltregistrationpageone->is_text_present("Create An Account"), 'Verify User is on Create An Account page - Create An Account');	
	ok($pltregistrationpageone->is_text_present("Email Address"), 'Verify User is on Create An Account page - Email Address');	
	ok($pltregistrationpageone->is_text_present("Property Information"), 'Verify User is on Create An Account page - Property Information');	
	# IB-4605 (Pricing Changes):  Floor Plan module removed and now combined with Property Info module
	# ok($pltregistrationpageone->is_text_present("Floor Plan Information"), 'Verify User is on Create An Account page - Floor Plan Information');
	$pltregistrationpageone->click_emailaddress_field();
	ok($pltregistrationpageone->is_text_present("Creating an account allows you to access our listing management tools and receive statements, lead notifications, and important account updates."),'Verify user is shown the email address tool tip');
	ok($pltregistrationpageone->is_text_present("We never share your email address without your consent"),'Verify user is shown the email address tool tip');
      
	
}

=head3 test_check_password_match

Test Steps:

=over

=item

=back

=cut

sub test_check_password_match: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $password1 = '';
	my $password2 = '';
	# Presently upon script run, you will get a warning - Use of uninitialized 
	# value $password2 in string eq at 
	#/home/deepak/workspace/rent/lib/Test/Class/Selenium/TestPLTRegisterLesser.pm line 473.
	# which can be ignored
	my $zipcode = "90404";
	
	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);
	ok($pltregistrationpageone->is_text_present("Create An Account"), 'Verify User is on Create An Account page - Create An Account');	
	ok($pltregistrationpageone->is_text_present("Email Address"), 'Verify User is on Create An Account page - Email Address');	
	ok($pltregistrationpageone->is_text_present("Property Information"), 'Verify User is on Create An Account page - Property Information');	
	# IB-4506 (Pricing Changes):  Floor Plan Info info removed and combined with Property Info module
	# ok($pltregistrationpageone->is_text_present("Floor Plan Information"), 'Verify User is on Create An Account page - Floor Plan Information');
	$pltregistrationpageone->fill_create_account($email, "testing","testing");
	$pltregistrationpageone->pause("30000");
	($password1,$password2)=$pltregistrationpageone->get_password();
	
	ok($password1 eq $password2,"Verify password 1 equals password 2");	  
	
}

1;

}
