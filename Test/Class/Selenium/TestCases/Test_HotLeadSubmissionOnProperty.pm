package Test::Class::Selenium::TestCases::Test_HotLeadSubmissionOnProperty;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::SearchResultsPage;
use Test::Class::Selenium::PageObjects::PropertyDescriptionPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

Test_HotLeadSubmissionOnProperty

=head1 SYNOPSIS

This test is meant to sent n number leads to a tester defined property

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_renter_completes_hot_leads 

This routine will send hot leads to a particular property.  To modify this routine, the tester will 
need to update 2 variables:

=over

=item 1.  $property_id

=item 2.  $number_of_leads

=back

$property_id is the property that is going to recieve the number of leads.  The property will have to be 
active.
$number_of_leads is the number of leads that you would like to send to the property.

=cut

sub test_renter_completes_hot_leads: Test(no_plan)
{
	my($self) = @_;
	
	#Modify these 2 variables
	my $propertyid = "9877990";#<-Modify this variable
	my $number_of_leads = 15;#<-Modify this variable
		
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $phone = "(310) 844-8952";
	my $date = "12/12/2099";
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	
	my $i;
	
	for ($i = 1; $i <= $number_of_leads; $i++){

		$email = $data->create_email();
		$fname = $data->create_alpha_string(10);
		$lname = $data->create_alpha_string(10);

		$landingpage->open_page('/');
		$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$200", "\$5000+", "1+", $email);		
		ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify you are brought to Search page after signup');

		ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
		$searchresultspage->submit_password();

		$searchresultspage->open_page("/rentals/".$propertyid);  #remiguel_plt_041@rent.com

		SKIP:
		{
			skip('Because of selenium error message', 1) if($self->{browser_type} eq "*iexploreproxy" || $self->{browser_type} eq "*iexplore");
				#Current window or frame is closed!)

			$propertydescriptionpage->click_check_availability();
			$propertydescriptionpage->fill_lead_form_box_info($fname, $lname, $phone, $date);	
			ok($propertydescriptionpage->is_text_present("Check Availability"), 'Verify check availability page opens up');
			$propertydescriptionpage->click_send();
			ok($propertydescriptionpage->is_text_present("your email has been sent to the property. This property will be saved under \"Contacted\" on My Rent.com."), 'Verify successful submission of lead');
			$propertydescriptionpage->close_form_box();	
		}
	$propertydescriptionpage->sign_out();
	}
}

1;

}