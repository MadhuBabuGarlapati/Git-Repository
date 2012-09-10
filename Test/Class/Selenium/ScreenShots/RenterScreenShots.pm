package Test::Class::Selenium::ScreenShots::RenterScreenShots;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::SearchResultsPage;
use Test::Class::Selenium::PageObjects::PropertyDescriptionPage;
use Test::Class::Selenium::PageObjects::ForgotPasswordPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

RenterScreenShots - Take screen shots related to renter

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 renter

Steps:

=over

=item  1. Sign-up as a new user

=item  2. Perform a search

=item  3. Select a Property

=item  3. Submit a Hotlead

=item  4. SignOut

=item  5. Do ForgotPassword

=back

=cut

sub renter:Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();

	my $city = "Santa Monica";
	my $state = "CA";
	my $zip = "90404";
	my $minprice = "\$100";
	my $maxprice = "\$5000+";
	my $bedrooms = "2+";
	my $baths = "1+";
	my $fname = $data->create_alpha_string(10);
	my $lname = $data->create_alpha_string(10);
	my $phone = "(310) 844-8952";
	my $date = "12/12/2020";

	#register
 	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	$landingpage->screen_capture("Renter", "LandingPage");
    $landingpage->enter_city($city);
    $landingpage->select_state($state);
    $landingpage->select_min_price($minprice);
    $landingpage->select_max_price($maxprice);
    $landingpage->select_bedrooms($bedrooms);
    $landingpage->select_email_address($email);
	$landingpage->click_view_listings();
	$landingpage->wait_for_page_to_load("120000");   
	#$landingpage->pause("3000");
	$landingpage->screen_capture("Renter", "ListingsPage");	
	$landingpage->sign_out();
	
	#login
	$landingpage->sign_in($self->{renter_username},$self->{renter_password});
	
	#search
	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
    $searchresultspage->enter_city_state_zip($zip);
    $searchresultspage->select_min_price($minprice);
    $searchresultspage->select_max_price($maxprice);
    $searchresultspage->select_bedrooms($bedrooms);
    $searchresultspage->select_baths($baths);
	$searchresultspage->click_search();
	$searchresultspage->wait_for_page_to_load($self->{set_timeout});   
	$searchresultspage->click_on_first_property_more_info_button();
	$searchresultspage->screen_capture("Renter_Search", "EnterPasswordPage");	
	$searchresultspage->submit_password();

	#hotlead
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	$propertydescriptionpage->click_check_availability();
	$propertydescriptionpage->screen_capture("Renter_HotLead", "PopUp");	
	$propertydescriptionpage->fill_lead_form_box_info($fname, $lname, $phone, $date);	
	$propertydescriptionpage->click_send();
	$propertydescriptionpage->screen_capture("Renter_HotLead", "Sent");	
	$propertydescriptionpage->close_form_box();	

	#signout
	$propertydescriptionpage->sign_out();
	$propertydescriptionpage->screen_capture("Renter_SignOut", "SignedOut");	

}

=head3 renter_forgotpassword

Steps:

=over

=item  1. Do ForgotPassword

=back

=cut

sub renter_forgotpassword:Test(no_plan)
{
	my($self) = @_;

	#forgot password
	my $forgotpasswordpage = Test::Class::Selenium::PageObjects::ForgotPasswordPage->new($self);
	$forgotpasswordpage->go_to_forgot_password_page();	
	$forgotpasswordpage->screen_capture("Renter_ForgotPassword", "ForgotPasswordPage");	
	$forgotpasswordpage->enter_email_address($self->{renter_username});
	$forgotpasswordpage->screen_capture("Renter_ForgotPassword", "UsernameEntered");	

}

=head3 renter_login_defaults_to_my_rent

Steps:

=over

=item 1. Sign up with new account

=item 2. Sign out

=item 3. Login

=back

=cut

sub renter_login_defaults_to_my_rent: Test(no_plan)
{

	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	#register
	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$200", "\$400", "2+", $email);		

	#signout
	$landingpage->sign_out();

	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($email, "");		
	
	$loginpage->screen_capture("Renter", "MyRentTab");		
	
}

=head3 renter_login_from_moving_center

Steps:

=over

=item 1. Sign up with new account

=item 2. Sign out

=item 3. Login from moving-center page

=back

=cut
sub renter_login_from_moving_center: Test(no_plan)
{
	
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	#register
	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$200", "\$400", "2+", $email);		

	#signout
	$landingpage->sign_out();
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	
	$loginpage->open_page("/moving-center");
	$loginpage->screen_capture("Renter", "MovingCenterPreLogin");		
	
	$loginpage->sign_in($email, "", "/moving-center");		
	$loginpage->screen_capture("Renter", "MovingCenterPostLogin");		
	
}

=head3 renter_login_100_reward_card

Steps:

=over

=item 1. Sign up with new account

=item 2. Sign out

=item 3. Login from reward card page

=back

=cut
sub renter_login_100_reward_card: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	#register
	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$200", "\$400", "2+", $email);		

	#signout
	$landingpage->sign_out();
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	
	$loginpage->open_page("/service/reward");
	$loginpage->screen_capture("Renter", "RewardPreLogin");		
	
	$loginpage->sign_in($email, "", "/service/reward");		
	$loginpage->screen_capture("Renter", "RewardPostLogin");		

}

1;

}
