package Test::Class::Selenium::TestCases::Renter::Renter;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::MultivariantTest::OctPage;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::DataAccessObjects::PickDao;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

TestCSTool - This Test Class is an abstract class that contains Renter navigation methods

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{	

=head3 set_homepage_pick_A

Set user homepage experience to pick A

=cut
sub set_homepage_pick_A(){
	my($self) = @_;

	# Set homepage pick
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});

	my $user_id = $pickdao->homepage_get_user_pick_A();

	my $octpage = Test::Class::Selenium::PageObjects::MultivariantTest::OctPage->new($self);
	$octpage->homepage_set_pick($user_id);
	ok($octpage->is_text_present($user_id), 'Verify user pick set to Homepage - Control version');

	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	ok($landingpage->is_text_present($user_id), 'Verify user pick set to Homepage - Control version');
	$landingpage->open('/');
	$landingpage->pause('5000');

}

1;

}