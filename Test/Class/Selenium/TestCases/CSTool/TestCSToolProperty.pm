package Test::Class::Selenium::TestCases::CSTool::TestCSToolProperty;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::CSTool::PropertyPage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::CSTool::CSTool';

=head1 NAME

TestCSToolProperty - This Test Class verifies the property tab

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_click_on_create_new_property_link

Verify clicking on the 'create new property' tab

Test Steps:

=over

=item 1. login as cs-tool user

=item 2. click on manage property

=item 3. click on create property

=back

Expected Result:

CSTool User should be able to sign-in, and after clicking on 'Manage Your Property' user should be able to click on create property

=cut

sub test_click_on_create_new_property_link: Test(no_plan)
{
	my($self) = @_;	
	
	my $cstoolpropertypage = Test::Class::Selenium::PageObjects::CSTool::PropertyPage->new($self);

    $self->sign_in_as_csuser();
    	
	#click on property tab
	$cstoolpropertypage->click_property_tab();
	#click on create property
	$cstoolpropertypage->click_create_property();
	
	ok($cstoolpropertypage->is_text_present("New Property"), 'Verify User \'New Property\' text present');
	ok($cstoolpropertypage->is_text_present("Property Info"), 'Verify User \'Property Info\' text present');
	ok($cstoolpropertypage->is_text_present("Property Name"), 'Verify User \'Property Name\' text present');
}

1;

}
