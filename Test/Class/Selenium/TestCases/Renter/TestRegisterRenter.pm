package Test::Class::Selenium::TestCases::Renter::TestRegisterRenter;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Class::Selenium::DataAccessObjects::PickDao;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::Renter::Renter';

=head1 NAME

TestRegisterRenter - This Test Class verifies new registering renters

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 testNewReneter

Verify Register as a new renter	

Test Steps:

=over

=item 1. Go to the main page at rent.com and register a new renter

=item 2. Make sure you have the email account in the following format:  'QATest%@rent.com'"	

=back

Expected Result:

User should be registered successfully and taken to Search Results page

=cut

sub test_new_reneter: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();

	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	# Set homepage pick
	$self->set_homepage_pick_A();
	
	#register
	$landingpage->view_the_latest_listings("Los Angeles", "CA", "\$100", "\$1600", "Studio+", $email);		
	ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify page title is Search');

}



=head3 testDuplicateEmail

Verify User cannot Register with existing email account in the system

Test Steps:

=over

=item 1. Go to the rent.com landing page

=item 2. Enter existing user email when registering

=back

Expected Result:

User cannot register, and following error msg will be displayed: An account has already been created using the email address you've entered.

=cut

sub test_duplicate_email: Test(no_plan)
{
	my($self) = @_;
	
	my $email = $self->{plt_username};
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	# Set homepage pick
	$self->set_homepage_pick_A();

	#register
	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$200", "\$400", "2+", $email);		
	ok($landingpage->is_text_present("An account has already been created using the email address you've entered."), 'Verify user cannot sign up with duplicate email');
}

=head3 test_empty_city

Verify user will recived error msg if city is null

Test Steps:

=over

=item 1. Go to the rent.com landing page

=item 2. Leave city field empty when registering

=back

Expected Result:

The following error msg will be displayed: Please enter a city.

=cut

sub test_empty_city: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	# Set homepage pick
	$self->set_homepage_pick_A();

	#register
	$landingpage->view_the_latest_listings("", "CA", "\$200", "\$400", "2+", $email);		
	ok($landingpage->is_text_present("Please enter a city."), 'Verify empty city message');
}

=head3 test_empty_state

Verify user will recived error msg if state is not selected

Test Steps:

=over

=item 1. Go to the rent.com landing page

=item 2. Leave state field empty when registering

=back

Expected Result:

The following error msg will be displayed: Please choose a state.

=cut

sub test_empty_state: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	# Set homepage pick
	$self->set_homepage_pick_A();

	#register
	$landingpage->view_the_latest_listings("Santa Monica", "--", "\$200", "\$400", "2+", $email);		
	ok($landingpage->is_text_present("Please choose a state."), 'Verify empty state message');
}

=head3 test_empty_city_and_state

Verify user will recived error msg if city and state is not selected

Test Steps:

=over

=item 1. Go to the rent.com landing page

=item 2. Leave city and state field empty when registering

=back


Expected Result:

The following error msg will be displayed: Please enter a city and state.

=cut

sub test_empty_city_and_state: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	# Set homepage pick
	$self->set_homepage_pick_A();

	#register
	$landingpage->view_the_latest_listings("", "--", "\$200", "\$400", "2+", $email);		
	ok($landingpage->is_text_present("Please enter a city and state."), 'Verify empty city and state message');
}

=head3 test_empty_email

Verify user will recived error msg if email address is empty

Test Steps:

=over

=item 1. Go to the rent.com landing page

=item 2. Leave email field empty when registering

=back

Expected Result:

The following error msg will be displayed: Please enter a valid email address (i.e. user\@domain.com).

=cut

sub test_empty_email: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = "";
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	# Set homepage pick
	$self->set_homepage_pick_A();

	#register
	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$200", "\$400", "2+", $email);		
	
	ok($landingpage->is_text_present("Please enter a valid email address (i.e. user\@domain.com)."), 'Verify empty email message');
}


=head3 testIncorrectEmail

Verify user cannot register with an incorrect formatted email address (!#$%)

Test Steps:

=over

=item 1. Go to the rent.com landing page

=item 2. Enter !#$% into email field

=back

Expected Result:

User cannot register, and following error msg will be displayed: Please enter a valid email address (i.e. user@domain.com).

=cut

sub test_incorrect_email: Test(no_plan)
{
	my($self) = @_;
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	$self->set_homepage_pick_A();

	#register - in following step, entering valid data in all the fields except for email address field - entering an incorrect formatted email address 
	$landingpage->view_the_latest_listings("Santa Monica", "CA", "\$200", "\$400", "2+", "!#$%");		
	ok($landingpage->is_text_present("Please enter a valid email address (i.e. user\@domain.com)."), 'Verify user cannot sign up with an incorrect formatted email');
	ok($landingpage->is_text_present("Find the latest apartments and homes in seconds!"), 'Verify "Find the latest apartments and homes in seconds!" text is present on the page');
	ok($landingpage->is_text_present("We offer listings for all residential rentals."), 'Verify "We offer listings for all residential rentals." text is present on the page');
	ok($landingpage->is_element_present("fsubmit"), 'Verify "View the Latest Listings" button is present on the page');
	# $landingpage->pause("5000");
}

1;

}
