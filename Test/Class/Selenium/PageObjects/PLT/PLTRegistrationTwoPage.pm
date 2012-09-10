package Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	TFIELD_PROPERTYNAME => "Property-editable_property_nm",
	TFIELD_LISTINGHEADLINE => "Property-PropertyAttribute-editable_flashquote_tx",
	TFIELD_PROPERTYDESCRIPTION => "Property-PropertyAttribute-editable_comment_tx",
	LINK_MANAGERHOME => "Managers Home",
	
	#deprecated IB-5259
	#TFIELD_IMAGE =>  "PropertyMainImage",
	
	CHECKBOX_PHOTOSLATER => "photosLater",
	TFIELD_PHONENUMBER => "Property-PropertyContact-contactphone_cd",
	# IB-4506 (Pricing Changes):  May not need to add this field if found that QA-1110 is valid
	TFIELD_EMAIL => "Property-PropertyContact-contactemail_nm",
	
	BUTTON_STEPTHREE => "xpath=(//input[\@type='image'])[2]"

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

=item $landingpage-E<gt>continue_to_step_three($city, $state, $minprice, $maxprice, $bedrooms, $emailaddress)

Enter form information for new user

=cut	

sub continue_to_step_three {
    my ( $self, $filepath, $propertyname, $email, $phonenumber ) = @_;
    
    $self->fill_basic_listing_information($filepath, $propertyname);
    $self->fill_contact_information($email, $phonenumber);
	$self->click(BUTTON_STEPTHREE);
	$self->wait_for_page_to_load($self->get_page_timeout()); 

};
		
sub fill_basic_listing_information {
	my ( $self, $filepath, $propertyname ) = @_;
	
	$self->type(TFIELD_PROPERTYNAME, $propertyname);
	$self->type(TFIELD_LISTINGHEADLINE, "reys headline");
	$self->type(TFIELD_PROPERTYDESCRIPTION, "rey property description");
	#deprecated as per IB-5259
	#$self->type(TFIELD_IMAGE, $filepath );
	$self->click(CHECKBOX_PHOTOSLATER);

};

sub fill_contact_information{
	my ( $self, $email, $phonenumber ) = @_;
	
	$self->type(TFIELD_PHONENUMBER, $phonenumber);
	$self->type(TFIELD_EMAIL, $email);
};

sub click_manager_home_link{
	my ( $self ) = @_;
	
	$self->click("link=".LINK_MANAGERHOME);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

1;

}
