package Test::Class::Selenium::TestCases::LeaseReport::TestLeaseReportAddressNegativeTC;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::SearchResultsPage;
use Test::Class::Selenium::PageObjects::LeaseReportRefactor::LeaseReportPage;
use Test::Class::Selenium::PageObjects::LeaseAddressPage;
use Test::Class::Selenium::PageObjects::RewardStatusPage;
use Test::Class::Selenium::PageObjects::PropertyDescriptionPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Class::Selenium::DataAccessObjects::LeaseReportDao;
use Test::Most 'no_plan';
use base 'Test::Class::Selenium::TestCases::BaseTest';
use DateTime;
use Data::RandomPerson::Names::Last;
use Data::RandomPerson::Names::Female;


=head1 NAME

TestLeaseReport

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=back

=head2 

Verify Lease Report functionality

Test Steps:

Expected Result:


=cut

# Test expected JS behavior on address field on page load or focus/un-focus
	
# Test error handling - move-in address
	
# Test error handling - move-in apartment/unit number
	
# Test error handling - reward card street address
	
# Test error handling - reward card apartment/unit number
	
# Test error handling - reward card city
	
# Test error handling - reward card zip code
	
# Test error handling - reward card phone number

1;

}
