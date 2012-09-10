package Test::Class::Selenium::TestCases::HotLead::TestHotLead;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::MultivariantTest::OctPage;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::SearchResultsPage;
use Test::Class::Selenium::PageObjects::PropertyDescriptionPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';
use Test::Class::Selenium::DataAccessObjects::PropertyDao;
use Test::Class::Selenium::DataAccessObjects::PickDao;

=head1 NAME

TestHotLead

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_renter_completes_hotlead

Verify basic hot lead functionality

Test Steps:

=over

=item 1. login to qa

=item 2. Search for a property

=item 3. View its pdp page

=item 4. click on 'Check Availability'

=item 5. In description enter valid form data

=item 6. submit hotlead 

=back

Expected Result:

User is able to submit hotlead.

=cut

sub test_renter_completes_hotlead: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $phone = "(310) 844-8952";
	my $date = "12/12/2020";

	$self->create_hotlead_pick_A_user_and_goto_search_results($email);

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');

	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	$propertydescriptionpage->click_check_availability();
	$propertydescriptionpage->fill_lead_form_box_info($fname, $lname, $phone, $date);	
	
	ok($propertydescriptionpage->is_text_present("Check Availability"), 'Verify check availability page opens up');
	
	$propertydescriptionpage->click_send();
	
	ok($propertydescriptionpage->is_text_present("your email has been sent to the property. This property will be saved under \"Contacted\" on My Rent.com."), 'Verify successful submission of lead');
	
	$propertydescriptionpage->close_form_box();	
		
}

=head3 test_renter_50_char_max_fname_and_lname_hotlead

Verify submission hotlead with 50 chars in first and last name (QA-50)

Test Steps:

=over

=item 1. login to qa

=item 2. Search for a property

=item 3. View its pdp page

=item 4. click on 'Check Availability'

=item 5. In description enter 50 chars in First Name and 50 chars in Last Name

=item 6. submit hotlead 

=back

Expected Result:

User is able to submit hotlead.

=cut

sub test_renter_50_char_max_fname_and_lname_hotlead: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(50);
	my $lname = $data->create_alpha_string(50);
	my $phone = "(310) 844-8952";
	my $date = "12/12/2099";

	$self->create_hotlead_pick_A_user_and_goto_search_results($email);

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');

	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	$propertydescriptionpage->click_check_availability();
	$propertydescriptionpage->fill_lead_form_box_info($fname, $lname, $phone, $date);	
	
	ok($propertydescriptionpage->is_text_present("Check Availability"), 'Verify check availability page opens up');
	
	$propertydescriptionpage->click_send();
	
	ok($propertydescriptionpage->is_text_present("your email has been sent to the property. This property will be saved under \"Contacted\" on My Rent.com."), 'Verify successful submission of lead');
	
	$propertydescriptionpage->close_form_box();		
}

=head3 test_renter_no_fname_and_lname_hotlead

Verify submission hotlead with 50 no fname or lname

Test Steps:

=over

=item 1. login to qa

=item 2. Search for a property

=item 3. View its pdp page

=item 4. click on 'Check Availability'

=item 5. In description enter no fname or lname

=item 6. submit hotlead 

=back

Expected Result:

User is unable to submit hotlead.

=cut

sub test_renter_no_fname_and_lname_hotlead: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = "";
	my $lname = "";
	my $phone = "(310) 844-8952";
	my $date = "12/12/2099";
	
	$self->create_hotlead_pick_A_user_and_goto_search_results($email);
	
	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
		
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');

	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	
	$propertydescriptionpage->click_check_availability();
	$propertydescriptionpage->fill_lead_form_box_info($fname, $lname, $phone, $date);	
	
	ok($propertydescriptionpage->is_text_present("Check Availability"), 'Verify check availability page opens up');
	
	$propertydescriptionpage->click_send();
	
	ok($propertydescriptionpage->is_text_present("Please enter a first name"), 'Verify error message on hotlead form - Please enter a first name');
	ok($propertydescriptionpage->is_text_present("Please enter a last name"), 'Verify error message on hotlead form - Please enter a last name');
	ok($propertydescriptionpage->is_text_present("Email Address"), 'Verify still on hotlead form page');
	
}

=head3 test_renter_no_phonenumber_hotlead

Verify user is recieves soft error message

Test Steps:

=over

=item 1. Login to QA

=item 2. Search for a property

=item 3. View its pdp page

=item 4. Click on 'Check Availability'

=item 5. Enter first name, last name,tab out from Phone field without entering data

=item 6. Enter a valid date, message description and submit the hot lead  
 
=back 

Expected Result:

Verify user is recieves soft error message

=cut

sub test_renter_no_phonenumber_hotlead: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $phone = "";
	my $date = "12/12/2020";

	$self->create_hotlead_pick_A_user_and_goto_search_results($email);

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
	$searchresultspage->submit_password();

	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	$propertydescriptionpage->click_check_availability();
	$propertydescriptionpage->fill_lead_form_box_info($fname, $lname, $phone, $date);	
		
	ok($propertydescriptionpage->is_text_present("Check Availability"), 'Verify check availability page opens up');
	ok($propertydescriptionpage->is_text_present("Email Address:"), 'Verify Email Address field is displayed');
	ok($propertydescriptionpage->is_text_present("Want more details about this property?"), 'Verify Want more details about this property text is present');
		
	$propertydescriptionpage->click_send();
		
	ok($propertydescriptionpage->is_text_present("your email has been sent to the property. This property will be saved under \"Contacted\" on My Rent.com."), 'Verify successful submission of lead');
		
	$propertydescriptionpage->close_form_box();
		
}

=head3 test_renter_completes_hotlead_cpa_property

Verify basic hot lead functionality for a CPA property

Test Steps:

=over 

=item 1. login to qa

=item 2. Get a CPA property

=item 3. View its pdp page

=item 4. click on 'Check Availability'

=item 5. In description enter valid form data

=item 6. submit hotlead 

=back

Expected Result:

User is able to submit hotlead.

=cut

sub test_renter_completes_hotlead_cpa_property: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $phone = "(310) 844-8952";
	my $date = "12/12/2020";
	my $terminate_xt = 'Active';
	my $businessmodel_tp = 'cpa';
	my $property_id = '427608';

	$self->create_hotlead_pick_A_user_and_goto_search_results($email);

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	#Append the cpa property id to the URL to get the PDP
	$searchresultspage->open_page('/rentals/'.$property_id);
	    
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	ok($propertydescriptionpage->is_text_present("Claim reward now!"), 'Verify you are on a CPA PDP page');
	ok($propertydescriptionpage->is_text_present("Remind me to claim my \$100"), 'Verify you are on a CPA PDP page');

	$propertydescriptionpage->click_check_availability();
	$propertydescriptionpage->fill_lead_form_box_info($fname, $lname, $phone, $date);	
	ok($propertydescriptionpage->is_text_present("Check Availability"), 'Verify check availability page opens up');
	$propertydescriptionpage->click_send();
	ok($propertydescriptionpage->is_text_present("your email has been sent to the property. This property will be saved under \"Contacted\" on My Rent.com."), 'Verify successful submission of lead');
	$propertydescriptionpage->close_form_box();	
}

=head3 test_renter_completes_hotlead_plt_property

Verify basic hot lead functionality for a CPA property

Test Steps:

=over

=item 1. Login to qa

=item 2. Get a PLT property

=item 3. View its pdp page

=item 4. Click on 'Check Availability'

=item 5. In description enter valid form data

=item 6. Submit hotlead 

=back

Expected Result:

User is able to submit hotlead for a plt property.

=cut

sub test_renter_completes_hotlead_plt_property: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $phone = "(310) 566-7752";
	my $date = "12/12/2020";
	my $terminate_xt = 'Active';
	my $businessmodel_tp = 'plt';
	
	#Get new existing plt property using propertydao
	my $propertydao = Test::Class::Selenium::DataAccessObjects::PropertyDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $property_id = $propertydao->get_most_recent_property_by_terminate_xt_and_businessmodel_tp($terminate_xt, $businessmodel_tp);

	$self->create_hotlead_pick_A_user_and_goto_search_results($email);

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	#Append the PLT property id to the URL to get the PDP
	$searchresultspage->open_page('/rentals/'.$property_id);
    
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
    ok(($propertydescriptionpage->is_text_present("Claim reward now!")==0), 'Verify you are on a Small Property PDP page');
 
	$propertydescriptionpage->click_check_availability();
	$propertydescriptionpage->fill_lead_form_box_info($fname, $lname, $phone, $date);	
	ok($propertydescriptionpage->is_text_present("Check Availability"), 'Verify check availability page opens up');
	$propertydescriptionpage->click_send();
	ok($propertydescriptionpage->is_text_present("your email has been sent to the property. This property will be saved under \"Contacted\" on My Rent.com."), 'Verify successful submission of lead');
	$propertydescriptionpage->close_form_box();	
		
}

=head3 test_renter_completes_hotlead_with_toll_free_number

Verify basic hot lead functionality

Test Steps:

=over

=item 1. login to qa

=item 2. Search for a property

=item 3. View its pdp page

=item 4. click on 'Check Availability'

=item 5. In description enter valid form data, with toll free number

=item 6. submit hotlead 

=back

Expected Result:

User is able to submit hotlead.

=cut

sub test_renter_completes_hotlead_with_toll_free_number: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $phone = "(877) 855-1619";
	my $date = "12/12/2020";

	$self->create_hotlead_pick_A_user_and_goto_search_results($email);

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');

	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	
	$propertydescriptionpage->click_check_availability();
	$propertydescriptionpage->fill_lead_form_box_info($fname, $lname, $phone, $date);	
	
	ok($propertydescriptionpage->is_text_present("Check Availability"), 'Verify check availability page opens up');
	
	$propertydescriptionpage->click_send();
	
	ok($propertydescriptionpage->is_text_present("your email has been sent to the property. This property will be saved under \"Contacted\" on My Rent.com."), 'Verify successful submission of lead');
	
	$propertydescriptionpage->close_form_box();	
		
}

=head3 test_renter_can_complete_hotlead_with_855_number

Verify basic hot lead functionality

Test Steps:

=over

=item 1. login to qa

=item 2. Search for a property

=item 3. View its pdp page

=item 4. click on 'Check Availability'

=item 5. In description enter valid form data, with toll free number

=item 6. submit hotlead with phone number (855) 873-1911

=back

Expected Result:

User is able to submit hotlead.

=cut

sub test_renter_can_complete_hotlead_with_855_number: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $phone = "(855) 873-1911";
	my $date = "12/12/2020";

	$self->create_hotlead_pick_A_user_and_goto_search_results($email);

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');

	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	$propertydescriptionpage->click_check_availability();
	$propertydescriptionpage->fill_lead_form_box_info($fname, $lname, $phone, $date);	
	
	ok($propertydescriptionpage->is_text_present("Check Availability"), 'Verify check availability page opens up');
	
	$propertydescriptionpage->click_send();
	
	ok($propertydescriptionpage->is_text_present("your email has been sent to the property. This property will be saved under \"Contacted\" on My Rent.com."), 'Verify successful submission of lead');
	
	$propertydescriptionpage->close_form_box();	
		
}

=head3 create_hotlead_pick_A_user($email)

Create a new pick A user, and end up on the search results page.

=cut

sub create_hotlead_pick_A_user_and_goto_search_results {
	my($self, $email) = @_;

	my $city = 'Santa Monica';
	my $state = 'CA';
	my $min = '$200';
	my $max = '$5000+';
	my $room = '1+';
	
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $octpage = Test::Class::Selenium::PageObjects::MultivariantTest::OctPage->new($self);

	# Set homepage pick
	my $user_id = $pickdao->homepage_get_user_pick_A();
	$octpage->homepage_set_pick($user_id);
	ok($octpage->is_text_present($user_id), 'Verify user pick set to Homepage - Control version');
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	$landingpage->open('/');
	$landingpage->pause('5000');
	$landingpage->view_the_latest_listings($city, $state, $min, $max, $room, $email);	

	#set pick A for optional password
	$pickdao->password_set_pick_A($email);
	#set pick A for search
	#$pickdao = $pickdao->search_set_pick_A($email);
	#set pick A for hotlead phone number
	$pickdao->hotleadphonenumber_set_pick_A($email);

	$landingpage->refresh();

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->submit_password();

}

1;

}
