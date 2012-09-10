package Test::Class::Selenium::TestCases::Popular::TestLandingPage;

use strict;
use warnings;
use Test::Simple;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

TestLandingPage - This Test modules verifies the Landing page of Rent.com

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{
BEGIN { $ENV{DIE_ON_FAIL} = 1 }

=head3 test_159() : Verify the mandatory fields

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. Without entering the data in any field click on view the latest listings button

=back

Expected Result:

=over

=item 1.“Please enter a city”

=item 2.“Please choose a State”

=item 3.“Please enter a valid email address(i.e user@domain.com)”

=back

Should appear at the top of the screen

=cut

	sub test_159 : Test(no_plan) {
		my ($self) = @_;
		$ENV{tc_name}= 'Verify the mandatory fields';
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		ok(1 == 1);
		#$startpage->click_property_tab();
		#$startpage->click_view_listings();
		#ok($startpage->is_text_present("Please enter a city"),'Verify User is shown message to fill city');
		#ok($startpage->is_text_present("Please choose a state"), 'Verify User is shown message to select a state');
		#ok($startpage->is_text_present("Please enter a valid email address (i.e. user\@domain.com)"), 'Verify User is shown message to fill email address');
	}

=head3 test_160()

Verify the Registration with only city

Test Steps:

=over

=item 1.Open the application and Click on Search Properties Tab

=item 2.Enter the data in only city field and click on view the latest listings button 

=back

Expected Result:

=over

=item 1.“Please choose a State”

=item 2.“Please enter a valid email address(i.e user@domain.com)”

=back

Should appear at the top of the screen

=cut

	sub test_160 : Test(no_plan) {
		$ENV{tc_name} = 'Verify the Registration with only city';
		my ($self) = @_;
		      		
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		$startpage->enter_city("New York");
		$startpage->click_view_listings();
		ok($startpage->is_text_present("Please choose a state"), 'Verify User is shown message to select a state');
		ok($startpage->is_text_present("Please enter a valid email address (i.e. user\@domain.com)"), 'Verify User is shown message to fill email address');
	}

=head3 test_161() : Verify the Registration with  city and state

Test Steps:

=over

=item 1.Open the application and Click on Search Properties Tab

=item 2.Enter the data in city field , Select a state from drop down and click on view the latest listings button 

=back

Expected Result:

=over

=item 1.“Please enter a valid email address(i.e user@domain.com)”

=back

Should appear at the top of the screen

=cut

	sub test_161 : Test(no_plan) {
		$ENV{tc_name} = 'Verify the Registration with  city and state ';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		$startpage->enter_city("New York");
		$startpage->select_state("NY");
		$startpage->click_view_listings();
		ok($startpage->is_text_present("Please enter a valid email address (i.e. user\@domain.com)"), 'Verify User is shown message to fill email address');
	}

=head3 test_162() : Verify the Registration with only email address

Test Steps:

=over

=item 1.Open the application and Click on Search Properties Tab

=item 2.Enter the data in only email address field and click on view the latest listings button 

=back

Expected Result:

=over

=item 1.“Please enter a city”

=item 2.“Please choose a State”

=back

Should appear at the top of the screen

=cut

	sub test_162 : Test(no_plan) {
		$ENV{tc_name} = 'Verify the Registration with only email address';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		$startpage->select_email_address("dbdf23847\@hdf.com");
		$startpage->click_view_listings();
		ok($startpage->is_text_present("Please enter a city"), 'Verify User is shown message to fill city');
		ok($startpage->is_text_present("Please choose a state"), 'Verify User is shown message to select a state');
	}	

=head3 test_163() : Verify the Registration with only state

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. Select a state from drop down and click on view the latest listings button

=back

Expected Result:

=over

=item 1. “Please enter a city”

=item 2. “Please enter a valid email address(i.e user@domain.com)”

=back

Should appear at the top of the screen

=cut

	sub test_163 : Test(no_plan) {
		$ENV{tc_name} = 'Verify the Registration with only state';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		$startpage->select_state("NY");
		$startpage->click_view_listings();
		ok($startpage->is_text_present("Please enter a city"), 'Verify User is shown message to fill city field');
		ok($startpage->is_text_present("Please enter a valid email address (i.e. user\@domain.com)."),'Verify user is shown message to enter email id');

	}	


=head3 test_164() : Verify the Registration with  email address and state

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. Enter the data in email address field , select a state from the drop down and click on view the latest listings button

=back

Expected Result:

=over

=item 1. “Please enter a city”

=back

Should appear at the top of the screen

=cut

	sub test_164 : Test(no_plan){
		$ENV{tc_name} = 'Verify the Registration with  email address and state';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		$startpage->select_state("NY");
		$startpage->select_email_address("dbdf23847\@hdf.com");
		$startpage->click_view_listings();
		ok($startpage->is_text_present("Please enter a city"), 'Verify User is shown message to fill city field');
		
	}

=head3 test_165() : Verify the Registration with  city and email address

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. Enter the data in city field , email address field and click on view the latest listings button

=back

Expected Result:

=over

=item 1. “Please choose a state”

=back

Should appear at the top of the screen

=cut

	sub test_165 : Test(no_plan){
		$ENV{tc_name} = 'Verify the Registration with  city and email address';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		$startpage->enter_city("New York");
		$startpage->select_email_address("dbdf23847\@hdf.com");
		$startpage->click_view_listings();
		ok($startpage->is_text_present("Please choose a state"), 'Verify User is shown message to select a state');
	}

=head3 test_166() : Verify the Registration with  city,state and existing email address

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. Enter the data in city field , Select a state from drop down enter already registered email address in the email address fields and click on view the latest listings button

=back

Expected Result:

=over

=item 1. An account has already been created using the email address you've entered. If you've previously registered with Rent.com, please signin.

=back

Should appear at the top of the screen

=cut
	
	sub test_166 : Test(no_plan){
		$ENV{tc_name} = 'Verify the Registration with  city,state and existing email address';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		$startpage->enter_city("New York");
		$startpage->select_state("NY");
		$startpage->select_email_address("test\@qa.com");
		$startpage->click_view_listings();
		my $msg = "An account has already been created using the email address you've entered. If you've previously registered with Rent.com, please sign in.";
		ok($startpage->is_text_present($msg), 'Verify User is shown message regarding user validation');
	
	}

=head3 test_167() : Verify the Registration with  city,state and Valid email address

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. Enter the data in all the fields and click on view the latest listings button

=back

Expected Result:

=over

=item 1. All search properties of that city should be displayed

=back

=cut
	
	sub test_167 : Test(no_plan){
		$ENV{tc_name} = 'Verify the Registration with  city,state and a valid new email address';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		$startpage->enter_city("New York");
		$startpage->select_state("NY");
		my $mailobj = Test::Class::Selenium::Util::GenerateData->new();
		my $email = $mailobj->create_email();
		$email = lc($email);
		$startpage->select_email_address($email);
		$startpage->click_view_listings();
		my $msg = "Signed in as";
		ok($startpage->is_text_present($msg), 'Verify User is Signed in.');
		ok($startpage->is_text_present($email),'Verify user is shown his mail id only');
	}

=head3 test_168() : Search properties by Popular Cities option in Search Properties tab

Test Steps:

=over

=item 1. Open the Internet Explorer

=item 2. Enter the application URL

=item 3. Click on Search Properties Tab

=back

Expected Result:

=over

=item 1. Search Properties screen should be displayed

=back

=cut

	sub test_168 : Test(no_plan){

		$ENV{tc_name} = 'Verify the Popular Cities Page';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		my $header = "Start your FREE search by popular cities now!";
		ok($startpage->is_text_present($header),'Verify the Heading of Page');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->POPULARLINK),'Verify popular cities is selected by default');
		
	}

=head3 test_169() : Search Properties screen should be displayed

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. Check whether the Registration dialog box is present

=back

Expected Result:

=over

=item 1. Verify the fields in the Registration block available from the Popular Cities option in Search Properties tab

=back

=cut

	sub test_169 : Test(no_plan){
		$ENV{tc_name} = 'Verify the Registration fields in Registration block';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->TFIELD_CITY),'Verify City Field is Present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->DDOWN_STATE),'Verify State Dropdown is Present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->DDOWN_MINRENT),'Verify Minimum rent Dropdown is Present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->DDOWN_MAXRENT),'Verify Maximum Dropdown is Present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->TFIELD_EMAIL),'Verify Email Field is Present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->DDOWN_BEDROOMS),'Verify DropDown to select Bedrooms is present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->BUTTON_VIEWLISTINGS),'Verify View All Listings is Present');
		my $msg = "We never rent or sell your email address without your consent. ";
		$msg = $msg."Rent.com will occasionally email you property listings";
		ok($startpage->is_text_present($msg),'Verify the Trust e Logo Text');
	}

=head3 test_170() : Registration dialog box should be present

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. verify the fields available in the Registration Section

=back

Expected Result:

=over

=item 1. Following fields should be available in the registration block

Search Rent.com magnifier
City

State

Min Price

Max Price

Bedrooms

Email Address

VIEW THE LATEST LISTINGS >> button

TRUSTe logo #Logo is not tested as it is not present

Text

=back

=cut

	sub test_170 : Test(no_plan){
		$ENV{tc_name} = 'Verify the Given Fields';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->TFIELD_CITY),'Verify City Field is Present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->DDOWN_STATE),'Verify State Dropdown is Present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->DDOWN_MINRENT),'Verify Minimum rent Dropdown is Present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->DDOWN_MAXRENT),'Verify Maximum Dropdown is Present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->TFIELD_EMAIL),'Verify Email Field is Present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->DDOWN_BEDROOMS),'Verify DropDown to select Bedrooms is present');
		ok($startpage->is_element_present(Test::Class::Selenium::PageObjects::LandingPage->BUTTON_VIEWLISTINGS),'Verify View All Listings is Present');
		my $msg = "We never rent or sell your email address without your consent. ";
		$msg = $msg."Rent.com will occasionally email you property listings";
		ok($startpage->is_text_present($msg),'Verify the Trust e Logo Text');
	}

=head3 test_172() : Verify the Text next to the TRUSTe logo in the registration block  available from the Popular Cities option in Search Properties tab

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. Verify the Text next to the TRUSTe logo in the registration block

=back

Expected Result:

=over

=item 1. We never rent or sell your email address without your consent.

=item 2. Rent.com will occasionally email you property listings should be displayed next to the TRUSTe logo


=back

=cut

	sub test_172 : Test(no_plan){
		$ENV{tc_name} = 'Verify the Trust e Logo Text';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
		$startpage->click_property_tab();
		my $msg = "We never rent or sell your email address without your consent. ";
		$msg = $msg."Rent.com will occasionally email you property listings";
		ok($startpage->is_text_present($msg),'Verify the Trust e Logo Text');
	}

=head3 test_173() : Open Privacy Policy link functionality available in the registration block available from the Popular Cities option in Search Properties tab

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. Click on the Privacy Policy link available in the registration block

=back

Expected Result:

=over

=item 1. Privacy Policy screen should be displayed

=back

=cut

	sub test_173 : Test(no_plan){
		$ENV{tc_name} = 'Verify the Privacy Policy Link at Footer';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
			$startpage->click_property_tab();
			$startpage->click_pol_footer();
		ok($startpage->is_page_title_present("Rent.com: Privacy Policy"),'Verify Title of Privacy Policy Page');
		my $header = $startpage->get_text("//h1");
		ok($header eq "Privacy Policy",'Privacy Policy link at footer loads required page');
	}	

=head3 test_174() : Verify the Privacy Policy link functionality available in the footer section available from the Popular Cities option in Search Properties tab

Test Steps:

=over

=item 1. Open the application and Click on Search Properties Tab

=item 2. Click on the Privacy Policy link available in the footer section of the  screen

=back

Expected Result:

=over

=item 1. Privacy Policy screen should be displayed

=back

=cut

	sub test_174 : Test(no_plan){

		$ENV{tc_name} = 'Verify the Privacy Policy Link Below Registration Fields';
		my ($self) = @_;
		my $startpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
			$startpage->click_property_tab();
			$startpage->click_pol_regLink();
		ok($startpage->is_page_title_present("Rent.com: Privacy Policy"),'Verify Title of Privacy Policy Page');
		my $header = $startpage->get_text("//h1");
		ok($header eq "Privacy Policy",'Privacy Policy link at footer loads required page');
		
	}	

	1;

}