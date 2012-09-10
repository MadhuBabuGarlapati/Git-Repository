package Test::Class::Selenium::TestCases::Renter::TestNewReturningRenter;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::SearchResultsPage;
use Test::Class::Selenium::DataAccessObjects::PickDao;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::Renter::Renter';

=head1 NAME

TestNewReturningRenter - This Test Class verifies existing renters

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}


=head3 test_login_defaults_to_my_rent

Verify Renter logged defaults to /account/myrent/view/ if they haven't reported a lease.

Test Steps:

=over

=item 1. Sign up with new account

=item 2. Sign out

=item 3. Login

=back

Expected Result:

User should be redirected to MyRent Tab

Verify url: /account/myrent/view
Verify 'All Properties You've Viewed'
Verify 'Viewed Properties'

=cut

sub test_login_defaults_to_my_rent: Test(no_plan)
{
	
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $password = 'qatest11';
	
	# Set homepage pick
	$self->set_homepage_pick_A();
	
	#register
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$100", "\$5000+", "1+", $email);		

	#set pick A for optional password
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	$pickdao = $pickdao->password_set_pick_A($email, $password);

	#signout
	$landingpage->sign_out();
	$landingpage->clear_cookies();

	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	#commented out due to optional password	
	#$loginpage->sign_in($email,$password);		
	$loginpage->sign_in($email);	

	#print $loginpage->get_page_text();

	ok($loginpage->is_text_present("All Properties You've Viewed"), 'Verify \' All Properties You\'ve Viewed \' message');
	ok($loginpage->is_text_present("Viewed Properties"), 'Verify \'Viewed Properties\' message');
	ok($loginpage->is_text_present("Sign Out"), 'Verify signed in');

}

=head3 test_login_from_moving_center

Verify Renter logged in from moving-center page is logged in to the users main landing page per IB-5282 (i.e. /account/myrent/view/)

Test Steps:

=over

=item 1. Sign up with new account

=item 2. Sign out

=item 3. Login from moving-center page

=back

Expected Result:

User should be redirected to My Rent.com tab

Verify 'Recent Search Locations'
Verify 'You might also like...'

=cut
sub test_login_from_moving_center: Test(no_plan)
{
	
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $password = 'qatest11';
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	
	# Set homepage pick
	$self->set_homepage_pick_A();
	
	#register
	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$100", "\$5000+", "1+", $email);		

	#set pick A for optional password
	$pickdao = $pickdao->password_set_pick_A($email, $password);

	ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify you are brought to Search page after signup');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
	$searchresultspage->submit_password($password);
	$searchresultspage->sign_out();
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	
	$loginpage->sign_in($email, $password, "/moving-center");		
	
	ok($loginpage->is_text_present("All Properties You've Viewed"), 'Verify \' All Properties You\'ve Viewed \' message');
	ok($loginpage->is_text_present("Recent Search Locations"), 'Verify \'You might also like...\' message');
	ok($loginpage->is_text_present("Sign Out"), 'Verify signed in');

}

=head3 test_login_100_reward_card

Verify Renter logged in from reward card page is logged in to reward card page

Test Steps:

=over

=item 1. Sign up with new account

=item 2. Sign out

=item 3. Login from reward card page

=back

Expected Result:

User should be redirected to reward card tab

Verify 'Leased at a property featuring our $100 Reward Card?'
Verify 'Know the name of the property?'

=cut

#TODO Set pick for this test case
sub test_login_100_reward_card#: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	# Set homepage pick
	$self->set_homepage_pick_A();
	
	#register
	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$100", "\$5000+", "1+", $email);		

	#signout
	$landingpage->sign_out();
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	
	$loginpage->open_page("/service/reward");
	
	$loginpage->sign_in($email, "", "/service/reward");		
	
	ok($loginpage->is_text_present("We've given \$100 to over 1.5 MILLION people."), 'Verify \'We\'ve given $100 to over 1.5 MILLION people.\' message');
	ok($loginpage->is_text_present("Ready to REPORT? Select your apartment below."), 'Verify \'Ready to REPORT? Select your apartment below.\' message');
	ok($loginpage->is_text_present("Sign Out"), 'Verify signed in');

}

=head3 test_login_password_specialchars

Verify login with a user that has special characters in their password.

Test Steps:

=over

=item 1. Create a new account with '!@#$%^&*' as the password

=item 2. Logout, then login

=back

Expected Result:

User should be able to login

=cut

sub test_login_password_specialchars: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $password = "!@#$%^&*";

	# Set homepage pick
	$self->set_homepage_pick_A();

	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	#register
	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$100", "\$5000+", "1+", $email);		

	#set pick A for optional password
	$pickdao = $pickdao->password_set_pick_A($email, $password);

	ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify you are brought to Search page after signup');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
	$searchresultspage->submit_password($password);
	$searchresultspage->sign_out();
	
	$landingpage->sign_in($email, $password);		
	ok($landingpage->is_text_present("Sign Out"), 'Verify User is logged in');
	
}

1;

}
