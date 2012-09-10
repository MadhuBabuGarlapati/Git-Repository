package Test::Class::Selenium::TestCases::CSTool::TestCSToolPropertySearch;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::CSTool::PropertyPage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::CSTool::CSTool';

=head1 NAME

TestCSToolPropertySearch - This Test Class verifies search property tab

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_search_for_property_by_property_id

Verify searching for a property by their id

Test Steps:

=over

=item 1. login as cs-tool user

=item 2. click on manage property

=item 3. click on property tab

=item 4. search for property by id

=back

Expected Result:

CSTool User should be able to sign-in, and after clicking on 'Manage Your Property' user gets defaulted to Property tab page

=cut

sub test_search_for_property_by_property_id: Test(no_plan)
{
	my($self) = @_;	
	my $property_id = "427068";
	my $cstoolpropertypage = Test::Class::Selenium::PageObjects::CSTool::PropertyPage->new($self);

    $self->sign_in_as_csuser();
    	
	#click on property tab
	$cstoolpropertypage->click_property_tab();
	#type property id
	$cstoolpropertypage->type_property_id($property_id);	
	#click on view properties
	$cstoolpropertypage->click_view_properties();
	
	ok($cstoolpropertypage->is_text_present("Information Overview"), 'Verify User is brought to view information page');
	ok($cstoolpropertypage->is_text_present("($property_id)"), 'Verify proper property id is displayed');

}

sub test_search_for_invalid_property_999999999999999: Test(no_plan)
{
	my($self) = @_;	
	my $property_id = "999999999999999";
	my $cstoolpropertypage = Test::Class::Selenium::PageObjects::CSTool::PropertyPage->new($self);

    $self->sign_in_as_csuser();
    	
	#click on property tab
	$cstoolpropertypage->click_property_tab();
	#type property id
	$cstoolpropertypage->type_property_id($property_id);	
	#click on view properties
	$cstoolpropertypage->click_view_properties();
	
	ok($cstoolpropertypage->is_text_present("Please enter a valid property ID"), 'Verify error msg displayed');

}

sub test_search_for_invalid_property_specialchars: Test(no_plan)
{
	my($self) = @_;	
	my $property_id = "!@#";
	my $cstoolpropertypage = Test::Class::Selenium::PageObjects::CSTool::PropertyPage->new($self);

    $self->sign_in_as_csuser();
    	
	#click on property tab
	$cstoolpropertypage->click_property_tab();
	#type property id
	$cstoolpropertypage->type_property_id($property_id);	
	#click on view properties
	$cstoolpropertypage->click_view_properties();
	
	ok($cstoolpropertypage->is_text_present("Please enter an integer value"), 'Verify invalid property error msg displayed');

}

1;

}