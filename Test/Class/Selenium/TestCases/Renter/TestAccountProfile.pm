package Test::Class::Selenium::TestCases::Renter::TestAccountProfile;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::AccountProfilePage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::Renter::Renter';

=head1 NAME

TestAccountProfile - This Test Class verifies renter's account profile page

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_edit_to_800_num

Verify login as existing user

Test Steps:

=over

=item 1. Enter existing valid username

=item 2. Enter existing valid password	

=item 3. Go to Account profile page

=item 4.  Change number to (800) 973-1911

=back

Expected Result:

User should not get an "Invalid phone number." message
=cut

sub test_edit_to_800_num: Test(no_plan)
{
	my($self) = @_;	
	
	my $fname = $self->{firstname};
	my $lname = $self->{lastname};
	my $username = $self->{renter_username};
	my $phonenum = "(800) 973-1911";
	my $password = $self->{renter_password};
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username,$password);		
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');

	my $accountprofilepage = Test::Class::Selenium::PageObjects::AccountProfilePage->new($self);	
	$accountprofilepage->go_to_account_profile();
	$accountprofilepage->update_contact_info($fname, $lname, $username, $phonenum, $password);

	ok(!$loginpage->is_text_present("Invalid phone number"), 'Verify msg \'Invalid phone number\' not present');	
	
}

#The following test case is currently failing for users with an undeliverable email address.

=head3 test_edit_to_855_num

Verify login as existing user

Test Steps:

=over

=item 1. Enter existing valid username

=item 2. Enter existing valid password	

=item 3. Go to Account profile page

=item 4.  Change number to (855) 973-1911

=back

Expected Result:

User should get an "Invalid phone number." message

=cut

sub test_edit_to_855_num: Test(no_plan)
{
	my($self) = @_;	

	my $fname = $self->{firstname};
	my $lname = $self->{lastname};
	my $username = $self->{renter_username};	
	my $phonenum = "(855) 973-1911";
	my $password = $self->{renter_password};
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username,$password);		
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');

	my $accountprofilepage = Test::Class::Selenium::PageObjects::AccountProfilePage->new($self);	
	$accountprofilepage->go_to_account_profile();		
	$accountprofilepage->update_contact_info($fname, $lname, $username, $phonenum, $password);

	ok($loginpage->is_text_present("Invalid phone number"), 'Verify msg \'Invalid phone number\' is present');	

}

1;

}