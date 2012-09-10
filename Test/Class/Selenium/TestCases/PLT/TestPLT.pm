package Test::Class::Selenium::TestCases::PLT::TestPLT;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

TestPLT - This Test Class is an abstract class that contains PLT page navigation methods

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

sub go_to_plt_page_single_vacancy{
	my($self, $zipcode) = @_;

	$self->go_to_plt();

	my $managepage = Test::Class::Selenium::PageObjects::PLT::ManagePage->new($self);
	
	$managepage->start_plt_singlevacancy($zipcode);

	$managepage->certificate_error_handler();	
	ok($managepage->is_text_present("15 leads in 30 days or get another month free!"), 'Verify PLT Left Nav \'Our Guarantee\'');

}

sub go_to_plt_page_multi_vacancy{
	my($self, $zipcode) = @_;
	
	$self->go_to_plt();

	my $managepage = Test::Class::Selenium::PageObjects::PLT::ManagePage->new($self);
	
	$managepage->start_plt_multivacancy($zipcode);	
	
	$managepage->certificate_error_handler();	
	ok($managepage->is_text_present("15 leads in 30 days or get another month free!"), 'Verify PLT Left Nav \'Our Guarantee\'');
		
}

sub go_to_plt{
	my($self) = @_;
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	$landingpage->wait_for_text_present("Find the latest apartments and homes in seconds", $self->{set_timeout});
	$landingpage->click_list_your_property();
	
	my $managepage = Test::Class::Selenium::PageObjects::PLT::ManagePage->new($self);
	$managepage->wait_for_text_present("Fill Your Vacancy Faster", $self->{set_timeout});	
	
}

sub go_to_plt_page_logged_out{
	my($self) = @_;
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	$landingpage->click_list_your_property();
	
	my $managepage = Test::Class::Selenium::PageObjects::PLT::ManagePage->new($self);
	ok($managepage->is_text_present("Fill Your Vacancy Faster"), 'Verify \'Fill Your Vacancy Faster\' landing page');
	$managepage->start_plt();
	
	$managepage->certificate_error_handler();
	
	ok($managepage->is_text_present("Get 15 leads in 30 days or we'll extend your listing free of charge for 30 more days or until you get 15 leads."), 'Verify PLT left Nav, \'How Rollover Works\'');
		
}

sub go_to_plt_page_logged_in{

my($self) = @_;
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	# For a logged-in user:
	# 1) Assumes user is a PLT Lessor
	# 2) "Manage Your Property" link is displayed
	# $landingpage->click_list_your_property();
	$landingpage->click_manage_your_property();
	
	# Listing Dashboard/Manager Account Page is displayed
	ok($landingpage->is_text_present("Listing Dashboard"),'Verify on Manager Account Page');
	
}

1;

}