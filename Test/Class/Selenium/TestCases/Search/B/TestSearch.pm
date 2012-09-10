package Test::Class::Selenium::TestCases::Search::B::TestSearch;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::Search::B::SearchResultsPage;
use Test::Class::Selenium::PageObjects::PropertyDescriptionPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use Test::Class::Selenium::DataAccessObjects::PickDao;
use base 'Test::Class::Selenium::TestCases::BaseTest';



=head1 NAME

TestSearch - This Test Class verifies search for Pick B

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_basic_search

Verify basic search functionality for Pick B

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
	ok($loginpage->is_text_present("Sign Out"), 'Verify user '.$self->{renter_username}.' is logged in');

	my $searchresultspage = Test::Class::Selenium::PageObjects::Search::B::SearchResultsPage->new($self);
	$searchresultspage->get_search_results("90503", "100", "5000", "1+", "1+");		
	ok($searchresultspage->is_page_title_present("Rent.com: Search Results"), 'Verify Search results');

	#Check as per QA-82 (Automate Search Test Case: Search by landmark and verify distance.)
	ok($searchresultspage->is_text_present("Rentals within 2 miles of 90503"), 'Verify that there are properties within 2 miles of search:');

}


1;

}