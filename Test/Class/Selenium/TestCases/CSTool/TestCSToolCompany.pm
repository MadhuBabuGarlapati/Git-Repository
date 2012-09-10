package Test::Class::Selenium::TestCases::CSTool::TestCSToolCompany;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::CSTool::CompanyPage;
use Test::Class::Selenium::PageObjects::CSTool::CreateCompanyPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::CSTool::CSTool';

=head1 NAME

TestCSToolCompany - This Test Class verifies the company tab

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_click_on_create_new_large_property_company

Verify creating new company (QA-1044)

Test Steps:

=over

=item 1. Goto rent.com

=item 2. Sign in as insider

=item 3. Goto company tab

=item 4. Click on create new company -> goes to create company page 1

=item 5. Fill in new company name

=item 6. Click next -> goes to create company page 3

=item 7. Select Billing Type: Credit Card

=item 8. Fill in billing info

=item 9. Click save

=item 10. Verify company name, Verify Address, Verify 'General Info:', Verify 'Billing Information:', Verify 'Lead Responder:'

=back

Expected Result:

CSTool User should be able to sign-in, and after clicking on 'Manage Your Property' user should be able to click on create property

=cut

sub test_click_on_create_new_large_property_company: Test(no_plan)
{
	my($self) = @_;	

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $companyname = $data->create_alpha_string(10);
	my $address = $data->create_address(7);
	my $city = "Santa Monica";
	my $state = "CA";
	my $zip = "90404";
	my $name = "Rey M";
	my $phone = "3108448952";
					
	my $cstoolcompanypage = Test::Class::Selenium::PageObjects::CSTool::CompanyPage->new($self);

    $self->sign_in_as_csuser();
    	
	#click on property tab
	$cstoolcompanypage->click_company_tab();
	#click on create property
	$cstoolcompanypage->click_create_company();

	my $cstoolcreatecompanypage = Test::Class::Selenium::PageObjects::CSTool::CreateCompanyPage->new($self);

	$cstoolcreatecompanypage->fill_company_name($companyname);
	$cstoolcreatecompanypage->click_create();
	
	$cstoolcreatecompanypage->fill_company_billing_information($address, $city, $state, $zip, $name, $phone);
	
	ok($cstoolcompanypage->is_text_present($companyname), "Verify company name:  $companyname.");
	ok($cstoolcompanypage->is_text_present($address), "Verify address:  $address.");
	ok($cstoolcompanypage->is_text_present($city), "Verify city:  $city.");

	ok($cstoolcompanypage->is_text_present('General Info:'), 'Verify -General Info:- is present');
	ok($cstoolcompanypage->is_text_present('Billing Information:'), 'Verify -Billing Information:-  is present');
	ok($cstoolcompanypage->is_text_present('Lead Responder:'), 'Verify -Lead Responder:- is present');

}

1;

}
