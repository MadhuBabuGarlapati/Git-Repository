package Test::Class::Selenium::PageObjects::PLT::ManagerBillingInformation;

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

	BUTTON_SUBMIT => "btn-submit",
	BUTTON_CANCEL => "btn-cancel",
	
	LINK_EDITCC => "link-add-edit",

	DDOWN_CARDTYPE => "creditcard_card_tp",
	TFIELD_CARDNUM => "creditcard_card_number", 
	TFIELD_CIDN => "creditcard_verification_number", 
	DDOWN_EXPMONTH => "creditcard_expiration_dm_month",
	DDOWN_EXPYEAR => "creditcard_expiration_dm_year",

	TFIELD_CC_FNAME => "person_first_name",
	TFIELD_CC_MNAME => "person_middleinitial",
	TFIELD_CC_LNAME => "person_last_name",
	TFIELD_CC_COMPANYNAME => "creditcard_billingcompany_nm",
	TFIELD_CC_ADDRESSONE => "creditcard_billingaddress_nm",
	TFIELD_CC_ADDRESSTWO => "creditcard_billingaddress2_nm",
	TFIELD_CC_CITY => "creditcard_billingcity_nm",
	DDOWN_CC_STATE => "creditcard_billingstate_cd",
	TFIELD_CC_ZIP => "creditcard_billingzip_cd",

	LINK_SIGNIN => "Sign In",
	TFIELD_EMAIL => "email",
	TFIELD_PASSWD => "password",
	BUTTON_SIGIN => "//input[\@type='image']",
	
	BUTTON_MYINFOEDIT => "my-info-edit",
	FRAME_MYINFO => "frame_my_info",
	FRAME_BILLINGINFO => "frame_billing_info"
	
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
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

=over

=item $managerbillinginformation-E<gt>submit_company_info( $company_name, $first_name, $last_name)

Submit edit company information

=cut

sub submit_company_info {
    my ( $self, $company_name ) = @_;
    
	$self->type(TFIELD_COMPANYNAME, $company_name);
	$self->click(BUTTON_SUBMIT);
	$self->wait_for_page_to_load($self->get_page_timeout());
	$self->select_frame("relative=top");	
	$self->wait_for_element_present(BUTTON_MYINFOEDIT, $self->get_page_timeout());

}

=over

=item $managerbillinginformation-E<gt>submit_credit_card( $companyname, $fname, $mname, $lname, $address, $cctype, $ccnumber, $cc_expmonth, $cc_expyea)

Submit edit credit card information

=cut

sub submit_credit_card {
    my ( $self, $companyname, $fname, $mname, $lname, $address, $cctype, $ccnumber, $cc_expmonth, $cc_expyear ) = @_;
    
    $self->fill_credit_card_info($cctype, $ccnumber, $cc_expmonth, $cc_expyear);
    $self->fill_billing_address($companyname, $fname, $mname, $lname, $address);
	$self->click(BUTTON_SUBMIT);
	$self->wait_for_page_to_load($self->get_page_timeout());
	$self->select_frame("relative=top");	
	$self->wait_for_element_present(LINK_EDITCC, $self->get_page_timeout());
 	$self->pause("10000");
}


=item 

=cut

sub fillMailingAddress {
    my ( $self, $company_name ) = @_;
	
	$self->type(TFIELD_COMPANYNAME, $company_name);
	$self->type(TFIELD_ADDRESSONE, "My address 1");
	$self->type(TFIELD_ADDRESSTWO, "My address 2");
	$self->type(TFIELD_CITY, "Los Angeles");
	$self->select(DDOWN_STATE, "label=California");
	$self->type(TFIELD_ZIP, "90503");

};

=item 

=cut
	
sub fillAccountInformation {
	my ( $self, $first_name, $last_name ) = @_;
	
	$self->type(TFIELD_FNAME, $first_name);
	$self->type(TFIELD_LNAME, $last_name);
	$self->type(TFIELD_PHONE, "(657) 657-6745");	
			
}

sub click_submit {
	my ( $self ) = @_;
	
	$self->click(BUTTON_SUBMIT);
	$self->wait_for_page_to_load($self->get_page_timeout());
	
}

=item $managerbillinginformation-E<gt>click_cancel( $companyname, $fname, $mname, $lname, $address, $cctype, $ccnumber, $cc_expmonth, $cc_expyea)

Click cancel on edit pop-up

=cut

sub click_cancel {
	my ( $self ) = @_;
	
	$self->click(BUTTON_CANCEL);
	$self->wait_for_page_to_load($self->get_page_timeout());
	$self->select_frame("relative=top");	
}



sub click_edit_credit_card {
	my ( $self ) = @_;
	
	$self->click(LINK_EDITCC);
	$self->select_frame(FRAME_BILLINGINFO);
	$self->wait_for_element_present(BUTTON_SUBMIT, $self->get_page_timeout());

}

sub click_company_info {
	my ( $self ) = @_;
	
	$self->click("link=".LINK_COMPANYINFO);
	$self->wait_for_page_to_load($self->get_page_timeout());
	
}

sub fill_credit_card_info{
	my ( $self, $cctype, $ccnumber, $cc_expmonth, $cc_expyear ) = @_;
		
	$self->select(DDOWN_CARDTYPE, "label=".$cctype);
	$self->type(TFIELD_CARDNUM, $ccnumber);
	$self->type(TFIELD_CIDN, "215");
	$self->select(DDOWN_EXPMONTH, "label=".$cc_expmonth);
	$self->select(DDOWN_EXPYEAR, "label=".$cc_expyear);	
}

sub fill_billing_address{
	my ( $self, $companyname, $fname, $mname, $lname, $address) = @_;
	
	$self->type(TFIELD_CC_FNAME, $fname);
	$self->type(TFIELD_CC_MNAME, $mname);
	$self->type(TFIELD_CC_LNAME, $lname);
	$self->type(TFIELD_CC_COMPANYNAME, $companyname);
	$self->type(TFIELD_CC_ADDRESSONE, $address);
	$self->type(TFIELD_CC_ADDRESSTWO, "blahstreetaddres2");
	$self->type(TFIELD_CC_CITY, "Los Angeles");
	$self->select(DDOWN_CC_STATE, "label=CA");
	$self->type(TFIELD_CC_ZIP, "90503");
	
}

=over

=item $managerbillinginformation-E<gt>fill_phonenumber( $phonenumber)

Fill phone number information

=cut

sub fill_phonenumber{
	my ($self, $phonenumber) = @_;
	
	$self->type(TFIELD_PHONE, $phonenumber);

=over

=item $managerbillinginformation-E<gt>submit_phonenumber( $phonenumber)

Fill and submit phone number information

=cut

sub submit_phonenumber_company {
	my ($self, $phonenumber, $company_name) = @_;
    
 	$self->type(TFIELD_COMPANYNAME, $company_name);
 	$self->type(TFIELD_PHONE, $phonenumber);
	$self->click(BUTTON_SUBMIT);
	$self->wait_for_page_to_load($self->get_page_timeout());
	$self->select_frame("relative=up");	
	$self->wait_for_text_present($phonenumber);
	$self->open_page("/manage/ppl/credit-card-form");#hardcode refresh
}


sub click_my_info_edit {
	my ( $self ) = @_;
	
	$self->click(BUTTON_MYINFOEDIT);
	$self->select_frame(FRAME_MYINFO);
	$self->wait_for_element_present(BUTTON_SUBMIT, $self->get_page_timeout());

}
	
}

1;

}