package Test::Class::Selenium::TestCases::Renter::TestExistingRenter;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::SearchResultsPage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::Renter::Renter';

=head1 NAME

TestExistingRenter - This Test Class verifies existing renters

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_login

Verify login as existing user

Test Steps:

=over

=item 1. Enter existing valid username

=item 2. Enter existing valid password	

=back

Expected Result:

User should be successfully logged in

=cut

sub test_login: Test(no_plan)
{
	my($self) = @_;	
	
	my $username = $self->{renter_username};
	my $password = $self->{renter_password};
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username, $password);	
	
	ok($loginpage->wait_for_text_present('Sign Out', '30000'), 'Verify User is logged in');
}

=head3 test_login_empty_username

Verify login with emtpy username

Test Steps:

=over

=item 1. Do not enter username

=item 2. Enter existing valid password	

=back

Expected Result:

User should not be logged in, error msg should display: Missing information. Please fill out all highlighted fields below.

=cut

sub test_login_empty_username: Test(no_plan)
{
	my($self) = @_;	

	my $username = "";
	my $password = $self->{renter_password};
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username,$password);		
	ok($loginpage->is_text_present("Please enter your email address"), 'Verify error msg');
	#ok($loginpage->is_page_title_present("Rent.com: Login"), 'Verify user has not logged in');

}

=head3 test_login_empty_password

Verify login with empty password

Test Steps:

=over

=item 1. Enter existing valid username 

=item 2. Do not enter password

=back

Expected Result:

The email address and/or password entered did not match an account in our file. Please try again.

=cut

sub test_login_empty_password: Test(no_plan)
{
	my($self) = @_;	

	my $username = $self->{renter_username};
	my $password = "";
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username, $password);		
	ok($loginpage->is_text_present("Sign In"), 'Verify Sign In is still present');	
	ok($loginpage->is_text_present("Please enter your password."), 'Verify error msg');
}

=head3 test_logout

Verify logout

Test Steps:

=over

=item 1. Login

=item 2. Logout

=back

Expected Result:

user logs out.
=cut

sub test_logout: Test(no_plan)
{
	my($self) = @_;	

	my $username = $self->{renter_username};
	my $password = $self->{renter_password};
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username, $password);		
	ok($loginpage->is_text_present("Sign Out"), 'Verify user is logged in');
	$loginpage->sign_out();
	ok($loginpage->is_text_present("Sign In"), 'Verify user has logged out');
}

=head3 test_login_incorrect_password

Verify login with incorrect password

Test Steps:

=over

=item 1. Enter existing valid username 

=item 2. Enter incorrect password

=back

Expected Result:

The email address and/or password entered did not match an account in our file. Please try again.

=cut

sub test_login_incorrect_password: Test(no_plan)
{
	
	my($self) = @_;	
	
	my $username = $self->{renter_username};
	my $password = 'incorrect';
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username, $password);		
	ok($loginpage->is_text_present("The password you entered is incorrect. Please try again."), 'Verify error msg');
	ok($loginpage->is_text_present("Sign In"), 'Verify not signed in');
}

=head3 test_renter_idle_30_min

Verify user is still signed in after being idle for 30 min.  We actually test for 3 min.
Since in the QA environment we lower the session timeout time to 3 min, so we can 
save time on running the test.

Test Step:

=over

=item 1. Login with as renter

=item 2. Pause for 30 min.

=item 3. Click on search tab

=back

Expected Result:

User is still signed in.

=cut

sub test_renter_idle_30_min: Test(no_plan)
{
	my($self) = @_;	

	my $username = $self->{renter_username};
	my $password = $self->{renter_password};

	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username, $password);		
	$loginpage->pause("180000");  #3 min instead of 30 min, because QA server is set to 2 min timeout.
	$loginpage->click_search_properties();
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');
}


=head3 test_login_verify_comscore_tag

Verify presence of Comscore tags on Login page

Test Steps:

=over

=item 1. Enter existing valid username

=item 2. Enter invalid password to remain on login page

=item 3. Get HTML source and verify presence of Comscore tag on page

=back

Expected Result:

User should be successfully logged in

=cut

sub test_login_page_comscore_tag: Test(no_plan)
{
	my($self) = @_;
	my $comscore_tag1 = '_comscore.push\({ c1: "2", c2: "6035620" }\)';
	my $comscore_noscript_tag = '<img src="http:\/\/b.scorecardresearch.com\/p\?c1=2&c2=6035620&c3=&c4=&c5=&c6=&c15=&cv=2.0&cj=1" \/>';	
	
	my $username = $self->{renter_username};
	my $password = "";
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username,$password);
	ok($loginpage->is_text_present("Please enter your password."), 'Verify user has not logged in');	
	
	my $htmlsourcetext = $loginpage->get_html_source();
	# use for debugging purposes only!
	# print "HTML Source Test = ".$htmlsourcetext."\n";
	ok ( $htmlsourcetext =~ m/$comscore_tag1/i, 'Verify presence of Comscore async tag declaration no. 1' );
	ok ( $htmlsourcetext =~ m/$comscore_noscript_tag/i, 'Verify presence of Comscore async noscript tag' );
}


1;

}
