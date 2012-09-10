package Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	
	DDOWN_CCTYPE => "creditcard_card_tp",
	TFIELD_CCNUM => "creditcard_card_number",
	TFIELD_CCIDN => "creditcard_verification_number",
	DDOWN_EXPMONTH => "creditcard_expiration_dm_month",
	DDOWN_EXPYEAR => "creditcard_expiration_dm_year",
	TFIELD_FNAME => "person_first_name",
	TFIELD_MNAME => "person_middleinitial",
	TFIELD_LNAME => "person_last_name",	
	TFIELD_COMPANY => "creditcard_billingcompany_nm",
	TFIELD_STREET => "creditcard_billingaddress_nm",		
	TFIELD_STREETTWO => "creditcard_billingaddress2_nm",
	TFIELD_CITY => "creditcard_billingcity_nm",
	DDOWN_STATE => "creditcard_billingstate_cd",
	TFIELD_ZIP => "creditcard_billingzip_cd",		
	BUTTON_SUBMIT => "//input[\@type='image']",
	BUTTON_MANAGEMYLISTINGS =>"css=div.frm_button > a > img"

};

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

=head2 METHODS

=over

=cut

{	
	
=item $landingpage= pageobjects::LandingPage-E<gt>new( %args )

Constructs a new C<pageobjects::LandingPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

=item $landingpage-E<gt>submit_listing($city, $state, $minprice, $maxprice, $bedrooms, $emailaddress)

Enter form information for new user

=cut	

sub submit_listing {
    my ( $self ) = @_;
    
 	$self->fill_credit_card_information();
 	$self->fill_billing_address();
 	$self->click_submit_listing_button();


};

=item $landingpage-E<gt>submit_listing_existing_user($city, $state, $minprice, $maxprice, $bedrooms, $emailaddress)

Enter form information for existing user

=cut	

sub submit_listing_existing_user{
	my ( $self ) = @_;
	
 	$self->click_submit_listing_button();
 	$self->wait_for_page_to_load($self->get_page_timeout()); 
};
		

sub fill_credit_card_information{
	my ( $self) = @_;
	
	$self->select(DDOWN_CCTYPE , "label=VISA");
	$self->type(TFIELD_CCNUM , "4444444444444448");
	$self->type(TFIELD_CCIDN , "123");
	$self->select(DDOWN_EXPMONTH , "label=Jan");
	$self->select(DDOWN_EXPYEAR , "label=2020");

}

sub fill_billing_address{
	my ( $self) = @_;
	
	#$self->{selenium}->{browser}->type(TFIELD_NAME , "John");
	
	$self->type(TFIELD_FNAME, "fname");
	$self->type(TFIELD_MNAME, "m");
	$self->type(TFIELD_LNAME, "l");
		
	$self->type(TFIELD_COMPANY , "Doe");
	$self->type(TFIELD_STREET , "2425 olympic");
	$self->type(TFIELD_STREETTWO , "400");
	$self->type(TFIELD_CITY , "Santa Monica");
	$self->select(DDOWN_STATE , "label=CA");
	$self->type(TFIELD_ZIP , "90404");		
		
}

sub click_submit_listing_button{
	my ( $self) = @_;
	
	#$self->{selenium}->{browser}->click(BUTTON_SUBMIT);
	$self->click(BUTTON_SUBMIT);
 	$self->wait_for_page_to_load($self->get_page_timeout()); 

}

=item $landingpage-E<gt>click_manage_my_listings()

Click Manage my listings after successfully creating a property listing.

=cut	

sub click_manage_my_listings{
		my ( $self) = @_;

	$self->click(BUTTON_MANAGEMYLISTINGS);
	$self->wait_for_page_to_load($self->get_page_timeout());
	$self->pause("5000");
}

1;

}
