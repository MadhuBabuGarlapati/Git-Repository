package Test::Class::Selenium::PageObjects::ManagerAccountPage;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::BasePage;

use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	LINK_VIEWLEADS => "View Leads",
	LINK_LEARNMORE => "Learn More",
	LINK_MYBUDGET => "My Budget",
	LINK_ADDNEWLISTING => "Add New Listing",
	LINK_SELECTLISTINGTOEDIT => "Select Listing to Edit",
	LINK_OVERVIEW => "Overview",
	LINK_BILLINGINFO => "Billing Information",
	LINK_PAYPERLEAD => "Pay-Per-Lead FAQ",
	LINK_REQUESTALEADREVIEW => "Request A Lead Review",
	LINK_CONTACTUS => "Contact Us"
};

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $loginpage= pageobjects::ManagerAccountPage-E<gt>new( %args )

Constructs a new C<pageobjects::ManagerAccountPage> object.

=cut

sub new {
    my ($class, %args) = @_;
    my $self = {    # default args:
       	selenium                 => undef,
       	%args,
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}

=item 

=cut

sub click_view_leads{
    my ( $self ) = @_;

	$self->{selenium}->{browser}->click("link=".LINK_VIEWLEADS);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());

};

sub click_learn_more{
    my ( $self ) = @_;

	$self->{selenium}->{browser}->click("link=".LINK_LEARNMORE);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());

};
	
sub click_my_budget{
    my ( $self ) = @_;

	$self->{selenium}->{browser}->click("link=".LINK_MYBUDGET);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());

};
	
sub click_add_new_listing{
    my ( $self ) = @_;

	$self->{selenium}->{browser}->click("link=".LINK_ADDNEWLISTING);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());

};
	
sub click_select_listing_to_edit{
    my ( $self ) = @_;

	$self->{selenium}->{browser}->click("link=".LINK_SELECTLISTINGTOEDIT);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());

};

sub click_overview{
    my ( $self ) = @_;

	$self->{selenium}->{browser}->click("link=".LINK_OVERVIEW);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());

};



sub click_billing_information {
    my ( $self ) = @_;

	$self->{selenium}->{browser}->click("link=".LINK_BILLINGINFO);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());

};

sub click_pay_per_lead{
    my ( $self ) = @_;

	$self->{selenium}->{browser}->click("link=".LINK_PAYPERLEAD);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());

};
	
sub click_request_a_lead_review{
    my ( $self ) = @_;

	$self->{selenium}->{browser}->click("link=".LINK_REQUESTALEADREVIEW);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());

};
	
=item $loginpage= pageobjects::ManagerAccountPage-E<gt>click_contact_us( )

clicks on 'contact us link, and selects the pop-up window

=cut	
	
sub click_contact_us{
    my ( $self ) = @_;

	$self->{selenium}->{browser}->click("link=".LINK_CONTACTUS);
 	#$self->{selenium}->{browser}->pause("10000");
    #print "======\n".$self->{selenium}->{browser}->get_all_window_ids()."\n======";
    
    
    $self->{selenium}->{browser}->wait_for_pop_up("","60000");
	$self->{selenium}->{browser}->select_window("title=Rent.com: Send a Message");
	$self->{selenium}->{browser}->window_focus();
		

};

1

};