package Test::Class::Selenium::TestCases::Search::TestFeaturedListingsSearch;

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

TestFeaturedListingsSearch - This Test Class verifies search

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_moreinfo_button_on_featuredlisting

Verify able to click on Featured Listing 'More info' button takes you to PDP page from search

Test Steps:

This is assuming that Los Angeles, CA will always have a featured listing on top

Expected Result:

Search results page is displayed, and PDP is viewable

=cut

sub test_moreinfo_button_on_featuredlisting: Test(no_plan)
{
	my($self) = @_;
	
	#login
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{renter_username},$self->{renter_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	$searchresultspage->get_search_results("Los Angeles, CA", "\$100", "\$5000+", "Studio+", "1+");		
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify Search results');

	ok($searchresultspage->is_text_present("Rentals in Los Angeles, CA"), 'Verify that search was performed in Los Angeles, CA');
	
	$searchresultspage->click_on_featured_listing_info_button();

	#Verify Property description page
    my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);

    ok($propertydescriptionpage->is_text_present("Check Availability"), 'Verify PDP view is open');
    ok($propertydescriptionpage->is_text_present("Units May Feature"), 'Verify PDP view is open');
    ok($propertydescriptionpage->is_text_present("Property Details"), 'Verify PDP view is open');
	
	$propertydescriptionpage->pause("10000");
}



1;

}