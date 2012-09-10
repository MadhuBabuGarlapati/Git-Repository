package Test::Class::Selenium::TestCases::TestCasesWAP::TestLoggedOutPage;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::TestCasesWAP::BaseTest';

=head1 NAME

LoggedOutPagesTest

=head1 SYNOPSIS

This test will test WAP logged out pages

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_renter_alabama_logged_out_page 

This routine will verify the alabama logged out page

Test Steps:

=over

=item 1. Go to alabama logged out page
=item 2. Verify Alabama header
=item 3. Verify clicking on 'What to Expect'
=item 4. Verify clicking on 'What to Explore'
=item 5. Verify Featured Properties in Alabama
=item 6. Verify In Alabama, Rent.com has apartments in:

=back

=cut

sub test_renter_alabama_logged_out_page: Test(no_plan)
{
	my($self) = @_;
	
	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/alabama");

	ok($loggedoutpage->is_text_present("The state seal of Alabama features a no-frills map with a dozen or so rivers as its only landmarks."), 'Verify contents of Alabama');
	
	$loggedoutpage->click_what_to_expect();
	ok($loggedoutpage->is_text_present("Residents of Alabama love living here and are proud of their communities."), 'Verify contents of \'what to expect\'');
	
	$loggedoutpage->click_what_to_explore();
	ok($loggedoutpage->is_text_present("Apartments abound in all four of Alabama's major regions: the North Region, Central Region, Southeast Region and Gulf Coast."), 'Verify contents of \'What to explore\'');
	
	$loggedoutpage->click_featured_properties();
	##TODO: ok($loggedoutpage->is_text_present(""), 'Verify contents of \'featured properties\'');
	
	$loggedoutpage->click_in_state();
	ok($loggedoutpage->is_element_present("link=Anniston"), 'Verify contents of \'In Alabama\'');

}


=head3 test_renter_california_logged_out_page 

This routine will verify the california logged out page

Test Steps:

=over

=item 1. Go to california logged out page
=item 2. Verify California header
=item 3. Verify clicking on 'What to Expect'
=item 4. Verify clicking on 'What to Explore'
=item 5. Verify Featured Properties in California
=item 6.  Verify In Alabama, Rent.com has apartments in:

=back

=cut

sub test_renter_california_logged_out_page: Test(no_plan)
{
	my($self) = @_;
	
	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/california");

	ok($loggedoutpage->is_text_present("Whether you're moving to California for a new job, a new tan or a new way of life, you're bound to find great apartments for rent and a Cali lifestyle that makes you want to shout the state motto"), 'Verify contents of California');
	
	$loggedoutpage->click_what_to_expect();
	ok($loggedoutpage->is_text_present("California is a place of stark contrasts: The landscape runs the gamut from desert to ocean to mountain, green valleys to skyscrapers, sand to redwood forests, vineyards to office parks and everything in between."), 'Verify contents of \'what to expect\'');
	
	$loggedoutpage->click_what_to_explore();
	ok($loggedoutpage->is_text_present("While California offers many fine places to search for apartments, San Francisco and Los Angeles are two of the most popular cities to move to."), 'Verify contents of \'What to explore\'');
		
	$loggedoutpage->click_featured_properties();
	#TODO: ok($loggedoutpage->is_text_present(""), 'Verify contents of \'featured properties\'');  
	
	$loggedoutpage->click_in_state();
	ok($loggedoutpage->is_element_present("link=Torrance"), 'Verify contents of \'In California\'');

}

=head3 test_renter_phoenix_logged_out_page 

This routine will verify the california logged out page

Test Steps:

=over

=item 1. Go to phoenix logged out page
=item 2. Verify phoenix header
=item 2. Verify phoenix summary
=item 3. Verify clicking on 'Cost of Living'
=item 4. Verify clicking on 'Quality of life'
=item 4. Verify clicking on 'Where the jobs are'
=item 5. Verify Featured Properties in California
=item 6. Verify In phoenix, Rent.com has apartments in:

=back

=cut

sub test_renter_phoenix_logged_out_page: Test(no_plan)
{
	my($self) = @_;
	
	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/arizona/phoenix-scottsdale-and-vicinity/phoenix.html");

	ok($loggedoutpage->is_text_present("Your Guide to Apartments for Rent in Phoenix, AZ"), 'Verify contents of Phoenix header');
	ok($loggedoutpage->is_text_present("Phoenix is the United States' fifth-largest city with a population of nearly 1.3 million (the greater Phoenix area has a population of 3.2 million and covers 2,000 square miles)."), 'Verify contents of Phoenix summary');
	
	$loggedoutpage->click_cost_of_living();
	ok($loggedoutpage->is_text_present("Phoenix's favorable financial situation benefits everything from apartment rentals to utilities to taxes."), 'Verify contents of \'Cost of Living\'');
	
	$loggedoutpage->click_quality_of_life();
	ok($loggedoutpage->is_text_present("With 325 sunny days per year, the weather is hot but gorgeous, a perfect environment for enjoying the natural beauty of the city and its surrounding area."), 'Verify contents of \'Quality of life\'');

	$loggedoutpage->click_where_the_jobs_are();
	ok($loggedoutpage->is_text_present("One of Phoenix's newest major industries is high-tech manufacturing, including the production of semiconductors, aerospace products and electronic equipment."), 'Verify contents of \'Where the jobs are\'');
	
	$loggedoutpage->click_featured_properties();
	#TODO: ok($loggedoutpage->is_text_present(""), 'Verify contents of \'featured properties\'');  

	#$loggedoutpage->click_rent_dot_com_has_aparments();
	#ok($loggedoutpage->is_element_present("link=North Central Phoenix"), 'Verify contents of \'featured properties\'');  

	$loggedoutpage->click_search_nearby_zips();
	ok($loggedoutpage->is_element_present("link=85028"), 'Verify contents of \'search nearby zips\'');

}

=head3 test_renter_jacksonville_logged_out_page 

This routine will verify the jacksonville logged out page

Test Steps:

=over

=item 1. Go to jacksonville logged out page
=item 2. Verify jacksonville header
=item 2. Verify jacksonville summary
=item 3. Verify clicking on 'Cost of Living'
=item 4. Verify clicking on 'Quality of life'
=item 4. Verify clicking on 'Where the jobs are'
=item 5. Verify Featured Properties in California
=item 6. Verify In jacksonville, Rent.com has apartments in:

=back

=cut

sub test_renter_jacksonville_logged_out_page: Test(no_plan)
{
	my($self) = @_;
	
	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/florida/jacksonville-and-vicinity/jacksonville.html");

	ok($loggedoutpage->is_text_present("Your Guide to Apartments for Rent in Jacksonville, FL"), 'Verify contents of Jacksonville header');
	ok($loggedoutpage->is_text_present("Jacksonville (known as \"Jax\" to locals) is the major city in northern Florida, thanks primarily to its busy seaport and extensive financial and insurance industries."), 'Verify contents of Jacksonville summary');
	
	$loggedoutpage->click_cost_of_living();
	ok($loggedoutpage->is_text_present("One of the best perks of Jacksonville is its low cost of living."), 'Verify contents of \'Cost of Living\'');
	
	$loggedoutpage->click_quality_of_life();
	ok($loggedoutpage->is_text_present("Due to Jacksonville's location at the north end of the state, its residents enjoy something more southern Floridians don't: an actual change of seasons."), 'Verify contents of \'Quality of life\'');

	$loggedoutpage->click_where_the_jobs_are();
	ok($loggedoutpage->is_text_present("Jacksonville has a relatively healthy job market, thanks in part to the broad diversification of its industries."), 'Verify contents of \'Where the jobs are\'');
	
	$loggedoutpage->click_movers_and_quotes();
	#TODO: ok($loggedoutpage->is_text_present(""), 'Verify contents of \'Movers and Quotes\'');  	
	
	$loggedoutpage->click_featured_properties();
	#TODO: ok($loggedoutpage->is_text_present(""), 'Verify contents of \'featured properties\'');  

	#$loggedoutpage->click_rent_dot_com_has_aparments();
	#ok($loggedoutpage->is_element_present("link=Northside"), 'Verify contents of \'featured properties\'');  

	$loggedoutpage->click_search_nearby_zips();
	ok($loggedoutpage->is_element_present("link=32228"), 'Verify contents of \'search nearby zips\'');

}

=head3 test_invalid_text_on_city_page

This routine will verify !#####! is not present on page

Test Steps:

=over

=item 1. Go to Birmingham
=item 2. Verify the string !#####! is not on the page

=back

=cut

sub test_invalid_text_not_on_city_page: Test(no_plan)
{
	my($self) = @_;
	
	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/alabama/birmingham-and-vicinity/birmingham.html");

	ok(!($loggedoutpage->is_text_present("!#####!")), 'Verify /"!#####!/" is not present');

}

=head3 test_nashville_is_not_in_arizona

This routine will verify nashville is not present on page

Test Steps:

=over

=item 1. Go to Birmingham
=item 2. Verify the string 'nashville' is not on the page

=back

=cut

sub test_nashville_is_not_in_arizona: Test(no_plan)
{
	my($self) = @_;
	
	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/alabama/birmingham-and-vicinity/birmingham.html");

	ok(!($loggedoutpage->is_text_present("Nashville")), 'Verify /"Nashville/" is not present');

}

=head3 test_click_on_gardendale_in_alabama

This routine will verify clicking on city gardendale in state of alabama

Test Steps:

=item 1.  Goto Alabama logged out
=item 2.  Click on Gardendale
=item 3.  Verify Gardendale, AL is pre-populated in field
=item 4.  Verify that Gardendale is an empty submarket: 
The following links should not be present
  Cost of Living & Apartment Prices
  Quality of Life
  Where the Jobs Are
  Find Movers Near Gardendale, Al and Get Moving Quotes
  Featured Properties in Gardendale, Al
  Rent.com has apartments in in Gardendale, Al
  Search Nearby Zips

=over

=back

=cut

sub test_click_on_gardendale_in_alabama: Test(no_plan)
{
	my($self) = @_;
	
	my $glendale_url = $self->{test_url}."/wap/registration/?combined_location_field=Gardendale,%20AL";
	
	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/alabama");

	$loggedoutpage->click_in_state();
	
	$loggedoutpage->click_city_link("Gardendale");

	ok($loggedoutpage->get_location() eq $glendale_url, 'Verify url /"Gardendale, Al/" is present');
	
	ok(!($loggedoutpage->is_element_present($loggedoutpage->BUTTON_COSTOFLIVING)), 'Verify url /"Cost of Living & Apartment Prices/" is not present');
	ok(!($loggedoutpage->is_element_present($loggedoutpage->BUTTON_QUALITYOFLIFE)), 'Verify url /"Quality of Life/" is not present');
	ok(!($loggedoutpage->is_element_present($loggedoutpage->BUTTON_WHERETHEJOBSARE)), 'Verify url /"Where the Jobs Are/" is not present');
	ok(!($loggedoutpage->is_element_present($loggedoutpage->BUTTON_MOVERSANDQUOTES)), 'Verify url /"Find Movers Near Gardendale, Al and Get Moving Quotes/" is not present');
	ok(!($loggedoutpage->is_element_present($loggedoutpage->BUTTON_FEATUREDPROPERTIES)), 'Verify url /"Featured Properties in Gardendale, Al/" is not present');
	ok(!($loggedoutpage->is_element_present($loggedoutpage->BUTTON_RENTDOTCOMHASAPARTMENTS)), 'Verify url /"Rent.com has apartments in in Gardendale, Al/" is not present');
	ok(!($loggedoutpage->is_element_present($loggedoutpage->BUTTON_SEARCHNEARBYZIPS)), 'Verify url /"Search Nearby Zips/" is not present');

}

=head3 test_what_to_expore_drop_down_not_in_colorado

This routine will verify that the 'what to explore' drop down is not in colorado

Test Steps:

=item 1.  Goto Colorado logged out
=item 2.  Verify that 'What to Explore' link is not present

=over

=back

=cut

sub test_what_to_expore_drop_down_not_in_colorado: Test(no_plan)
{
	my($self) = @_;
	
	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/colorado");

	ok(!($loggedoutpage->is_element_present($loggedoutpage->BUTTON_WHATTOEXPLORE)), 'Verify url /"What to Explore/" is not present');

}

=head3 test_rent_apartments_in_colorado_springs

This routine will verify that 'Rent.com has apartments in Colorado Springs, CO' is present in 
Colorado Springs.

Test Steps:

=item 1.  Goto Colorado Springs logged out
=item 2.  Verify that 'Rent.com has apartments in Colorado Springs, CO' link is present

=over

=back

=cut

sub test_rent_apartments_in_colorado_springs: Test(no_plan)
{
	my($self) = @_;

	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/colorado/colorado-springs-and-vicinity/colorado-springs");

	ok(($loggedoutpage->is_text_present('Rent.com has apartments in Colorado Springs, CO')), 'Verify url /"Rent.com has apartments in Colorado Springs, CO/" is present');

}

=head3 test_portland_or_not_in_portland_me

This routine will verify that 'Portland, Oregon' is not present in Portland, Main

Test Steps:

=item 1.  Goto Portland, ME logged out
=item 2.  Verify that 'Portland, Oregon' is not present

=over

=back

=cut

sub test_portland_or_not_in_portland_me: Test(no_plan)
{
	my($self) = @_;

	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/maine/portland-and-vicinity/portland");

	ok(!($loggedoutpage->is_text_present('Portland, Oregon')), 'Verify url /"Portland, Oregon/" is not present');

}

=head3 test_95115_zipcode

This routine will verify that user can access zip code page clicking through CA->San Jose->95115

Test Steps:

=item 1.  Go to California logged out page
=item 2.  Click on San Jose
=item 3.  Click on 95115
=item 4.  Verify on 95115 logged out page

=over

=back

=cut

sub test_95115_zipcode: Test(no_plan)
{
	my($self) = @_;


	my $loggedoutpage = Test::Class::Selenium::PageObjects::PageObjectsWAP::LoggedOutPage->new($self);

	$loggedoutpage->open_page("/wap/california/");

	$loggedoutpage->click_in_state();
	$loggedoutpage->click_city_link("San Jose");
	$loggedoutpage->click_search_nearby_zips();
	$loggedoutpage->click_zip_link("95115");	

	ok($loggedoutpage->is_text_present('Your Guide to Apartments for Rent in or near 95115 San Jose, CA'), 'Verify we are on 95115 logged out page');

}

1;

}
