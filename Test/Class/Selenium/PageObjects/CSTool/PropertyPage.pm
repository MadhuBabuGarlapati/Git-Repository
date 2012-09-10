package Test::Class::Selenium::PageObjects::CSTool::PropertyPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::CSTool::CSToolBasePage';

use constant {

	TFIELD_PROPERTYID => "search_property_id",
	BUTTON_VIEWPROPERTIES => "//input[\@value='View Properties']",
	LINK_CREATEPROPERTY => "link=CREATE PROPERTY",

};

=head1 NAME

PropertyPage

=head1 SYNOPSIS

Test::Class::Selenium::PageObjects::CSTool::PropertyPage

=head1 DESCRIPTION

This class encapsulates the functionality associated with the CSTool property tab.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $landingpage= Test::Class::Selenium::PageObjects::CSTool::PropertyPage-E<gt>new( %args )

Constructs a new C<Test::Class::Selenium::PageObjects::CSTool::PropertyPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

=item $PropertyPage-E<gt>type_property_id($property_id)

Enter property id information

=cut	

sub type_property_id {
    my ( $self, $property_id ) = @_;

	$self->type(TFIELD_PROPERTYID, $property_id);
};

=item $PropertyPage-E<gt>click_view_property($property_id)

Click view property button

=cut	

sub click_view_properties {
    my ( $self, $property_id ) = @_;

	$self->click(BUTTON_VIEWPROPERTIES);
	$self->wait_for_page_to_load($self->get_page_timeout()); 

};

=item $PropertyPage-E<gt>click_create_property()

Click create property link

=cut	

sub click_create_property {
    my ( $self ) = @_;

	$self->click(LINK_CREATEPROPERTY);
	$self->wait_for_page_to_load($self->get_page_timeout()); 

};

1;

}