package Test::Class::Selenium::TestCases::PDP::TestPDP;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::SearchResultsPage;
use Test::Class::Selenium::PageObjects::PropertyDescriptionPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use Test::Class::Selenium::DataAccessObjects::PickDao;
use base 'Test::Class::Selenium::TestCases::BaseTest';


=head1 NAME

TestSearch - This Test Class verifies search

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_pdp_sendtofriend

Verify Send-to-a-Friend links works correctly on the PDP page

Test Steps:

Expected Result(s):

Renter successfully submits Send-to-a-Friend email.

=cut

sub test_pdp_sendtofriend: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $phone = "(310) 844-8952";
	my $date = "12/12/2020";
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});

	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	# Set homepage pick
	my $user_id = $pickdao->homepage_get_user_pick_A();
	$landingpage->homepage_set_pick($user_id);
	ok($landingpage->is_text_present($user_id), 'Verify user pick set to Homepage - Control version');
	$landingpage->open('/');
	$landingpage->pause('5000');

	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$200", "\$5000+", "1+", $email);	

	#set pick A for optional password
	$pickdao->password_set_pick_A($email);
	#set pick A for search
	#$pickdao = $pickdao->search_set_pick_A($email);
	#set pick A for hotlead phone number
	$pickdao->hotleadphonenumber_set_pick_A($email);

	$landingpage->refresh();
		
	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->submit_password();
	
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');

	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	
	$propertydescriptionpage->click_send_to_a_friend();
	$propertydescriptionpage->fill_sendtofriend_form_box_info($fname, $lname, $email);	
	
	ok($propertydescriptionpage->is_text_present("Send to a Friend"), 'Verify Send-to-a-Friend popup opens');
	
	$propertydescriptionpage->click_send();
	
	ok($propertydescriptionpage->is_text_present("Thank you. Your message has been sent."), 'Verify successful submission of Send-to-a-Friend email');
	
	$propertydescriptionpage->close_form_box();	
}

sub test_pdp_mediaviewer: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $phone = "(310) 844-8952";
	my $date = "12/12/2020";
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});

	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	# Set homepage pick
	my $user_id = $pickdao->homepage_get_user_pick_A();
	$landingpage->homepage_set_pick($user_id);
	ok($landingpage->is_text_present($user_id), 'Verify user pick set to Homepage - Control version');
	$landingpage->open('/');
	$landingpage->pause('5000');

	$landingpage->view_the_latest_listings("Arvada", "CO", "\$1000", "\$2500", "2+", $email);	

	#set pick A for optional password
	$pickdao->password_set_pick_A($email);
	#set pick A for search
	#$pickdao = $pickdao->search_set_pick_A($email);
	#set pick A for hotlead phone number
	$pickdao->hotleadphonenumber_set_pick_A($email);

	$landingpage->refresh();
		
	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->submit_password();
	
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');

	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	
	$propertydescriptionpage->click_enlarge_image();
	ok($propertydescriptionpage->is_text_present("Photos"), 'Verify Media Viewer popup opens');
	
	if ($propertydescriptionpage->is_text_present("Photos"))
	{
		# The following asserts assume the current listing contains more than one Photo.
		# If these asserts fail, change the search parameters specified in line 113 - "$landingpage->view_the_latest_listings(...)"
		$propertydescriptionpage->click_mediaviewer_next();
		ok ($propertydescriptionpage->is_text_present("2 of"), 'Verify Media View Next button moves to next image');
		
		$propertydescriptionpage->click_mediaviewer_previous();
		ok($propertydescriptionpage->is_text_present("1 of"), 'Verify Media Viewer Previous button moves to previous image');	
	}
		
	if ($propertydescriptionpage->is_text_present("Floor Plans"))
	{
		$propertydescriptionpage->click_mediaviewer_floorplans();
		ok($propertydescriptionpage->is_text_present("Floorplan"), 'Verify Media Viewer Floor Plans link displays floor plan');
	}
}

1;

}