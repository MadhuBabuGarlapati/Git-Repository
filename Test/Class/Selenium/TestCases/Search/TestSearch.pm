package Test::Class::Selenium::TestCases::Search::TestSearch;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
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

=head3 test_basic_search

Verify basic search functionality

Test Steps:

Expected Result:

Search results page is displayed

=cut

sub test_basic_search: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->wait_for_text_present('Sign Out', '30000'), 'Verify User is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->get_search_results("90503", "\$2000", "\$5000+", "Studio+", "1+");		
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify Search results');

	#Check as per QA-82 (Automate Search Test Case: Search by landmark and verify distance.)
	ok($searchresultspage->is_text_present("Rentals within 2 miles of 90503"), 'Verify that there are properties within 2 miles of search:');

}

=head3 test_empty_city_search

Verify empty city search

Test Steps:

=over

=item 1. Sign in

=item 2. Search with empty city.

=back

Expected Result:

Error message is displayed

=cut

sub test_empty_city_search: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	#goto search page
	$searchresultspage->open_page("/search/results/");
	#do search with zip
	$searchresultspage->get_search_results("90404", "\$100", "\$5000+", "2+", "2+");		
	#do search without zip
	$searchresultspage->get_search_results("", "\$200", "\$400", "2+", "2+");		
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	ok($searchresultspage->is_text_present("Please enter both a city and state (Los Angeles, CA), or enter a 5-digit ZIP code (90025)."), 'Verify empty city&state or zip error message');
}

=head3 test_search_with_amenities

Verify search functionality with amenities and pet policy specified

Test Steps:

=over

=item 1. Sign in

=item 2. Search with basic search criteria.

=item 3. Click Amenities link/button.

=item 4. Specify one or more amenities.

=item 5. Save selected amenities.

=item 6. Select a Pet Policy.

=item 7. Click Search button.

=back

Expected Result:

Search results should be shown with the results matching the input criteria entered by user.

=cut

sub test_search_with_amenities: Test(no_plan)
{
	my($self) = @_;
	
	my @amenities_arr;
	my $num_amenities;
		
	# login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	# goto search page
	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->open_page("/search/results/");
	
	$searchresultspage->select_pet_policy('Cats OK');
	
	#select amenities
	@amenities_arr = $searchresultspage->select_amenities();
	
	# count number of amenities that were checked
	$num_amenities = scalar(@amenities_arr);
	
	# verify selected amenities are on PDP page
	$searchresultspage->click_on_first_property_more_info_button();
	my $propdescpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	my $pdp_page = $propdescpage->get_page_text();
	
	my $j = 1;
	while ( $j < $num_amenities )
	{
		ok($pdp_page =~ m/$amenities_arr[$j]/i, "Verify amenity $amenities_arr[$j] is present");
		$j++;
	}
	
}

=head3 test_search_by_property_name

Verify search functionality with a property name specified (QA-293)

Test Steps:

=over

=item 1. Sign in

=item 2. Search with basic search criteria.

=item 3. Specify property name. (note:  property name is hardcoded in .testrc properties file)

=item 4. Click Search button.

=back

Expected Result:

Search results should be shown with the results matching the property name entered by user.

=cut

sub test_search_by_property_name: Test(no_plan)
{
	my($self) = @_;
		
	# login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	# goto search page
	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->open_page("/search/results/");
	$searchresultspage->get_search_results("Los Angeles, CA", "\$100", "\$5000+", "Studio+", "1+");		
	
	# search by property name  
	$searchresultspage->search_by_property_name($self->{property_name});
	
	ok($searchresultspage->is_text_present($self->{property_name}), 'Verify property name is present on Search Results page.');
}

=head3 test_logged_out_pdp_view

Verify logged out pdp page view

Test Steps:

1. Go to /rentals/427608

Expected Result:

User should be re-directed to user logged-out PDP page

=cut

sub test_logged_out_pdp_view: Test(no_plan)
{
	my($self) = @_;
		
	# login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->open_page("/rentals/470533");
	ok($loginpage->is_text_present("For details about this property,"), 'Verify \'For details about this property,\' ');
	ok($loginpage->is_text_present("(it takes just 15 seconds!)"), 'Verify \'(it takes just 15 seconds!)\'');
}




=head3 test_restrictive_search

Verify restrictive

Test Steps:

=over

=item 1. Sign in

=item 2. Search for 100 dollar rent range for 3 bedrooms in AZ 

=back

Expected Result:

Error message is displayed

=cut

sub test_restrictive_search: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	#goto search page
	$searchresultspage->open_page("/search/results/");
	#do search with zip
	$searchresultspage->get_search_results("85250", "\$100", "\$100", "3+", "3+");		
			
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	ok($searchresultspage->is_text_present("Unfortunately, we did not find any rentals that matched every one of your search requirements. We recommend you search again using less specific criteria."), 'Verify restrictive search error message');
}

=head3 test_invalid_city_input

Verify invalid input for city

Test Steps:

=over

=item 1. Sign in

=item 2. Search for xxxxxxxxxxxxxxxx 

=back

Expected Result:

Error message is displayed

=cut

sub test_invalid_city_input: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	#goto search page
	$searchresultspage->open_page("/search/results/");
	#do search with zip
	$searchresultspage->get_search_results("xxxxxxxxxxxxxxxxxxxxxxxxxx", "\$100", "\$1000", "Studio+", "1+");		
			
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	ok($searchresultspage->is_text_present("Please enter both a city and state (Los Angeles, CA), or enter a 5-digit ZIP code (90025)."), 'Verify invalid city error message');
}


=head3 test_invalid_city_state_input

Verify invalid input for city/state

Test Steps:

=over

=item 1. Sign in

=item 2. Search for dallas, ca

=back

Expected Result:

Error message is displayed

=cut


sub test_invalid_city_state_input: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	$loginpage->wait_for_text_present("Sign Out", $self->{set_timeout});
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	#goto search page
	$searchresultspage->open_page("/search/results/");
	#do search with zip
	$searchresultspage->get_search_results("dallas, ca", "\$100", "\$1000", "Studio+", "1+");		
			
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	ok($searchresultspage->is_text_present("We didn't recognize \"dallas\" as a city in California. Please check your spelling and try your search again."), 'Verify invalid city-state error message');
}


=head3 test_reverse_min_max

Verify reversing min and max still gives the same results

Test Steps:

=over

=item 1. Sign in

=item 2. Search for property with min amount greater than max

=back

Expected Result:

Error message is displayed

=cut


sub test_reverse_min_max: Test(no_plan)
{

	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->get_search_results("90503", "\$5000+", "\$2000", "Studio+", "1+");		
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify Search results');

	
	ok($searchresultspage->is_text_present("Rentals within 2 miles of 90503"), 'Verify there are valid search results');


}

=head3 test_two_cities

Verify there is only one Burbank in CA

Test Steps:

=over

=item 1. Sign in

=item 2. Search for burbank, ca

=back

Expected Result:

No Error message is displayed

=cut


sub test_two_cities: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	#goto search page
	$searchresultspage->open_page("/search/results/");
	#do search with zip
	$searchresultspage->get_search_results("burbank, ca", "\$100", "\$1000", "Studio+", "1+");		
			
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	ok(!$searchresultspage->is_text_present("There are 2 'burbank's in CA. Please choose one."), 'Verify no two city error message');
}


=head3 test_search_invalid_property_name

Verify getting error page when inputing an invalid property name

Test Steps:

=over

=item 1. Sign in

=item 2. Search for property name xxxxxxxxxx

=back

Expected Result:

Error message is displayed

=cut




sub test_search_invalid_property_name: Test(no_plan)
{
	my($self) = @_;
			
	# login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	# goto search page
	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->open_page("/search/results/");
	
	# search by property name  
	$searchresultspage->search_by_property_name("xxxxxxxxxx");
	
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	ok($searchresultspage->is_text_present("Unfortunately, we did not find any listings that matched every one of your search requirements. We recommend you to broaden your search above. For example, increase your rent range, change the number of bedrooms, or remove some amenities."), 'Verify error message for invalid property name');
}

=head3 test_search_invalid_property_name

Verify getting properties with Cats OK policy on search

Test Steps:

=over

=item 1. Sign in

=item 2. Search using Pet Policy Cats OK

=back

Expected Result:

Property is displayed

=cut

sub test_search_select_pet_policy: Test(no_plan)
{
	my($self) = @_;
		
	# login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	# goto search page
	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->open_page("/search/results/");
	
	# search selecting pet policy
	$searchresultspage->select_pet_policy('Cats OK');
	
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	$searchresultspage->click_on_first_property_more_info_button();
	ok($searchresultspage->is_text_present("Cats"), 'Verify cats is present on the results page');
}

=head3 test_search_neighborhoods

Verify getting properties in a selected neighborhood

Test Steps:

=over

=item 1. Sign in

=item 2. Search selecting neighborhoods

=back

Expected Result:

Property is displayed based on neighborhood search

=cut

sub test_search_select_neighborhoods: Test(no_plan)
{	
	my $midwilshire = "Avalon Wilshire";
	my $midwilshire_neighborhood = "340293516";

	my($self) = @_;
		
	# login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	# goto search page
	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->open_page("/search/results/");
	$searchresultspage->get_search_results("los angeles, ca", "\$100", "\$5000+", "Studio+", "1+");	
	
	# search selecting neighborhoods
	$searchresultspage->select_neighborhoods($midwilshire_neighborhood);
	
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	ok($searchresultspage->is_text_present($midwilshire), 'Verify this mid-wilshire property is on the search results page');
	
	
}

=head3 test_no_city_state_only

Verify getting error page when no city is entered but only state

Test Steps:

=over

=item 1. Sign in

=item 2. Search for ca

=back

Expected Result:

Error message is displayed

=cut


sub test_no_city_state_only: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	#goto search page
	$searchresultspage->open_page("/search/results/");
	#do search with only state
	$searchresultspage->get_search_results("ca", "\$100", "\$1000", "Studio+", "1+");		
			
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	ok($searchresultspage->is_text_present("Please enter both a city and state (Los Angeles, CA), or enter a 5-digit ZIP code (90025)."), 'Verify no city error message');
}

=head3 test_no_city_no_state

Verify getting error page when no city or state 

Test Steps:

=over

=item 1. Sign in

=item 2. Search without inputting city/state

=back

Expected Result:

Error message is displayed

=cut


sub test_no_city_no_state: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	#goto search page
	$searchresultspage->open_page("/search/results/");
	#do search with only state
	$searchresultspage->get_search_results("", "\$100", "\$1000", "Studio+", "1+");		
			
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	ok($searchresultspage->is_text_present("Please enter both a city and state (Los Angeles, CA), or enter a 5-digit ZIP code (90025)."), 'Verify no city error message');
}

=head3 test_invalid_city_valid_state

Verify getting error page when valid state but invalid city

Test Steps:

=over

=item 1. Sign in

=item 2. Search input bad city name but valid state

=back

Expected Result:

Error message is displayed

=cut


sub test_invalid_city_valid_state: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	#goto search page
	$searchresultspage->open_page("/search/results/");
	#do search with invalid city name but a valid state
	$searchresultspage->get_search_results("loui, ca", "\$100", "\$1000", "Studio+", "1+");		
			
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
	ok($searchresultspage->is_text_present("We didn't recognize \"loui\" as a city in California. Please check your spelling and try your search again."), 'Verify invalid city in california error message');
}

=head3 test_city_no_state

Verify getting a close page when valid city but no state

Test Steps:

=over

=item 1. Sign in

=item 2. Search input valid city name - Denver - no state

=back

Expected Result:

search page results for Denver is displayed 

=cut


sub test_valid_city_no_state: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->wait_for_text_present('Sign Out', '30000'), 'Verify User is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	#goto search page
	$searchresultspage->open_page("/search/results/");
	#do search with valid city and no state
	$searchresultspage->get_search_results("denver", "\$100", "\$1000", "Studio+", "1+");		
			
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');
    ok(!($searchresultspage->is_text_present("Please enter both a city and state (Los Angeles, CA), or enter a 5-digit ZIP code (90025).")), 'Verify Denver is a valid city and not getting an error');
}

1;

}