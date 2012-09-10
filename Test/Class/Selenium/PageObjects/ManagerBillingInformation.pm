package Test::Class::Selenium::PageObjects::ManagerBillingInformation;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::BasePage;

use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {

	LINK_CREDITCARD => "Credit Card",
	LINK_COMPANYINFO => "Company Information",

	TFIELD_COMPANYNAME => "company_nm",
	TFIELD_ADDRESSONE  => "address_nm",
	TFIELD_ADDRESSTWO => "address2_nm",
	TFIELD_CITY => "city_nm",	
	DDOWN_STATE => "state_cd",
	TFIELD_ZIP => "zip_cd",

	TFIELD_FNAME => "first_name",
	TFIELD_LNAME => "last_name",
	TFIELD_PHONE => "phone",

	BUTTON_SUBMIT => "Submit",
	
	LINK_EDITCC => "edit",

	DDOWN_CARDTYPE => "creditcard_card_tp",
	TFIELD_CARDNUM => "creditcard_card_number", 
	TFIELD_CIDN => "creditcard_verification_number", 
	DDOWN_EXPMONTH => "creditcard_expiration_dm_month",
	DDOWN_EXPYEAR => "creditcard_expiration_dm_year",

	TFIELD_CC_NAME => "creditcard_nameoncard_nm",
	TFIELD_CC_COMPANYNAME => "creditcard_billingcompany_nm",
	TFIELD_CC_ADDRESSONE => "creditcard_billingaddress_nm",
	TFIELD_CC_ADDRESSTWO => "creditcard_billingaddress2_nm",
	TFIELD_CC_CITY => "creditcard_billingcity_nm",
	DDOWN_CC_STATE => "creditcard_billingstate_cd",
	TFIELD_CC_ZIP => "creditcard_billingzip_cd",

	LINK_SIGNIN => "Sign In",
	TFIELD_EMAIL => "email",
	TFIELD_PASSWD => "password",
	BUTTON_SIGIN => "//input[\@type='image']"
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
	
=item $loginpage= pageobjects::LoginPage-E<gt>new( %args )

Constructs a new C<pageobjects::LoginPage> object.

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

=over

=item $managerbillinginformation-E<gt>submit_company_info( $company_name, $first_name, $last_name)

Submit edit company information

=cut

sub submit_company_info {
    my ( $self, $company_name, $first_name, $last_name ) = @_;
    
    $self->fillMailingAddress($company_name);
    $self->fillAccountInformation($first_name, $last_name);
    $self->click_submit();
}

=over

=item $managerbillinginformation-E<gt>submit_credit_card( $companyname, $nameoncard, $address, $cctype, $ccnumber, $cc_expmonth, $cc_expyea)

Submit edit credit card information

=cut

sub submit_credit_card {
    my ( $self, $companyname, $nameoncard, $address, $cctype, $ccnumber, $cc_expmonth, $cc_expyear ) = @_;
    
    $self->fill_credit_card_info($cctype, $ccnumber, $cc_expmonth, $cc_expyear);
    $self->fill_billing_address($companyname, $nameoncard, $address);
    $self->click_submit();
}


=item 

=cut

sub fillMailingAddress {
    my ( $self, $company_name ) = @_;
	
	$self->{selenium}->{browser}->type(TFIELD_COMPANYNAME, $company_name);
	$self->{selenium}->{browser}->type(TFIELD_ADDRESSONE, "My address 1");
	$self->{selenium}->{browser}->type(TFIELD_ADDRESSTWO, "My address 2");
	$self->{selenium}->{browser}->type(TFIELD_CITY, "Los Angeles");
	$self->{selenium}->{browser}->select(DDOWN_STATE, "label=California");
	$self->{selenium}->{browser}->type(TFIELD_ZIP, "90503");

};

=item 

=cut
	
sub fillAccountInformation {
	my ( $self, $first_name, $last_name ) = @_;
	
	$self->{selenium}->{browser}->type(TFIELD_FNAME, $first_name);
	$self->{selenium}->{browser}->type(TFIELD_LNAME, $last_name);
	$self->{selenium}->{browser}->type(TFIELD_PHONE, "(657) 657-6745");	
			
}

sub click_submit {
	my ( $self ) = @_;
	
	$self->{selenium}->{browser}->click(BUTTON_SUBMIT);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());
	
}

sub click_credit_card {
	my ( $self ) = @_;
	
	$self->{selenium}->{browser}->click("link=".LINK_CREDITCARD);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());
	
}

sub click_edit_credit_card {
	my ( $self ) = @_;
	
	$self->{selenium}->{browser}->click("link=".LINK_EDITCC);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());
	
}


sub click_company_info {
	my ( $self ) = @_;
	
	$self->{selenium}->{browser}->click("link=".LINK_COMPANYINFO);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());
	
}

sub click_credit_cardEdit {
	my ( $self ) = @_;
	
	$self->{selenium}->{browser}->click("link=".LINK_EDITCC);
	$self->{selenium}->{browser}->wait_for_page_to_load($self->get_page_timeout());
	
}

sub fill_credit_card_info{
	my ( $self, $cctype, $ccnumber, $cc_expmonth, $cc_expyear ) = @_;
		
	$self->{selenium}->{browser}->select(DDOWN_CARDTYPE, "label=".$cctype);
	$self->{selenium}->{browser}->type(TFIELD_CARDNUM, $ccnumber);
	$self->{selenium}->{browser}->type(TFIELD_CIDN, "123");
	$self->{selenium}->{browser}->select(DDOWN_EXPMONTH, "label=".$cc_expmonth);
	$self->{selenium}->{browser}->select(DDOWN_EXPYEAR, "label=".$cc_expyear);	
}

sub fill_billing_address{
	my ( $self, $companyname, $nameoncard, $address) = @_;
	
	$self->{selenium}->{browser}->type(TFIELD_CC_NAME, $companyname);
	$self->{selenium}->{browser}->type(TFIELD_CC_COMPANYNAME, $nameoncard);
	$self->{selenium}->{browser}->type(TFIELD_CC_ADDRESSONE, $address);
	$self->{selenium}->{browser}->type(TFIELD_CC_ADDRESSTWO, "blachstreetaddres2");
	$self->{selenium}->{browser}->type(TFIELD_CC_CITY, "Los Angeles");
	$self->{selenium}->{browser}->select(DDOWN_CC_STATE, "label=CA");
	$self->{selenium}->{browser}->type(TFIELD_CC_ZIP, "90503");
	
}

1;

}

