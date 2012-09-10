package Test::Class::Selenium::TestCases::PLT::TestExistingPLT;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::PLT::TestPLT';

=head1 NAME

TestExistingPLT - This Test Class verifies existing PLT lessors

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_plt_login_from_moving_center

Verify PLT lessor login from /moving-center/ page is logged in to the lessor's main landing page per IB-5282 (i.e. /manage/account/).

Test Steps:

=over

=item 1. Go to /moving-center/

=item 2. Enter existing valid plt username

=item 3. Enter existing valid plt password

=back

Expected Results:

User should be redirected to /manage/account/.

=cut

sub test_plt_login_from_moving_center: Test(no_plan)
{
    my($self) = @_;

    my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
    $loginpage->sign_in($self->{plt_username},$self->{plt_password},"/moving-center");

	# IB-5282 landing page
	$loginpage->wait_for_text_present("Tools", $self->{set_timeout});

    ok($loginpage->is_text_present("Tools"), 'Verify \'Tools\' message');
    ok($loginpage->is_text_present("Listing Dashboard"), 'Verify \'My Listings\' message');
    ok($loginpage->is_text_present("Contact Us"), 'Verify \'Contact Property Support\' message');

}

1;

}
