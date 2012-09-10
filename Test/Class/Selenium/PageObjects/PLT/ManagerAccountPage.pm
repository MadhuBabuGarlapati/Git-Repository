package Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	LINK_VIEWALLLEADS => "View All Leads",
	LINK_LEARNMORE => "Learn More",
	LINK_LISTINGDASHBOARD => "Listing Dashboard",
	LINK_UPDATERENTS => "dbox_rents1",
	LINK_ADDSPECIALS => "dbox_specials1",
	LINK_ADDPHOTOS => "dbox_photos1",
	LINK_VIEWLEADS => "View Leads",
	LINK_EDITLISTINGSDETAILS => "dbox_overview1",
	LINK_BILLINGINFO => "Billing Information",
	LINK_CONTACTUS => "Contact Us",
	LINK_ADDNEWLISTING => "add listing",
	LINK_RENEWSTATUSCHANGE => "autoRenewBox_",
	LINK_LEADRESPONDER => 'Lead Responder',
	LINK_ACCOUNT => 'Account Profile',
	LINK_CREATELISTING => 'Create Listing',
	RBUTTON_RENEWOFF => "renew0",
	RBUTTON_RENEWONCE => "renew1",
	RBUTTON_RENEWAUTO => "renew2",
	BUTTON_SUBMITRENEWSTATUSCHANGE => "submit_form_changeBoxAutoRenew",
	BUTTON_PLT_SINGLEVACANCY => "name=propTypeZipCodeSubmit",
	TFIELD_PLT_SINGLEVACANCYZIPCODE => "name=propTypeZipCode",
	LINK_PROPERTYOVERVIEW => "Property Overview"
	
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
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

=item 

=cut

sub click_view_all_leads{
    my ( $self ) = @_;

	$self->click("link=".LINK_VIEWALLLEADS);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

sub click_learn_more{
    my ( $self ) = @_;

	$self->click("link=".LINK_LEARNMORE);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

sub click_listing_dashboard{
    my ( $self ) = @_;

	$self->click("link=".LINK_LISTINGDASHBOARD);
	$self->wait_for_page_to_load($self->get_page_timeout());

};
	
sub click_update_rents{
    my ( $self ) = @_;

	$self->click(LINK_UPDATERENTS);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

sub click_add_specials{
    my ( $self ) = @_;

	$self->click(LINK_ADDSPECIALS);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

sub click_add_photos{
    my ( $self ) = @_;

	$self->click(LINK_ADDPHOTOS);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

sub click_view_leads{
    my ( $self ) = @_;

	$self->click("link=".LINK_VIEWLEADS);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

sub click_edit_listing_details{
    my ( $self ) = @_;

	$self->click(LINK_EDITLISTINGSDETAILS);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

sub click_billing_information {
    my ( $self ) = @_;

	$self->click("link=".LINK_BILLINGINFO);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

=item $loginpage= pageobjects::ManagerAccountPage-E<gt>click_contact_us( )

clicks on 'contact us link, and selects the pop-up window

=cut	

sub click_contact_us{
    my ( $self ) = @_;

	$self->click("link=".LINK_CONTACTUS);
 	#$self->pause("10000");
    #print "======\n".$self->{selenium}->{browser}->get_all_window_ids()."\n======";

    $self->{testdriver}->{browser}->wait_for_pop_up("","60000");
	$self->{testdriver}->{browser}->select_window("title=Rent.com: Send a Message");
	$self->{testdriver}->{browser}->window_focus();
		
};

sub click_add_new_listing{
    my ( $self ) = @_;

	$self->click("link=".LINK_ADDNEWLISTING);
	# IB-4506 (Pricing Changes):  wait_for_page_to_load no longer needed, as the 'Add New Listing' popup now appears
	# $self->wait_for_page_to_load($self->get_page_timeout());

};
	
sub click_renew_status_change_link
{
	my ( $self, $property_id ) = @_;
	
	$self->click(LINK_RENEWSTATUSCHANGE.$property_id);
	$self->pause("5000");
	# $self->wait_for_page_to_load($self->get_page_timeout());
}

sub click_renew_option_off
{
	my ( $self ) = @_;
	
	$self->click(RBUTTON_RENEWOFF);
	$self->click(BUTTON_SUBMITRENEWSTATUSCHANGE);
	$self->pause("10000");
}

sub click_renew_option_once
{
	my ( $self ) = @_;
	
	$self->click(RBUTTON_RENEWONCE);
	$self->click(BUTTON_SUBMITRENEWSTATUSCHANGE);
	$self->pause("10000");
}

sub click_renew_option_auto
{
	my ( $self ) = @_;
	
	$self->click(RBUTTON_RENEWAUTO);
	$self->click(BUTTON_SUBMITRENEWSTATUSCHANGE);
	$self->pause("10000");
}

# IB-4506 (Pricing Changes):  new click action defined for PLT button on 'Add Listing' popup
sub click_add_listing_plt_button_singlevacancy
{
	my ( $self, $zipcode ) = @_;
	
	$self->type(TFIELD_PLT_SINGLEVACANCYZIPCODE, $zipcode);
	$self->click(BUTTON_PLT_SINGLEVACANCY);
	$self->wait_for_page_to_load($self->get_page_timeout());

}

sub click_lead_responder
{
	my ( $self ) = @_;
	
	$self->click("link=".LINK_LEADRESPONDER);
	$self->wait_for_page_to_load($self->get_page_timeout());
}

sub click_account
{
	my ( $self ) = @_;
	
	$self->click("link=".LINK_ACCOUNT);
	$self->wait_for_page_to_load($self->get_page_timeout());
}

sub click_create_listing
{
	my ( $self ) = @_;
	
	$self->click("link=".LINK_CREATELISTING);
	$self->pause("5000");
}

sub click_property_overview
{
	my ( $self ) = @_;
	
	$self->click("link=".LINK_PROPERTYOVERVIEW);
	$self->pause("5000");
}

1

};