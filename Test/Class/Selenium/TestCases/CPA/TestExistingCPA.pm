package Test::Class::Selenium::TestCases::CPA::TestExistingCPA;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

TestExistingRenter - This Test Class verifies existing cpa renters

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_cpa_login

Verify login as existing cpa user

Test Steps:

=over

=item 1. Enter existing valid cpa username

=item 2. Enter existing valid password	

=back

Expected Result:

User should be successfully logged in

=cut

sub test_cpa_login: Test(no_plan)
{
	my($self) = @_;	
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{cpa_username},$self->{cpa_password});

	$loginpage->wait_for_text_present("Sign Out", $self->{set_timeout});
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');
}

=head3 test_cpa_login_from_moving_center

Verify CPA lessor login from /moving-center/ page is logged in to the lessor's main landing page per IB-5282 (i.e. /manage/account/).

Test Steps:

=over

=item 1. Go to /moving-center/

=item 2. Enter existing valid cpa username

=item 3. Enter existing valid cpa password

=back

Expected Result:

User should be redirected to /manage/account/. 

=cut

sub test_cpa_login_from_moving_center: Test(no_plan)
{
    my($self) = @_;

    my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
    $loginpage->sign_in($self->{cpa_username},$self->{cpa_password},"/moving-center");

# IB-5282 landing page
	$loginpage->wait_for_text_present("My Listings", $self->{set_timeout});

    ok($loginpage->is_text_present("My Listings"), 'Verify \'My Listings\' message');
    ok($loginpage->is_text_present("Listing Dashboard"), 'Verify \'Listing Dashboard\' message');

}

=head3 test_cpa_login_upgrade_interstitial: Test(no_plan)

Verify CPA lessor login has the 'Maximize Your Exposure with Upgrades' popup displayed (IB-5073).

Test Steps:

=over

=item 1. Enter existing valid cpa username

=item 2. Enter existing valid cpa password

=back

Expected Result:

Display 'Maximize Your Exposure with Upgrades' popup (IB-5073).

=cut

sub test_cpa_login_upgrade_interstitial: Test(no_plan)
{

    my($self) = @_;

    my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
    $loginpage->sign_in($self->{cpa_username},$self->{cpa_password});

	# $IB-5073 upgrade interstitial
	$loginpage->wait_for_text_present("Maximize Your Exposure with Upgrades", $self->{set_timeout});

    ok($loginpage->is_text_present("Maximize Your Exposure with Upgrades"), 'Verify \'Maximize Your Exposure with Upgrades\' message');
    ok($loginpage->is_text_present("show me this message again"), 'Verify \'show me this message again\' message');

}

1;

}
