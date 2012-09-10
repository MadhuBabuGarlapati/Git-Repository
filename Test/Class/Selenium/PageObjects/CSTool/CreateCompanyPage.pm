package Test::Class::Selenium::PageObjects::CSTool::CreateCompanyPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::CSTool::CSToolBasePage';

use constant {

	TFIELD_COMPANYNAME => "company_company_nm",
	BUTTON_CREATE => "//input[\@value='create >>']",
	
	RBUTTON_CC => "//input[\@id='company_billing_tp' and \@name='company_billing_tp' and \@value='Prepaid']",
	BUTTON_SAVE => "//input[\@value='save>>']",
	TFIELD_ADDRESS => "company_billingaddress_nm",
	TFIELD_CITY => "company_billingcity_nm",

};

=head1 NAME

CreateCompanyPage

=head1 SYNOPSIS

Test::Class::Selenium::PageObjects::CSTool::CreateCompanyPage

=head1 DESCRIPTION

This class encapsulates the functionality associated with the CSTool CreateCompanyPage, 
for creating new companies via CSTool insider.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{

=item Test::Class::Selenium::PageObjects::CSTool::CreateCompanyPage-E<gt>new( %args )

Constructs a new C<Test::Class::Selenium::PageObjects::CSTool::CreateCompanyPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

=item CreateCompanyPage-E<gt>fill_company_name()

Fill in company name

=cut	

sub fill_company_name {
    my ( $self, $companyname ) = @_;

	$self->type(TFIELD_COMPANYNAME, $companyname);

};

=item CreateCompanyPage-E<gt>click_create()

Click create, for creation of new company

=cut	

sub click_create {
    my ( $self ) = @_;

	$self->click(BUTTON_CREATE);
	$self->wait_for_page_to_load($self->get_page_timeout()); 

};

=item CreateCompanyPage-E<gt>fill_company_billing_information()

Fill in Company Billing Information

=cut	

sub fill_company_billing_information {
    my ( $self, $address, $city, $state, $zip, $name, $phone ) = @_;

	#$self->click(RBUTTON_CC);
	$self->type(TFIELD_ADDRESS, $address);
	$self->type(TFIELD_CITY, $city);
	$self->select("company_billingstate_cd", "label=".$state);
	$self->type("company_billingzip_cd", $zip);
	$self->type("company_payee_nm", $name);
	$self->type("company_phone_cd", $phone);
	$self->click(BUTTON_SAVE);
	$self->wait_for_page_to_load("30000");

};

1;

}